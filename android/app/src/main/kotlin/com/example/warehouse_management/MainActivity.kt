package com.example.warehouse_management
import android.os.Bundle
import io.flutter.plugin.common.MethodChannel
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    private val CHANNEL = "toast.flutter.io/toast";
override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      call, result ->
      if (call.method == "showToast") {
        val message = call.argument<String>("text")
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
      // Note: this method is invoked on the main thread.
      // TODO
    } else {
      result.notImplemented()
    }
}
}
}
