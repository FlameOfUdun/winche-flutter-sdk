// Written by `winche configure` from http://localhost:9090.
// Run it again after adding a platform or a sign-in provider.
//
// ignore_for_file: type=lint
import 'package:winche_flutter/winche_flutter.dart';

/// Winche options for each platform this app runs on, for project `demo`.
///
/// ```dart
/// final app = await WincheFlutter.initializeApp(options: DefaultWincheOptions.currentPlatform);
/// if (kDebugMode) app.useEmulator();   // `winche emulators start`
/// ```
abstract final class DefaultWincheOptions {
  /// The options for the platform this runs on.
  static WincheOptions get currentPlatform => WincheFlutter.select(
        android: android,
        ios: ios,
        web: web,
      );

  static final android = WincheOptions(
    projectId: 'demo',
    baseUrl: Uri.parse('http://localhost:9090'),
    clientIds: {
      'google': 'winche-emulator',
      'apple': 'winche-emulator',
    },
  );

  static final ios = WincheOptions(
    projectId: 'demo',
    baseUrl: Uri.parse('http://localhost:9090'),
    clientIds: {
      'google': 'winche-emulator',
      'apple': 'winche-emulator',
    },
  );

  static final web = WincheOptions(
    projectId: 'demo',
    baseUrl: Uri.parse('http://localhost:9090'),
    clientIds: {
      'google': 'winche-emulator',
      'apple': 'winche-emulator',
    },
  );
}
