import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:winche_flutter/winche_flutter.dart';

void main() {
  final android = WincheOptions(projectId: 'demo', baseUrl: Uri.parse('https://api.example.com'));
  final ios = WincheOptions(projectId: 'demo', baseUrl: Uri.parse('https://api.example.com'), clientIds: {'google': 'ios-id'});

  tearDown(() async {
    debugDefaultTargetPlatformOverride = null;
    await Winche.deinitializeAll();
  });

  test('select picks the options for the platform this runs on', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    expect(WincheFlutter.select(android: android, ios: ios), same(ios));
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    expect(WincheFlutter.select(android: android, ios: ios), same(android));
  });

  test('a platform without options says how to add them', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.windows;
    expect(() => WincheFlutter.select(android: android),
        throwsA(isA<UnsupportedError>().having((e) => e.message, 'message', contains('winche configure --platforms windows'))));
  });

  testWidgets('initializeApp gives the SDKs a folder on the device, and a second call returns the same app', (tester) async {
    final app = await WincheFlutter.initializeApp(options: android);
    expect(app.options!.directoryResolver, same(WincheFlutter.defaultDirectory));
    expect(app.options!.baseUrl, android.baseUrl);
    expect(identical(await WincheFlutter.initializeApp(options: android), app), isTrue);
  });

  testWidgets('a folder the options name is kept', (tester) async {
    Future<String> mine() async => '/data/mine';
    final app = await WincheFlutter.initializeApp(name: 'own', options: android.copyWith(directoryResolver: mine));
    expect(app.options!.directoryResolver, same(mine));
  });
}
