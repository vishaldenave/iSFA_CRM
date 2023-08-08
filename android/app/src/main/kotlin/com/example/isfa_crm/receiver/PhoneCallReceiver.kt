package com.example.isfa_crm.receiver

import LogUtils
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.telephony.TelephonyManager
import java.util.Date

abstract class PhoneCallReceiver : BroadcastReceiver()   {

    override fun onReceive(context: Context, intent: Intent) {
        //LogUtils.d("Reciver-"+intent.action)
        //We listen to two intents.  The new outgoing call only tells us of an outgoing call.  We use it to get the number.
        if (intent.action == CallRecordReceiver.ACTION_OUT) {
           // savedNumber = intent.extras!!.getString(CallRecordReceiver.EXTRA_PHONE_NUMBER)
        } else {
            val stateStr = intent.extras?.getString(TelephonyManager.EXTRA_STATE)
            var state = 0
            when (stateStr) {
                TelephonyManager.EXTRA_STATE_IDLE -> state = TelephonyManager.CALL_STATE_IDLE
                TelephonyManager.EXTRA_STATE_OFFHOOK -> state = TelephonyManager.CALL_STATE_OFFHOOK
                TelephonyManager.EXTRA_STATE_RINGING -> state = TelephonyManager.CALL_STATE_RINGING
            }
            onCallStateChanged(context, state)
        }
    }

    //Derived classes should override these to respond to specific events of interest
    protected abstract fun onIncomingCallReceived(context: Context, start: Long)

    protected abstract fun onIncomingCallAnswered(context: Context,start: Long)

    protected abstract fun onIncomingCallEnded(
        context: Context, start: Long, end: Long
    )

    protected abstract fun onOutgoingCallStarted(context: Context,start: Long)

    protected abstract fun onOutgoingCallEnded(
        context: Context, start: Long, end: Long
    )

    protected abstract fun onMissedCall(context: Context, start: Long)

    //Deals with actual events

    //Incoming call-  goes from IDLE to RINGING when it rings, to OFFHOOK when it's answered, to IDLE when its hung up
    //Outgoing call-  goes from IDLE to OFFHOOK when it dials out, to IDLE when hung up
    fun onCallStateChanged(context: Context, state: Int) {
        if (lastState == state) {
            //No change, debounce extras
            return
        }

        when (state) {
            TelephonyManager.CALL_STATE_RINGING -> {
                isIncoming = true
                callStartTime = System.currentTimeMillis()
                onIncomingCallReceived(context, callStartTime)
            }
            TelephonyManager.CALL_STATE_OFFHOOK ->
                //Transition of ringing->offhook are pickups of incoming calls.  Nothing done on them
                if (lastState != TelephonyManager.CALL_STATE_RINGING) {
                    isIncoming = false
                    callStartTime =System.currentTimeMillis()

                    onOutgoingCallStarted(context,callStartTime)
                } else {
                    isIncoming = true
                    callStartTime =System.currentTimeMillis()

                    onIncomingCallAnswered(context,callStartTime)
                }
            TelephonyManager.CALL_STATE_IDLE ->
                //Went to idle-  this is the end of a call.  What type depends on previous state(s)
                if (lastState == TelephonyManager.CALL_STATE_RINGING) {
                    //Ring but no pickup-  a miss
                    onMissedCall(context,callStartTime)
                } else if (isIncoming) {
                    onIncomingCallEnded(context,callStartTime, System.currentTimeMillis())
                    callStartTime=0
                } else {
                    onOutgoingCallEnded(context,callStartTime,System.currentTimeMillis())
                    callStartTime=0
                }

        }
        lastState = state
    }

    companion object {
        //The receiver will be recreated whenever android feels like it.  We need a static variable to remember data between instantiations
        private var lastState = TelephonyManager.CALL_STATE_IDLE
        private var callStartTime: Long = 0
        private var isIncoming: Boolean = false
    }
}