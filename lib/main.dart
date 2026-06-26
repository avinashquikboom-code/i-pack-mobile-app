import 'package:flutter/material.dart';
import 'package:i_pack_mobile_app/config/injection_container.dart';
import 'package:i_pack_mobile_app/core/theme/app_theme.dart';
import 'package:i_pack_mobile_app/presentation/pages/auth/forgot_password_page.dart';
import 'package:i_pack_mobile_app/presentation/pages/auth/login_page.dart';
import 'package:i_pack_mobile_app/presentation/pages/auth/register_page.dart';
import 'package:i_pack_mobile_app/presentation/pages/claims/claims_page.dart';
import 'package:i_pack_mobile_app/presentation/pages/home/home_page.dart';
import 'package:i_pack_mobile_app/presentation/pages/notifications/notifications_page.dart';
import 'package:i_pack_mobile_app/presentation/pages/onboarding/onboarding_page.dart';
import 'package:i_pack_mobile_app/presentation/pages/policies/policies_page.dart';
import 'package:i_pack_mobile_app/presentation/pages/profile/profile_page.dart';
import 'package:i_pack_mobile_app/presentation/pages/splash/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'i-Pack',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/onboarding': (context) => const OnboardingPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/forgot-password': (context) => const ForgotPasswordPage(),
        '/home': (context) => const HomePage(),
        '/notifications': (context) => const NotificationsPage(),
        '/profile': (context) => const ProfilePage(),
        '/policies': (context) => const PoliciesPage(),
        '/claims': (context) => const ClaimsPage(),
      },
    );
  }
}
