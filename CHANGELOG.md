## 0.1.0

The initial release of the Newland AMC plugin that provides a Flutter interface for Newland Android Mobile Computer devices.

This plugin implements platform-specific code to interact with Newland's barcode scanning functionality including:
- Triggering barcode scans
- Receiving scan results via broadcast receivers
- Configuring scanner settings like timeout, scan type, and symbologies
- Managing scanner power and output modes
- Handling scanner notifications and feedback (sound, vibration, LED)

The plugin uses Android's standard broadcast mechanism to communicate with the Newland scanner APIs, allowing Flutter apps to easily integrate barcode scanning capabilities on supported Newland Android PDA devices.
