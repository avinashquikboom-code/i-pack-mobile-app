import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:i_pack_mobile_app/core/theme/app_colors.dart';
import 'package:i_pack_mobile_app/presentation/widgets/buttons/primary_button.dart';
import 'package:i_pack_mobile_app/presentation/widgets/navigation/app_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
    });
    
    // Simulate login
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _isLoading = false;
    });
    
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: const AppAppBar(
        title: 'Welcome Back',
        showBackButton: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  
                  // Logo
                  Center(
                    child: Container(
                      width: screenWidth * 0.2,
                      height: screenWidth * 0.2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.tealPrimary,
                            AppColors.tealLight,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: Text(
                          'iP',
                          style: TextStyle(
                            fontSize: screenWidth * 0.08,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ).animate().scale(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.elasticOut,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                
                // Welcome Text
                Text(
                  'Sign in to your account',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: screenWidth * 0.05,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(
                  delay: const Duration(milliseconds: 200),
                ).slideY(
                  begin: 0.3,
                  end: 0,
                  delay: const Duration(milliseconds: 200),
                ),
                SizedBox(height: screenHeight * 0.01),
                
                Text(
                  'Enter your email and password to continue',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    fontSize: screenWidth * 0.04,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(
                  delay: const Duration(milliseconds: 300),
                ),
                SizedBox(height: screenHeight * 0.05),
                
                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email address',
                    prefixIcon: const Icon(Icons.email),
                  ),
                  validator: (value) => null,
                ).animate().fadeIn(
                  delay: const Duration(milliseconds: 400),
                ).slideX(
                  begin: -0.2,
                  end: 0,
                  delay: const Duration(milliseconds: 400),
                ),
                SizedBox(height: screenHeight * 0.02),
                
                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) => null,
                ).animate().fadeIn(
                  delay: const Duration(milliseconds: 500),
                ).slideX(
                  begin: -0.2,
                  end: 0,
                  delay: const Duration(milliseconds: 500),
                ),
                SizedBox(height: screenHeight * 0.01),
                
                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/forgot-password');
                    },
                    child: Text(
                      'Forgot Password?',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: AppColors.tealPrimary,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ),
                ).animate().fadeIn(
                  delay: const Duration(milliseconds: 600),
                ),
                SizedBox(height: screenHeight * 0.03),
                
                // Login Button
                PrimaryButton(
                  text: 'Sign In',
                  onPressed: _handleLogin,
                  isLoading: _isLoading,
                  isFullWidth: true,
                ).animate().fadeIn(
                  delay: const Duration(milliseconds: 700),
                ).scale(
                  begin: const Offset(0.95, 0.95),
                  end: const Offset(1, 1),
                  delay: const Duration(milliseconds: 700),
                ),
                SizedBox(height: screenHeight * 0.02),
                
                // Register Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/register');
                      },
                      child: Text(
                        'Sign Up',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.tealPrimary,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(
                  delay: const Duration(milliseconds: 800),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
