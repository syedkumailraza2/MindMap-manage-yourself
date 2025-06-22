import 'package:flutter/material.dart';
import 'package:mindmap/Service/Remote.services.dart';
import 'package:mindmap/Theme/theme.dart';
import 'package:mindmap/Utils/button.dart';
import 'package:mindmap/Utils/inputfield.dart';
import 'package:mindmap/View/home.dart';
import 'package:mindmap/View/login.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cnfpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // center vertically
              crossAxisAlignment:
                  CrossAxisAlignment.center, // center horizontally
              children: [
                Container(
                  width: screenWidth * 0.1,
                  height:
                      screenWidth *
                      0.1, // Ensure both are the same for perfect circle
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle, // <-- This ensures it's a circle
                  ),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: screenWidth * 0.08, // Adjust size as needed
                  ),
                ),

                InputFields(
                  controller: _nameController,
                  label: 'Name',
                  icon: const Icon(Icons.person_2_outlined),
                ),
                const SizedBox(height: 10),
                InputFields(
                  controller: _emailController,
                  label: 'Email',
                  icon: const Icon(Icons.email_outlined),
                ),
                const SizedBox(height: 10),
                InputFields(
                  controller: _passwordController,
                  label: 'Password',
                  icon: const Icon(Icons.lock_outline),
                ),
                const SizedBox(height: 10),
                InputFields(
                  controller: _cnfpasswordController,
                  label: 'Confirm Password',
                  icon: const Icon(Icons.lock_outline),
                ),
                const SizedBox(height: 20),

               CustomButton(
  onPress: () async {
    if (_passwordController.text != _cnfpasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final success = await RemoteServices.register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful! Please login.'),
          backgroundColor: Colors.green,
        ),
      );

      // Wait a moment before redirecting
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration failed'),
          backgroundColor: Colors.red,
        ),
      );
    }
  },
  text: 'Signup',
),

                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: AppColors.primary,
                        endIndent: 10, // space between divider and text
                      ),
                    ),
                    const Text(
                      'Or Continue with',
                      style: TextStyle(color: AppColors.primary),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: AppColors.primary,
                        indent: 10, // space between text and divider
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
               GestureDetector(
  onTap: () async {
    final userCredential = await RemoteServices.signinGoogle();

    if (userCredential != null) {
      // TODO: Optional: Navigate to Home screen or store user data
      print('✅ Google Sign-In successful!');
      print('user Credential: $userCredential');
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
    } else {
      print('❌ Google Sign-In failed or cancelled');
    }
  },
  child: Image.asset('assets/continue_google.png'),
),

                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
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
