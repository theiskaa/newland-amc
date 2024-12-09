import 'newland_amc_platform_interface.dart';

/// The main class for interacting with the Newland Scanner.
class NewlandAmc {
  /// Starts the scanner with optional configuration
  ///
  /// [timeout] - Scan timeout in seconds (1-9, default: 3)
  /// [scanType] - Type of scan (1: single barcode, 2: two barcodes)
  Future<void> startScanning({
    int? timeout,
    int? scanType,
  }) {
    return NewlandAmcPlatform.instance.startScanning(
      timeout: timeout,
      scanType: scanType,
    );
  }

  /// Stops an ongoing scanning session
  Future<void> stopScanning() {
    return NewlandAmcPlatform.instance.stopScanning();
  }

  /// Stream of scan results
  ///
  /// Listen to this stream to receive scan results in real-time
  Stream<ScanResult> get scanResults {
    return NewlandAmcPlatform.instance.scanResults;
  }

  /// Configure scanner parameters
  ///
  /// [enabled] - Enable/disable scanner
  /// [triggerMode] - Scanner trigger mode (0: Level, 1: Continuous, 2: Pulse)
  /// [scanMode] - Output mode (1: Fill EditText, 2: Simulate keystroke, 3: Output via API)
  /// [addLineFeed] - Add line feed after scan
  /// [soundNotification] - Enable sound notification
  /// [vibrationNotification] - Enable vibration notification
  /// [ledNotification] - Enable LED notification
  /// [timeout] - Decode session timeout in milliseconds (0-9000)
  /// [interval] - Timeout between decode sessions in milliseconds (>= 50)
  /// [enableFrontScanKey] - Enable front panel scan key
  /// [enableLeftScanKey] - Enable left side scan key
  /// [enableRightScanKey] - Enable right side scan key
  /// [nonRepeatTimeout] - Reread delay in milliseconds
  /// [prefix] - Scan prefix (hex value)
  /// [suffix] - Scan suffix (hex value)
  /// [characterEncoding] - Character encoding (1: UTF-8, 2: GBK, 3: ISO-8859-1)
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
  }) {
    return NewlandAmcPlatform.instance.configureScannerParams(
      enabled: enabled,
      triggerMode: triggerMode,
      scanMode: scanMode,
      addLineFeed: addLineFeed,
      soundNotification: soundNotification,
      vibrationNotification: vibrationNotification,
      ledNotification: ledNotification,
      timeout: timeout,
      interval: interval,
      enableFrontScanKey: enableFrontScanKey,
      enableLeftScanKey: enableLeftScanKey,
      enableRightScanKey: enableRightScanKey,
      nonRepeatTimeout: nonRepeatTimeout,
      prefix: prefix,
      suffix: suffix,
      characterEncoding: characterEncoding,
    );
  }
}
