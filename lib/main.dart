import 'package:flutter/material.dart';
import 'app.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'server/mongodb.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://9b29d7565b241af85f77a153b603a612@o4506626150236160.ingest.sentry.io/4506626171338752';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () async {
      WidgetsFlutterBinding
          .ensureInitialized(); // Обязательно для инициализации FlutterBinding перед использованием асинхронного кода

      await MongoDatabase.connect();
      runApp(const App());
    },
  );

  // or define SENTRY_DSN via Dart environment variable (--dart-define)
}
