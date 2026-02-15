import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  // Color Palette
  final Color _primaryColor = const Color(0xFF7C3AED); // Violent/Purple
  final Color _accentColor = const Color(0xFF2DD4BF); // Teal
  final Color _backgroundColor = const Color(0xFF0F172A); // Dark Slate

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Stack(
        children: [
          // 1. Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1E1B4B), // Dark Indigo
                  _backgroundColor,
                  Color(0xFF312E81), // Indigo
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // 2. Animated Background Shapes (Blobs)
          Positioned(
            top: -100,
            right: -100,
            child: _buildBlur(
              width: 300,
              height: 300,
              color: _primaryColor.withOpacity(0.4),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .scale(duration: 4.seconds, begin: const Offset(1, 1), end: const Offset(1.2, 1.2)),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: _buildBlur(
              width: 250,
              height: 250,
              color: _accentColor.withOpacity(0.3),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .moveY(begin: 0, end: 30, duration: 5.seconds),
          ),

          // 3. Main Content - Centered Card
          Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 450),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.15),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header
                          Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: _primaryColor.withOpacity(0.5),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
                          
                          const SizedBox(height: 8),
                          Text(
                            'Welcome back! Please login to continue',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ).animate().fadeIn(delay: 200.ms),

                          const SizedBox(height: 32),

                          // Input Fields
                          _buildInputFields()
                              .animate()
                              .fadeIn(delay: 400.ms)
                              .slideY(begin: 0.2, end: 0),

                          const SizedBox(height: 24),

                          // Login Button
                          ElevatedButton(
                            onPressed: () {
                              // Login Logic
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: _primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              shadowColor: _primaryColor.withOpacity(0.5),
                              elevation: 8,
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ).animate().fadeIn(delay: 600.ms).scale(begin: const Offset(0.9, 0.9)),

                          const SizedBox(height: 24),

                          // Social Login
                          _buildSocialLogin().animate().fadeIn(delay: 800.ms),

                          const SizedBox(height: 24),

                          // Sign Up Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(color: Colors.white.withOpacity(0.6)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigate to Sign Up
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: _accentColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ).animate().fadeIn(delay: 1000.ms),
                        ],
                      ),
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 300.ms).scale(begin: const Offset(0.95, 0.95)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputFields() {
    return Column(
      children: [
        // Phone Input
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: TextField(
            controller: _phoneController,
            style: const TextStyle(color: Colors.white),
            cursorColor: _accentColor,
            decoration: InputDecoration(
              hintText: 'Phone Number',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
              prefixIcon: Icon(Icons.phone_android_rounded, color: Colors.white.withOpacity(0.6)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Password Input
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            style: const TextStyle(color: Colors.white),
            cursorColor: _accentColor,
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
              prefixIcon: Icon(Icons.lock_rounded, color: Colors.white.withOpacity(0.6)),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: Colors.white.withOpacity(0.4),
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
        
        // Forgot Password
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Forgot Password?',
              style: TextStyle(color: Colors.white.withOpacity(0.5)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLogin() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.white.withOpacity(0.1))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Or login with',
                style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
              ),
            ),
            Expanded(child: Divider(color: Colors.white.withOpacity(0.1))),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialButton(FontAwesomeIcons.google, Colors.redAccent),
            const SizedBox(width: 16),
            _socialButton(FontAwesomeIcons.apple, Colors.white),
            const SizedBox(width: 16),
            _socialButton(FontAwesomeIcons.facebookF, const Color(0xFF1877F2)),
          ],
        ),
      ],
    );
  }

  Widget _socialButton(IconData icon, Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Center(
        child: FaIcon(icon, color: color, size: 20),
      ),
    ).animate(onPlay: (c) => c.repeat(reverse: true))
     .shimmer(duration: 2.seconds, delay: 2.seconds);
  }

  Widget _buildBlur({required double width, required double height, required Color color}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.4),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.6),
            blurRadius: 100,
            spreadRadius: 20,
          ),
        ],
      ),
    );
  }
}
