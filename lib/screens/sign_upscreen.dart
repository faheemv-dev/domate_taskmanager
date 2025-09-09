import 'package:flutter/material.dart';
import 'package:taskmanager/screens/login_screen.dart';
import 'package:taskmanager/services/auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  final TextEditingController _repasscontroller = TextEditingController();
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 26, 51),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Image.asset('assets/images/Bgs.jpg'),

                Text(
                  'Enter the details below:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _emailcontroller,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: Colors.white.withOpacity(1.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _passcontroller,
                  obscureText: _passwordVisible,
                  decoration: InputDecoration(
                    hintText: 'password',
                    filled: true,
                    fillColor: Colors.white.withOpacity(1.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _repasscontroller,
                  obscureText: _passwordVisible,
                  decoration: InputDecoration(
                    hintText: 'Re-enter password',
                    filled: true,
                    fillColor: Colors.white.withOpacity(1.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity, //Button expand
                  child: ElevatedButton(
                    onPressed: () async {
                      final email = _emailcontroller.text.trim();
                      final password = _passcontroller.text.trim();
                      final repass = _repasscontroller.text.trim();
                      if (password != repass) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Two passwords must be same')),
                        );
                        return;
                      }

                      if (email.isEmpty || password.isEmpty || repass.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please Fill all the columns and try again!',
                            ),
                          ),
                        );
                        return;
                      }
                      try {
                        await AuthService().signUpWithEmail(email, password);

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Registeration Successfull!'),
                            ),
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute<LoginScreen>(
                              builder: (BuildContext context) {
                                return LoginScreen();
                              },
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Something went wrong!!')),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<LoginScreen>(
                        builder: (BuildContext context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Back to login page',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
