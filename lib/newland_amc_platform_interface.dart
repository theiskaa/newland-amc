import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'newland_amc_method_channel.dart';

abstract class NewlandAmcPlatform extends PlatformInterface {
  /// Constructs a NewlandAmcPlatform.
  NewlandAmcPlatform() : super(token: _token);

  static final Object _token = Object();

  static NewlandAmcPlatform _instance = MethodChannelNewlandAmc();

  /// The default instance of [NewlandAmcPlatform] to use.
  ///
  /// Defaults to [MethodChannelNewlandAmc].
  static NewlandAmcPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NewlandAmcPlatform] when
  /// they register themselves.
  static set instance(NewlandAmcPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Triggers the scanner to start scanning
  Future<void> startScanning({
    int? timeout,
    int? scanType,
  }) {
    throw UnimplementedError('startScanning() has not been implemented.');
  }

  /// Stops an ongoing scanning session
  Future<void> stopScanning() {
    throw UnimplementedError('stopScanning() has not been implemented.');
  }

  /// Configures scanner parameters
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
    throw UnimplementedError('configureScannerParams() has not been implemented.');
  }

  /// Stream of barcode scan results
  Stream<ScanResult> get scanResults {
    throw UnimplementedError('scanResults has not been implemented.');
  }
}

/// Represents the result of a barcode scan
class ScanResult {
  final String? barcode1;
  final String? barcode2;
  final int barcodeType;
  final bool isSuccess;

  ScanResult({
    this.barcode1,
    this.barcode2,
    required this.barcodeType,
    required this.isSuccess,
  });

  factory ScanResult.fromMap(Map<String, dynamic> map) {
    return ScanResult(
      barcode1: map['barcode1'] as String?,
      barcode2: map['barcode2'] as String?,
      barcodeType: map['barcodeType'] as int? ?? -1,
      isSuccess: map['scanStatus'] == 'ok',
    );
  }
}
