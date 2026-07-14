import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:wirdul_latif/screens/home_screen/home_screen.dart';
import 'package:wirdul_latif/utils/auth_service.dart';
import 'package:wirdul_latif/utils/colors.dart';
import 'package:wirdul_latif/utils/responsive.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      final userCred = await _authService.signInWithGoogle();
      if (userCred != null && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Google Sign-In failed: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleGuestSignIn() async {
    setState(() => _isLoading = true);
    try {
      await _authService.signInAnonymously();
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Guest Login failed: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;
    
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient matching the app's styling
          Container(
            decoration: BoxDecoration(
              gradient: WirdGradients.listTileShadeGradient,
            ),
          ),
          
          // Outer decorative blur circles for modern premium design
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isTablet ? 550.0 : double.infinity,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      
                      // Shimmering Logo Card
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'asset/logo/logo.png',
                            width: 130.0,
                            height: 130.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                      .animate(onPlay: (controller) => controller.repeat())
                      .shimmer(duration: 2500.ms, color: Colors.white, angle: 0.5)
                      .animate()
                      .scale(delay: 100.ms, duration: 600.ms, curve: Curves.easeOutBack),
                      
                      const SizedBox(height: 24),
                      
                      // App Title & Subtitle
                      Text(
                        'Wirdul Latif Pro',
                        style: TextStyle(
                          color: Colors.yellow[300],
                          fontSize: isTablet ? 36 : 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
                      
                      const SizedBox(height: 8),
                      
                      Text(
                        'Secure your progress and stay consistent with daily dhikr',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: isTablet ? 18 : 14,
                        ),
                      ).animate().fadeIn(delay: 300.ms, duration: 600.ms),
                      
                      const Spacer(),
                      
                      // Auth Buttons container
                      Column(
                        children: [
                          // Continue with Google Button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              minimumSize: const Size(double.infinity, 54),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 2,
                            ),
                            onPressed: _isLoading ? null : _handleGoogleSignIn,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Standard Google Icon drawing
                                Container(
                                  width: 22,
                                  height: 22,
                                  margin: const EdgeInsets.only(right: 12),
                                  child: Image.network(
                                    'https://upload.wikimedia.org/wikipedia/commons/c/c1/Google_%22G%22_logo.svg',
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Icon(Icons.g_mobiledata, color: Colors.blue, size: 24);
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.account_circle, color: Colors.blue, size: 24);
                                    },
                                  ),
                                ),
                                Text(
                                  'Continue with Google',
                                  style: TextStyle(
                                    fontSize: isTablet ? 18 : 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ).animate().slideY(begin: 0.2, delay: 400.ms, duration: 500.ms, curve: Curves.easeOutQuad),
                          
                          const SizedBox(height: 16),
                          
                          // Continue as Guest Button
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white, width: 1.5),
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 54),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: _isLoading ? null : _handleGuestSignIn,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.person_outline, size: 22, color: Colors.white),
                                const SizedBox(width: 12),
                                Text(
                                  'Continue as Guest',
                                  style: TextStyle(
                                    fontSize: isTablet ? 18 : 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ).animate().slideY(begin: 0.2, delay: 500.ms, duration: 500.ms, curve: Curves.easeOutQuad),
                        ],
                      ),
                      
                      const Spacer(),
                      
                      // Footer Privacy notice
                      Text(
                        'By continuing, you agree to secure your progress.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ).animate().fadeIn(delay: 600.ms, duration: 500.ms),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Fullscreen Loading overlay
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
