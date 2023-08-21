package com.example.isfa_crm.receiver

import LogUtils
import PrefsHelper
import android.content.Context
import android.media.MediaRecorder
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.telephony.TelephonyManager
import com.example.isfa_crm.CallRecord
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.IOException


open class CallRecordReceiver(private var callRecord: CallRecord) : PhoneCallReceiver() {

    companion object {
        private val TAG = CallRecordReceiver::class.java.simpleName
        const val ACTION_IN = TelephonyManager.ACTION_PHONE_STATE_CHANGED
        const val ACTION_OUT = "android.intent.action.NEW_OUTGOING_CALL"
        const val EXTRA_PHONE_NUMBER = "android.intent.extra.PHONE_NUMBER"
        private var recorder: MediaRecorder? = null
    }
    private var audioFile: File? = null
    private var isRecordStarted = false
    override fun onIncomingCallReceived(context: Context, start: Long) {

    }

    override fun onIncomingCallAnswered(context: Context, start: Long) {
        startRecord(context, "incoming")
    }

    override fun onIncomingCallEnded(context: Context,start: Long, end: Long) {
        stopRecord(context,end - start)
    }

    override fun onOutgoingCallStarted(context: Context, start: Long) {
        startRecord(context, "outgoing")
    }

    override fun onOutgoingCallEnded(context: Context, start: Long, end: Long) {
        stopRecord(context,end - start)
    }

    override fun onMissedCall(context: Context, start: Long) {
    }

    // Derived classes could override these to respond to specific events of interest
    protected open fun onRecordingStarted(context: Context, callRecord: CallRecord, audioFile: File?) {}

    protected open fun onRecordingFinished(context: Context, callRecord: CallRecord, audioFile1: File?,duration :Long) {
      //  callRecord.stateSaveFile
        Handler(Looper.getMainLooper()).postDelayed({
            if (audioFile?.exists() == true){
                val arguments = HashMap<String, Any>()
                arguments["path"] = audioFile?.absolutePath.toString()
                arguments["duration"] = (duration/1000).toString()
                MethodChannel(callRecord.flutterEngine.dartExecutor.binaryMessenger,
                    "audio_received")
                    .invokeMethod("audioFile", arguments)
            }
        },1000)
    }

    private fun startRecord(context: Context, seed: String) {
        try {
            val isSaveFile = PrefsHelper.readPrefBool(context, CallRecord.PREF_SAVE_FILE)
            LogUtils.i(TAG, "isSaveFile: $isSaveFile")

            // is save file?
            if (!isSaveFile) {
                return
            }
            if (isRecordStarted) {
                try {
                    recorder?.stop()  // stop the recording
                } catch (e: RuntimeException) {
                    // RuntimeException is thrown when stop() is called immediately after start().
                    // In this case the output file is not properly constructed ans should be deleted.
                    LogUtils.d(TAG, "RuntimeException: stop() is called immediately after start()")
                    audioFile?.delete()
                }
                releaseMediaRecorder()
                isRecordStarted = false
            } else {
                if (prepareAudioRecorder(context, seed)) {
                    recorder!!.start()
                    isRecordStarted = true
                    onRecordingStarted(context, callRecord, audioFile)
                    LogUtils.i(TAG, "record start")
                } else {
                    releaseMediaRecorder()
                }
            }
        } catch (e: IllegalStateException) {
            e.printStackTrace()
            releaseMediaRecorder()
        } catch (e: RuntimeException) {
            e.printStackTrace()
            releaseMediaRecorder()
        } catch (e: Exception) {
            e.printStackTrace()
            releaseMediaRecorder()
        }
    }

    private fun stopRecord(context: Context,duration :Long) {
        try {
            if (recorder != null && isRecordStarted) {
                releaseMediaRecorder()
                isRecordStarted = false
                onRecordingFinished(context, callRecord, audioFile,duration)
                LogUtils.i(TAG, "record stop")

            }
        } catch (e: Exception) {
            releaseMediaRecorder()
            e.printStackTrace()
        }
    }

    private fun prepareAudioRecorder(
        context: Context, seed: String
    ): Boolean {
        try {
            var fileName = PrefsHelper.readPrefString(context, CallRecord.PREF_FILE_NAME)
            val dirPath = PrefsHelper.readPrefString(context, CallRecord.PREF_DIR_PATH)
            val dirName = PrefsHelper.readPrefString(context, CallRecord.PREF_DIR_NAME)
            val showSeed = PrefsHelper.readPrefBool(context, CallRecord.PREF_SHOW_SEED)
            val outputFormat = PrefsHelper.readPrefInt(context, CallRecord.PREF_OUTPUT_FORMAT)
            val audioSource = PrefsHelper.readPrefInt(context, CallRecord.PREF_AUDIO_SOURCE)
            val audioEncoder = PrefsHelper.readPrefInt(context, CallRecord.PREF_AUDIO_ENCODER)
            val sampleDir = File("$dirPath/$dirName")
            if (!sampleDir.exists()) {
                sampleDir.mkdirs()
            }
            val fileNameBuilder = StringBuilder()
            fileNameBuilder.append(fileName)
            fileNameBuilder.append("_")

            if (showSeed) {
                fileNameBuilder.append(seed)
                fileNameBuilder.append("_")
            }
            fileName = fileNameBuilder.toString()
            val suffix: String
            when (outputFormat) {
                MediaRecorder.OutputFormat.AMR_NB -> {
                    suffix = ".wav"//".amr"
                }
                MediaRecorder.OutputFormat.AMR_WB -> {
                    suffix = ".wav"//".amr"
                }
                MediaRecorder.OutputFormat.MPEG_4 -> {
                    suffix = ".mp4"
                }
                MediaRecorder.OutputFormat.THREE_GPP -> {
                    suffix = ".3gp"
                }
                MediaRecorder.OutputFormat.MPEG_2_TS -> {
                    suffix = ".mp3"
                }
                else -> {
                    suffix = ".wav"//".amr"
                }
            }

            audioFile = File.createTempFile(fileName, suffix, sampleDir)

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                recorder = MediaRecorder(context)
            }else{
                recorder = MediaRecorder()
            }
            recorder?.apply {
                setAudioSource(audioSource)
                setOutputFormat(outputFormat)
                setAudioEncoder(audioEncoder)
//                 setAudioEncodingBitRate(16);
//                setAudioSamplingRate(44100);
                setOutputFile(audioFile?.absolutePath)
                setOnErrorListener { _, _, _ -> }
            }

            try {
                recorder?.prepare()
            } catch (e: IllegalStateException) {
                LogUtils.d(TAG, "IllegalStateException preparing MediaRecorder: " + e.message)
                releaseMediaRecorder()
                return false
            } catch (e: IOException) {
                LogUtils.d(TAG, "IOException preparing MediaRecorder: " + e.message)
                releaseMediaRecorder()
                return false
            }

            return true
        } catch (e: Exception) {
            LogUtils.e(e)
            e.printStackTrace()
            return false
        }
    }

    private fun releaseMediaRecorder() {
        recorder?.apply {
            reset()
            release()
        }
        recorder = null
    }

}