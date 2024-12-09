import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'newland_amc_platform_interface.dart';

/// An implementation of [NewlandAmcPlatform] that uses method channels.
class MethodChannelNewlandAmc extends NewlandAmcPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('newland_amc');

  /// The event channel used to receive scan results
  @visibleForTesting
  final eventChannel = const EventChannel('newland_amc/scan_results');

  @override
  Future<void> startScanning({int? timeout, int? scanType}) async {
    final Map<String, dynamic> arguments = {};
    if (timeout != null) arguments['SCAN_TIMEOUT'] = timeout;
    if (scanType != null) arguments['SCAN_TYPE'] = scanType;

    await methodChannel.invokeMethod<void>('startScanning', arguments);
  }

  @override
  Future<void> stopScanning() async {
    await methodChannel.invokeMethod<void>('stopScanning');
  }

  @override
  Future<void> configureScannerParams({
    bool? enabled,
    int? triggerMode,
    int? scanMode,
    bool? addLineFeed,
    bool? soundNotification,
    bool? vibrationNotification,
    bool? ledNotification,
    int? timeout,
    int? interval,
    bool? enableFrontScanKey,
    bool? enableLeftScanKey,
    bool? enableRightScanKey,
    int? nonRepeatTimeout,
    String? prefix,
    String? suffix,
    String? characterEncoding,
  }) async {
    final Map<String, dynamic> arguments = {
      if (enabled != null) 'EXTRA_SCAN_POWER': enabled ? 1 : 0,
      if (triggerMode != null) 'EXTRA_TRIG_MODE': triggerMode,
      if (scanMode != null) 'EXTRA_SCAN_MODE': scanMode,
      if (addLineFeed != null) 'EXTRA_SCAN_AUTOENT': addLineFeed ? 1 : 0,
      if (soundNotification != null) 'EXTRA_SCAN_NOTY_SND': soundNotification ? 1 : 0,
      if (vibrationNotification != null) 'EXTRA_SCAN_NOTY_VIB': vibrationNotification ? 1 : 0,
      if (ledNotification != null) 'EXTRA_SCAN_NOTY_LED': ledNotification ? 1 : 0,
      if (timeout != null) 'SCAN_TIMEOUT': timeout,
      if (interval != null) 'SCAN_INTERVAL': interval,
      if (enableFrontScanKey != null) 'TRIGGER_MODE_MAIN': enableFrontScanKey ? 1 : 0,
      if (enableLeftScanKey != null) 'TRIGGER_MODE_LEFT': enableLeftScanKey ? 1 : 0,
      if (enableRightScanKey != null) 'TRIGGER_MODE_RIGHT': enableRightScanKey ? 1 : 0,
      if (nonRepeatTimeout != null) 'NON_REPEAT_TIMEOUT': nonRepeatTimeout,
      if (prefix != null) 'SCAN_PREFIX': prefix,
      if (suffix != null) 'SCAN_SUFFIX': suffix,
      if (characterEncoding != null) 'SCAN_ENCODE': characterEncoding,
    };

    await methodChannel.invokeMethod<void>('configureScannerParams', arguments);
  }

  @override
  Stream<ScanResult> get scanResults {
    return eventChannel.receiveBroadcastStream().map((dynamic event) {
      final Map<String, dynamic> map = Map<String, dynamic>.from(event as Map);
      return ScanResult.fromMap(map);
    });
  }
}
