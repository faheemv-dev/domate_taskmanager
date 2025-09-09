import 'package:flutter/material.dart';
import 'package:taskmanager/screens/home_screen.dart';
import 'package:taskmanager/screens/sign_upscreen.dart';
import 'package:taskmanager/services/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscure = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final email = _emailController.text.trim();
    final password = _passController.text.trim();

    try {
      await AuthService().signInWithEmail(email, password);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            // Keep it generic; you can map FirebaseAuthException codes if you want
            'Login failed: ${e is Exception ? e.toString().replaceFirst("Exception: ", "") : "Please check your email/password"}',
          ),
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          SizedBox.expand(
            child: Image.asset('assets/images/Bg1.jpg', fit: BoxFit.cover),
          ),
          // Scrim for readability
          Container(color: Colors.black.withOpacity(0.25)),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Spacer(),
                      // Email
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.email],
                        decoration: InputDecoration(
                          hintText: 'Email',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.email),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Email is required';
                          }
                          final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+$')
                              .hasMatch(v.trim());
                          if (!ok) return 'Enter a valid email';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Password
                      TextFormField(
                        controller: _passController,
                        obscureText: _obscure,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [AutofillHints.password],
                        decoration: InputDecoration(
                          hintText: 'Password',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                                _obscure ? Icons.visibility : Icons.visibility_off),
                            onPressed: () => setState(() {
                              _obscure = !_obscure;
                            }),
                          ),
                        ),
                        onFieldSubmitted: (_) => _signIn(),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Password is required';
                          }
                          if (v.length < 6) {
                            return 'Minimum 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Login button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _signIn,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF0A66C2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Go to Sign up
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: _isLoading
                                ? null
                                : () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const SignupPage()),
                                    );
                                  },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
