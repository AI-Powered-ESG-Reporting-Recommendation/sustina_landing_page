import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:suatina_web_project/core/di/service_locator.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/localization/locale_cubit.dart';
import 'package:suatina_web_project/core/responsive/web_scroll_behavior.dart';
import 'package:suatina_web_project/core/routing/app_router.dart';
import 'package:suatina_web_project/core/theme/theme_data/dark_theme_data.dart';
import 'package:suatina_web_project/core/theme/theme_data/light_theme_data.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  // Initialize Core DI singletons (Storage, Network, Connectivity, Cubits)
  await initServiceLocator();

  // Initialize GoRouter
  AppRouter.initRouter();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>.value(value: getIt<ThemeCubit>()),
        BlocProvider<LocaleCubit>.value(value: getIt<LocaleCubit>()),
      ],
      child: const SustinaApp(),
    ),
  );
}

class SustinaApp extends StatelessWidget {
  const SustinaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) {
            final isRtl = locale.languageCode == 'ar';
            return MaterialApp.router(
              title: isRtl
                  ? 'Sustina | منصة إدارة بيانات الاستدامة بالذكاء الاصطناعي'
                  : 'Sustina | AI-Powered ESG & Sustainability Platform',
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouter.router,
              scrollBehavior: const AppScrollBehavior(),
              theme: getLightTheme(context),
              darkTheme: getDarkTheme(context),
              themeMode: themeMode,
              locale: locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              builder: (context, child) {
                return Directionality(
                  textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                  child: child ?? const SizedBox.shrink(),
                );
              },
            );
          },
        );
      },
    );
  }
}
