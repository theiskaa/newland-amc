package com.example.newland_amc

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** NewlandAmcPlugin */
class NewlandAmcPlugin: FlutterPlugin, MethodCallHandler, EventChannel.StreamHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var eventChannel: EventChannel
  private lateinit var context: Context
  private var eventSink: EventChannel.EventSink? = null
  private var scanReceiver: BroadcastReceiver? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "newland_amc")
    eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "newland_amc/scan_results")
    channel.setMethodCallHandler(this)
    eventChannel.setStreamHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "startScanning" -> {
        try {
          val intent = Intent("nlscan.action.SCANNER_TRIG")
          call.argument<Int>("SCAN_TIMEOUT")?.let {
            intent.putExtra("SCAN_TIMEOUT", it)
          }
          call.argument<Int>("SCAN_TYPE")?.let {
            intent.putExtra("SCAN_TYPE", it)
          }
          context.sendBroadcast(intent)
          result.success(null)
        } catch (e: Exception) {
          result.error("SCANNING_ERROR", e.message, null)
        }
      }
      "stopScanning" -> {
        try {
          val intent = Intent("nlscan.action.STOP_SCAN")
          context.sendBroadcast(intent)
          result.success(null)
        } catch (e: Exception) {
          result.error("STOP_SCANNING_ERROR", e.message, null)
        }
      }
      "configureScannerParams" -> {
        try {
          val intent = Intent("ACTION_BAR_SCANCFG")

          // Map all configuration parameters to intent extras
          call.argument<Int>("EXTRA_SCAN_POWER")?.let {
            intent.putExtra("EXTRA_SCAN_POWER", it)
          }
          call.argument<Int>("EXTRA_TRIG_MODE")?.let {
            intent.putExtra("EXTRA_TRIG_MODE", it)
          }
          call.argument<Int>("EXTRA_SCAN_MODE")?.let {
            intent.putExtra("EXTRA_SCAN_MODE", it)
          }
          call.argument<Int>("EXTRA_SCAN_AUTOENT")?.let {
            intent.putExtra("EXTRA_SCAN_AUTOENT", it)
          }
          call.argument<Int>("EXTRA_SCAN_NOTY_SND")?.let {
            intent.putExtra("EXTRA_SCAN_NOTY_SND", it)
          }
          call.argument<Int>("EXTRA_SCAN_NOTY_VIB")?.let {
            intent.putExtra("EXTRA_SCAN_NOTY_VIB", it)
          }
          call.argument<Int>("EXTRA_SCAN_NOTY_LED")?.let {
            intent.putExtra("EXTRA_SCAN_NOTY_LED", it)
          }
          call.argument<Int>("SCAN_TIMEOUT")?.let {
            intent.putExtra("SCAN_TIMEOUT", it.toLong())
          }
          call.argument<Int>("SCAN_INTERVAL")?.let {
            intent.putExtra("SCAN_INTERVAL", it.toLong())
          }

          context.sendBroadcast(intent)
          result.success(null)
        } catch (e: Exception) {
          result.error("CONFIGURATION_ERROR", e.message, null)
        }
      }
      else -> result.notImplemented()
    }
  }

  override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
    eventSink = events
    scanReceiver = object : BroadcastReceiver() {
      override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action == "nlscan.action.SCANNER_RESULT") {
          val result = HashMap<String, Any?>()
          result["barcode1"] = intent.getStringExtra("SCAN_BARCODE1")
          result["barcode2"] = intent.getStringExtra("SCAN_BARCODE2")
          result["barcodeType"] = intent.getIntExtra("SCAN_BARCODE_TYPE", -1)
          result["scanStatus"] = intent.getStringExtra("SCAN_STATE")
          eventSink?.success(result)
        }
      }
    }

    context.registerReceiver(scanReceiver, IntentFilter("nlscan.action.SCANNER_RESULT"))
  }

  override fun onCancel(arguments: Any?) {
    scanReceiver?.let { context.unregisterReceiver(it) }
    scanReceiver = null
    eventSink = null
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    eventChannel.setStreamHandler(null)
  }
}
