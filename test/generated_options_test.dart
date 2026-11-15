import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:winche_flutter/winche_flutter.dart';

// Written by `winche configure --platforms android,ios,web` against the emulators.
import 'fixtures/winche_options.dart';

void main() {
  tearDown(() async {
    debugDefaultTargetPlatformOverride = null;
    await Winche.deinitializeAll();
  });

  testWidgets('a generated DefaultWincheOptions starts the app on each platform, and useEmulator redirects it', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    expect(DefaultWincheOptions.currentPlatform, same(DefaultWincheOptions.ios));
    final app = await WincheFlutter.initializeApp(options: DefaultWincheOptions.currentPlatform);
    expect(app.options!.projectId, 'demo');
    expect(app.options!.clientIds['google'], isNotEmpty);
    app.useEmulator(host: '192.168.1.20');
    expect(app.options!.endpointFor('functions', path: '/functions/v1').toString(), 'http://192.168.1.20:9090/functions/v1');

    debugDefaultTargetPlatformOverride = TargetPlatform.linux;
    expect(() => DefaultWincheOptions.currentPlatform, throwsUnsupportedError);
    debugDefaultTargetPlatformOverride = null;   // widget tests must put it back themselves
  });
}
