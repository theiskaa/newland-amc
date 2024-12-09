import 'package:flutter/material.dart';
import 'package:newland_amc/newland_amc.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(home: ScannerPage());
}

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final _scanner = NewlandAmc();
  String? _lastScannedCode;
  int? _lastBarcodeType;
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _initializeScanner();
  }

  Future<void> _initializeScanner() async {
    try {
      // Configure scanner with optimal settings
      await _scanner.configureScannerParams(
        enabled: true,
        scanMode: 3, // Output via API
        soundNotification: true,
        vibrationNotification: true,
        ledNotification: true,
        timeout: 5000, // 5 seconds timeout
      );

      // Listen for scan results
      _scanner.scanResults.listen((result) {
        if (result.isSuccess && mounted) {
          setState(() {
            _lastScannedCode = result.barcode1;
            _lastBarcodeType = result.barcodeType;
          });
        }
      });
    } catch (e) {
      debugPrint('Error initializing scanner: $e');
    }
  }

  Future<void> _toggleScanning() async {
    try {
      if (_isScanning) {
        await _scanner.stopScanning();
      } else {
        await _scanner.startScanning(timeout: 5);
      }

      setState(() {
        _isScanning = !_isScanning;
      });
    } catch (e) {
      debugPrint('Error toggling scanner: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Newland Scanner Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_lastScannedCode != null) ...[
              const Text(
                'Last Scanned Code:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                _lastScannedCode!,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16),
              Text(
                'Barcode Type: ${_lastBarcodeType ?? "Unknown"}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
            ],
            ElevatedButton.icon(
              onPressed: _toggleScanning,
              icon: Icon(_isScanning ? Icons.stop : Icons.qr_code_scanner),
              label: Text(_isScanning ? 'Stop Scanning' : 'Start Scanning'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
