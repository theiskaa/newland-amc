# Newland AMC API
This is a Dart interface for the Newland Android Mobile Computer (AMC) API, based on the official Newland Android PDA API Handbook v1.0.4.

This package provides a Flutter/Dart interface to interact with Newland's barcode scanning functionality on Android PDA devices. The implementation uses Android's broadcast mechanism without requiring additional SDKs.

## Features
This plugin provides comprehensive barcode scanning capabilities for Newland Android PDA devices. It enables applications to initiate barcode scanning through broadcast intents and receive the scan results via broadcast receivers. The scanner can be fully configured with parameters like scan timeout duration (1-9 seconds), ability to scan single or multiple barcodes in one session, and power management settings. Users can choose between different trigger modes including Level, Continuous and Pulse, as well as output modes such as direct EditText input, keystroke simulation or API output. The plugin supports a wide range of barcode symbologies and provides real-time monitoring of scanner status.

## Usage
The Newland AMC API provides a straightforward way to implement barcode scanning in your Flutter application. Here's how to get started:

### Basic Setup
First, create an instance of the NewlandAmc scanner:

```dart
final scanner = NewlandAmc();
```

### Initialize Scanner
Configure the scanner with your desired settings. Here's a typical setup:

```dart
await scanner.configureScannerParams(
  enabled: true,
  scanMode: 3, // Output via API
  soundNotification: true,
  vibrationNotification: true,
  ledNotification: true,
  timeout: 5000, // 5 seconds timeout
);
```

### Listen for Scan Results
Set up a listener to handle incoming scan results:

```dart
scanner.scanResults.listen((result) {
  if (result.isSuccess) {
    final barcode = result.barcode1;
    final barcodeType = result.barcodeType;
    // Handle the scanned barcode
  }
});
```

### Control Scanning
Start and stop scanning operations as needed:

```dart
// Start scanning with a 5-second timeout
await scanner.startScanning(timeout: 5);

// Stop scanning
await scanner.stopScanning();
```

For a complete implementation example, check out the example folder in the repository. The example demonstrates a full-featured scanner implementation that includes a user interface for controlling the scanner, displaying scan results in real-time, and handling any errors that occur. It shows how to properly initialize and configure the scanner, process incoming scan results, toggle scanning on/off, and display the scanned barcodes along with their symbology types. The example also implements proper error handling and scanner status management to ensure reliable operation.
