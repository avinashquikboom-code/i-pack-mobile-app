import 'package:flutter/material.dart';
import 'package:i_pack_mobile_app/core/constants/app_constants.dart';
import 'package:i_pack_mobile_app/core/theme/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.tealPrimary,
                    AppColors.tealLight,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.tealPrimary.withValues(alpha: 0.3),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'iP',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ).animate().scale(
              duration: const Duration(milliseconds: 800),
              curve: Curves.elasticOut,
            ).fadeIn(),
            const SizedBox(height: AppConstants.largeSpacing),
            
            // App Name
            Text(
              AppConstants.appName,
              style: theme.textTheme.displayMedium?.copyWith(
                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(
              delay: const Duration(milliseconds: 300),
            ).slideY(
              begin: 0.3,
              end: 0,
              delay: const Duration(milliseconds: 300),
            ),
            const SizedBox(height: AppConstants.smallSpacing),
            
            // Tagline
            Text(
              'Premium Insurance Protection',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
            ).animate().fadeIn(
              delay: const Duration(milliseconds: 500),
            ).slideY(
              begin: 0.3,
              end: 0,
              delay: const Duration(milliseconds: 500),
            ),
            const SizedBox(height: AppConstants.extraLargeSpacing),
            
            // Loading Indicator
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.tealPrimary),
              ),
            ).animate().fadeIn(
              delay: const Duration(milliseconds: 800),
            ),
          ],
        ),
      ),
    );
  }
}
