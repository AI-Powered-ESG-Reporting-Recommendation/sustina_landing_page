import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../helpers/shared_pref_helper.dart';

class LocaleCubit extends Cubit<Locale> {
  static const String _localeKey = 'app_locale_code';

  LocaleCubit() : super(const Locale('ar')) {
    _loadSavedLocale();
  }

  void _loadSavedLocale() {
    final savedCode = SharedPrefHelper.getString(key: _localeKey);
    if (savedCode != null && savedCode.isNotEmpty) {
      if (savedCode == 'en') {
        emit(const Locale('en'));
      } else {
        emit(const Locale('ar'));
      }
    }
  }

  Future<void> setLocale(Locale newLocale) async {
    if (state == newLocale) return;
    await SharedPrefHelper.setData(key: _localeKey, value: newLocale.languageCode);
    emit(newLocale);
  }

  Future<void> toggleLocale() async {
    if (state.languageCode == 'ar') {
      await setLocale(const Locale('en'));
    } else {
      await setLocale(const Locale('ar'));
    }
  }

  bool get isArabic => state.languageCode == 'ar';
  bool get isEnglish => state.languageCode == 'en';
}
