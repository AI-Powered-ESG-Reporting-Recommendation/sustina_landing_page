export 'generated/app_localizations.dart';

import 'package:flutter/widgets.dart';
import 'generated/app_localizations.dart';

/// Extension on [BuildContext] providing quick access to [AppLocalizations]
/// and locale helper flags.
extension AppLocalizationsBuildContextExtension on BuildContext {
  /// Returns the nearest [AppLocalizations] instance.
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  /// Whether current active locale is Arabic.
  bool get isArabic => Localizations.localeOf(this).languageCode == 'ar';

  /// Whether current active locale is English.
  bool get isEnglish => Localizations.localeOf(this).languageCode == 'en';
}
