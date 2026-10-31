import 'package:flutter/widgets.dart';
import 'package:suatina_web_project/core/network/network_failure.dart';

extension EmptyPadding on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
}

extension NetworkFailureMessage on NetworkFailure {
  String get displayMessage => when(
    serverError: (message) =>
        message?.toString() ?? 'Something went wrong. Please try again.',
    timeout: () => 'The request timed out. Please try again.',
    noInternet: () => 'No internet connection. Please check your network.',
    unauthorized: () => "You're not authorized. Please log in again.",
    notFound: () => 'Not found.',
    unknown: (message) => message,
  );
}
