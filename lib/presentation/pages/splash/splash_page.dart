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
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with Pulse Animation
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 40,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'iP',
                    style: const TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ).animate()
                    .scale(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.elasticOut,
                    )
                    .then()
                    .shimmer(
                      duration: const Duration(milliseconds: 1500),
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
              ),
              const SizedBox(height: 40),
              
              // App Name with Slide Animation
              Text(
                AppConstants.appName,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  letterSpacing: 2,
                ),
              ).animate()
                  .fadeIn(
                    delay: const Duration(milliseconds: 400),
                    duration: const Duration(milliseconds: 600),
                  )
                  .slideY(
                    begin: 0.3,
                    end: 0,
                    delay: const Duration(milliseconds: 400),
                    duration: const Duration(milliseconds: 600),
                  ),
              const SizedBox(height: 16),
              
              // Tagline with Fade Animation
              Text(
                'Premium Insurance Protection',
                style: TextStyle(
                  fontSize: 18,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ).animate()
                  .fadeIn(
                    delay: const Duration(milliseconds: 600),
                    duration: const Duration(milliseconds: 600),
                  )
                  .slideY(
                    begin: 0.3,
                    end: 0,
                    delay: const Duration(milliseconds: 600),
                    duration: const Duration(milliseconds: 600),
                  ),
              const SizedBox(height: 60),
              
              // Decorative Elements
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDot(isDark)
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 800))
                      .scale(delay: const Duration(milliseconds: 800)),
                  const SizedBox(width: 12),
                  _buildDot(isDark)
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 1000))
                      .scale(delay: const Duration(milliseconds: 1000)),
                  const SizedBox(width: 12),
                  _buildDot(isDark)
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 1200))
                      .scale(delay: const Duration(milliseconds: 1200)),
                ],
              ),
              const SizedBox(height: 80),
              
              // Loading Indicator
              SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ).animate()
                  .fadeIn(
                    delay: const Duration(milliseconds: 1400),
                    duration: const Duration(milliseconds: 400),
                  )
                  .then()
                  .rotate(
                    duration: const Duration(milliseconds: 1500),
                    begin: 0,
                    end: 3.14,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot(bool isDark) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
    );
  }
}
