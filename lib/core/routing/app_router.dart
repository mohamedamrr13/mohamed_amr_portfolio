import 'package:go_router/go_router.dart';
import 'package:my_portfolio/features/home/presentation/home_screen.dart';

class AppRouter {
  static final String homeScreen = "/homescreen";
  static final router = GoRouter(
    routes: [
      GoRoute(path: homeScreen, builder: (context, state) => HomeScreen()),
    ],
  );
}
