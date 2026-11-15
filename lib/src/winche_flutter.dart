import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:winche_core/winche_core.dart';

/// Starting Winche in a Flutter app.
abstract final class WincheFlutter {
  /// The options for the platform this runs on, from one set per platform —
  /// what `DefaultWincheOptions.currentPlatform` (written by `winche configure`)
  /// calls.
  ///
  /// Throws an [UnsupportedError] naming the platform when it has none: run
  /// `winche configure` again with it in `--platforms`.
  static WincheOptions select({
    WincheOptions? android,
    WincheOptions? ios,
    WincheOptions? macos,
    WincheOptions? web,
    WincheOptions? windows,
    WincheOptions? linux,
    WincheOptions? fuchsia,
  }) {
    final (name, options) = kIsWeb
        ? ('web', web)
        : switch (defaultTargetPlatform) {
            TargetPlatform.android => ('android', android),
            TargetPlatform.iOS => ('ios', ios),
            TargetPlatform.macOS => ('macos', macos),
            TargetPlatform.windows => ('windows', windows),
            TargetPlatform.linux => ('linux', linux),
            TargetPlatform.fuchsia => ('fuchsia', fuchsia),
          };
    return options ??
        (throw UnsupportedError(
          'There are no Winche options for $name. Run `winche configure --platforms $name,…` '
          'in the app\'s folder to add them to lib/winche_options.dart.',
        ));
  }

  /// [Winche.initializeApp] for Flutter: makes sure the binding is ready, and
  /// gives the SDKs a folder on the device ([defaultDirectory]) unless
  /// [options] names one, so the database's offline cache and storage's upload
  /// queue survive restarts. On the web they use IndexedDB and need none.
  ///
  /// Like [Winche.initializeApp], a second call with the same [name] returns the
  /// same app.
  static Future<WincheApp> initializeApp({String name = Winche.defaultAppName, WincheOptions? options}) async {
    WidgetsFlutterBinding.ensureInitialized();
    final withDirectory = options == null || options.directoryResolver != null || kIsWeb
        ? options
        : options.copyWith(directoryResolver: defaultDirectory);
    return Winche.initializeApp(name: name, options: withDirectory);
  }

  /// Where the Winche SDKs keep their data unless told otherwise: `winche`
  /// under the app's support directory (backed up on iOS and macOS, private
  /// to the app everywhere).
  static Future<String> defaultDirectory() async => '${(await getApplicationSupportDirectory()).path}/winche';
}
