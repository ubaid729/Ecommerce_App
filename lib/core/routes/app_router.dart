import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/routes/app_routes.dart';
import 'package:flutter_application_1/features/auth/views/forgot_password_screen.dart';
import 'package:flutter_application_1/features/auth/views/register_screen.dart';
import 'package:flutter_application_1/features/auth/views/splash_screen.dart';
import 'package:flutter_application_1/features/auth/views/login_screen.dart'; // Apna actual login path dein

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );

      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
          settings: settings,
        );
        case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
          settings: settings,
        );

      default:
        return _errorRoute(settings.name);
        
    }
  }

  // Agar ghalti se koi galat route call ho jaye toh app crash nahi hogi
  static Route<dynamic> _errorRoute(String? routeName) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Text('No route defined for "$routeName"'),
        ),
      ),
    );
  }
}