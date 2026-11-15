/// Winche for Flutter apps: the options for each platform, as `winche configure`
/// writes them, and where the Winche SDKs keep their data on the device.
///
/// ```dart
/// import 'package:winche_flutter/winche_flutter.dart';
///
/// import 'winche_options.dart';
///
/// Future<void> main() async {
///   final app = await WincheFlutter.initializeApp(options: DefaultWincheOptions.currentPlatform);
///   if (kDebugMode) app.useEmulator();   // `winche emulators start`
///   runApp(const MyApp());
/// }
/// ```
library;

export 'package:winche_core/winche_core.dart';

export 'src/winche_flutter.dart';
