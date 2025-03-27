import 'package:sentry_flutter/sentry_flutter.dart';

class ReportError {
  static void reportErrorSentry(
    Exception exception,
    dynamic stackTrace,
  ) async {
    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
    );
  }
}
