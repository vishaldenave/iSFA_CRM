package com.example.isfa_crm

import android.Manifest
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.media.MediaRecorder
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.Settings
import android.text.TextUtils
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    val EVENTS = "audio_recorder"
    private lateinit var callRecord:
            CallRecord

    private fun isAccessibilitySettingsOn(mContext: Context): Boolean {
        var accessibilityEnabled = 0
        val service = packageName + "/" + ServiceAccessibility::class.java.getCanonicalName()
        try {
            accessibilityEnabled = Settings.Secure.getInt(
                mContext.applicationContext.contentResolver,
                Settings.Secure.ACCESSIBILITY_ENABLED
            )
           // Log.d(ContentValues.TAG, "accessibilityEnabled = $accessibilityEnabled")
        } catch (e: Settings.SettingNotFoundException) {
           // Log.e(ContentValues.TAG, "Error finding setting, default accessibility to not found: "+ e.message)
        }
        val mStringColonSplitter = TextUtils.SimpleStringSplitter(':')
        if (accessibilityEnabled == 1) {
           // Log.v(ContentValues.TAG, "***ACCESSIBILITY IS ENABLED*** -----------------")
            val settingValue = Settings.Secure.getString(
                mContext.applicationContext.contentResolver,
                Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES
            )
            if (settingValue != null) {
                mStringColonSplitter.setString(settingValue)
                while (mStringColonSplitter.hasNext()) {
                    val accessibilityService = mStringColonSplitter.next()
//                    Log.v(
//                        ContentValues.TAG,
//                        "-------------- > accessibilityService :: $accessibilityService $service"
//                    )
                    if (accessibilityService.equals(service, ignoreCase = true)) {
//                        Log.v(
//                            ContentValues.TAG,
//                            "We've found the correct setting - accessibility is switched on!"
//                        )
                        return true
                    }
                }
            }
        } else {
           // Timber.
//            LogUtils(TAG, "***ACCESSIBILITY IS DISABLED***")
        }
        return false
    }
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        callRecord = CallRecord.Builder(this)
            .setRecordDirName("Den_CRM")
            .setRecordDirPath(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS).path)
            .setAudioEncoder(MediaRecorder.AudioEncoder.AMR_NB)
            .setOutputFormat(MediaRecorder.OutputFormat.AMR_NB)
            .setAudioSource(MediaRecorder.AudioSource.VOICE_RECOGNITION)
            .setLogEnable(true)
            .setShowSeed(false)
            .setShowPhoneNumber(false)
            .build()
        callRecord.setEngine(flutterEngine);
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            EVENTS
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "start"->{
                    callRecord.startCallReceiver()
                    val name = call.argument<String>("name")
                    val phone = call.argument<String>("phone")
                    callRecord.changeRecordFileName("${name}_${phone}")
                    val intent = Intent(Intent.ACTION_DIAL)
                    intent.data = Uri.parse("tel:${phone}")
                    startActivity(intent)
                }
                "end"->{
                    callRecord.stopCallReceiver()
                }
                "hasAccessibility" -> {
                    if (!isAccessibilitySettingsOn(this)){
                        val openSettings = Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS)//Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS)
                        openSettings.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_NO_HISTORY)
                        startActivity(openSettings)
                        result.success(false)
                    }else{
                        result.success(true)
                    }
                }
                "requestPermission"->{
                    ActivityCompat.requestPermissions(
                        this, arrayOf(
                            Manifest.permission.CALL_PHONE,
                            Manifest.permission.RECORD_AUDIO,
                            Manifest.permission.WRITE_EXTERNAL_STORAGE,
                            Manifest.permission.READ_CALL_LOG
                        ), 1
                    )

//                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
//
//                        ActivityCompat.requestPermissions(
//                            this, arrayOf(
//                                Manifest.permission.READ_PHONE_STATE,
//                                Manifest.permission.CALL_PHONE,
//                                Manifest.permission.RECORD_AUDIO,
//                               // Manifest.permission.READ_MEDIA_AUDIO,
//                                Manifest.permission.READ_CALL_LOG
//                            ), 1
//                        )
//
//                    }else {
//                        ActivityCompat.requestPermissions(
//                            this, arrayOf(
//                                Manifest.permission.CALL_PHONE,
//                                Manifest.permission.RECORD_AUDIO,
//                                Manifest.permission.WRITE_EXTERNAL_STORAGE,
//                                Manifest.permission.READ_CALL_LOG
//                            ), 1
//                        )
//                    }

                }
                "hasPermissions" -> {
                    val hasStoragePerm  =

//                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
//                            context.packageManager.checkPermission(
//                                Manifest.permission.READ_MEDIA_AUDIO,
//                                context.packageName
//                            )
                     //   }else {
                            context.packageManager.checkPermission(
                                Manifest.permission.WRITE_EXTERNAL_STORAGE,
                                context.packageName
                            )
                   //     }

                    val hasRecordPerm  =   context.packageManager.checkPermission(
                        Manifest.permission.RECORD_AUDIO,
                        context.packageName)
                    val hasRecordPermcap  =   context.packageManager.checkPermission(
                        Manifest.permission.READ_CALL_LOG,
                        context.packageName)
                    val hasphonecall  =   context.packageManager.checkPermission(
                        Manifest.permission.CALL_PHONE,
                        context.packageName)

                    val hasPermissions = hasStoragePerm == PackageManager.PERMISSION_GRANTED &&
                            hasRecordPerm == PackageManager.PERMISSION_GRANTED &&
                            hasRecordPermcap == PackageManager.PERMISSION_GRANTED &&
                            hasphonecall == PackageManager.PERMISSION_GRANTED
                    result.success(hasPermissions)
                }
            }
        }
    }

}
