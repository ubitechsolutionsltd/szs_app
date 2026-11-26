package com.simulizi.ruhundwa

import android.Manifest
import android.content.pm.PackageManager
import android.os.Build
import com.ryanheise.audioservice.AudioServiceActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : AudioServiceActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Android 13+ hides the playback notification (and its lock-screen controls) until the user has granted
        // POST_NOTIFICATIONS, so the app asks for it the first time something plays.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "szs/notifications")
            .setMethodCallHandler { call, result ->
                if (call.method == "requestPermission") {
                    if (Build.VERSION.SDK_INT >= 33 &&
                        checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) != PackageManager.PERMISSION_GRANTED
                    ) {
                        requestPermissions(arrayOf(Manifest.permission.POST_NOTIFICATIONS), 4711)
                    }
                    result.success(true)
                } else {
                    result.notImplemented()
                }
            }
    }
}
