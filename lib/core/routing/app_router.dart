import 'package:suatina_web_project/core/routing/routes.dart';
import 'package:suatina_web_project/core/utils/common_imports.dart';

abstract class AppRouter {
  static late final GoRouter router;

  static void initRouter() {
    router = GoRouter(initialLocation: Routes.splash, routes: [
       
      ],
    );
  }
}
