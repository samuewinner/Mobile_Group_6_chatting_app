import 'package:flutter/material.dart';
import 'package:my_chart_app/components/my_button.dart';
import 'package:my_chart_app/components/my_textfield.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  RegisterPage({super.key});

  // Method for registration
  void register(BuildContext context) async {
    final authService = AuthService();

    // if password is same
    if (_pwController.text == _confirmPwController.text) {
      try {
        await authService.signUpWithEmailPassword(
          _emailController.text,
          _pwController.text,
        );
        if (context.mounted) {
          Navigator.pop(context);
        }
      } catch (e) {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(title: Text(e.toString())),
          );
        }
      }
    }
    // if passwordword  is different
    else {
      showDialog(
        context: context,
        builder: (context) =>
            const AlertDialog(title: Text("Password mis-matching")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message, size: 60, color: Colors.grey[800]),
            const SizedBox(height: 50),
            Text(
              "Create account now!",
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
            ),
            const SizedBox(height: 25),

            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(height: 10),

            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _pwController,
            ),
            const SizedBox(height: 10),

            MyTextField(
              hintText: "Confirm Password",
              obscureText: true,
              controller: _confirmPwController,
            ),
            const SizedBox(height: 25),

            MyButton(text: "Register", onTap: () => register(context)),
            const SizedBox(height: 25),
            // The login link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Login now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
