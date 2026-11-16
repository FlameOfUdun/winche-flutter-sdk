# winche_flutter

Start [Winche](https://github.com/FlameOfUdun) in a Flutter app: one call, with the options `winche configure` writes.

## 1. Add the package

```sh
flutter pub add winche_flutter
```

Then the Winche packages you use, for example:

```sh
flutter pub add winche_auth winche_database winche_storage winche_functions
```

## 2. Write `lib/winche_options.dart`

In your app's folder, with the [Winche CLI](https://github.com/FlameOfUdun/winche-cli):

```sh
winche configure --url https://api.example.com --app app-xxxxxxxxxxxx   # or no --url: the emulators on localhost:9090
```

It asks the server what it runs (its public `/.well-known/winche`) and writes a `DefaultWincheOptions` for each
platform folder the app has (`--platforms android,ios,web` to choose, `--out` to write elsewhere). `--app` is the
app's id from the console (Project settings → Your apps); it goes in the file as `appId`. For one project on a
Winche Server with several, add `--project <id>`. The console's Project settings → Your apps offers the same file to
download.

## 3. Start Winche in `main()`

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:winche_flutter/winche_flutter.dart';

import 'winche_options.dart';

Future<void> main() async {
  final app = await WincheFlutter.initializeApp(options: DefaultWincheOptions.currentPlatform);
  if (kDebugMode) app.useEmulator();   // only with `winche emulators start` running
  runApp(const MyApp());
}
```

- **`WincheFlutter.initializeApp`** makes sure Flutter's binding is ready and gives the SDKs a folder on the device
  (`winche` under the app support directory), so the database's offline cache and storage's upload queue survive
  restarts. Pass `directoryResolver` in the options to choose another; on the web they use IndexedDB.
- **`app.useEmulator()`** sends that app's services to the local emulators; on Android `localhost` becomes `10.0.2.2`.
  Call it before using any service. `only: {'database'}` redirects just some.
- **`WincheFlutter.select(android: …, ios: …, …)`** is what `currentPlatform` calls; a platform with no options throws
  and says to run `winche configure --platforms <it>`.

`winche_flutter` re-exports `winche_core`, so one import is enough.
