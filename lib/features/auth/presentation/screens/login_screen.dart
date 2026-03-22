import 'package:flutter/material.dart';
import 'package:news_intelligence_app/core/constants/uiconfigs/themes/custom_text_theme.dart';
import 'package:news_intelligence_app/core/constants/uiconfigs/colors.dart';
import 'package:news_intelligence_app/features/news/presentation/news_screen.dart';
import 'package:news_intelligence_app/shared/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 150.0), // Add space from top
                Text(
                  'Login Screen',
                  style: context.heading2BoldMedium,
                ),
              const SizedBox(height: 80.0),
              CustomTextFormField(
                labelText: 'Username',
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                labelText: 'Password',
                obscureText: true,
              ),
                SizedBox(height: 22.0),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NewsScreen()),
                    );
                  },
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(200, 48), // Increased width to 200
                    ),
                    onPressed: () {
                      // Handle login logic here
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
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
