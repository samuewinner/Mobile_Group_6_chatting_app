import '../services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:my_chart_app/components/my_button.dart';
import 'package:my_chart_app/components/my_textfield.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  //The contoller for password and the email
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  LoginPage({super.key});

  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _pwController.text,
      );
      debugPrint("login successfull! ");
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(title: Text("Error"), content: Text(e.toString())),
        );
      }
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
            //The logo
            Icon(Icons.message, size: 60, color: Colors.grey[800]),
            const SizedBox(height: 50),
            // The welcome message
            Text(
              "welcome back, chat with friends!",
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
            ),
            const SizedBox(height: 25),
            // The email textfield
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(height: 10),
            // the pw textfield
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _pwController,
            ),
            const SizedBox(height: 25),
            // The login button
            MyButton(text: "Login", onTap: () => login(context)),
            const SizedBox(height: 25),
            // The registration
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't you have an account? ",
                  style: TextStyle(color: Colors.grey[700]),
                ),
                GestureDetector(
                  onTap: () {
                    debugPrint("Register Page!");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text(
                    "Register now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
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
