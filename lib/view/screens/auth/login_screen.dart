import 'package:flutter/material.dart';

import 'package:tiktok/constants.dart';
import 'package:tiktok/view/screens/auth/signup_screen.dart';
import 'package:tiktok/view/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController email_controller = TextEditingController();
  final TextEditingController password_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "TIKTOK",
              style: TextStyle(
                  color: buttonColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w900),
            ),
            Text(
              "Login",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                  controller: email_controller,
                  labelText: "Email",
                  icon: Icons.email,
                  isObscure: false),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                  controller: password_controller,
                  labelText: "Password",
                  icon: Icons.password,
                  isObscure: true),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () => authController.loginUser(email_controller.text, password_controller.text),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                decoration: BoxDecoration(
                    color: buttonColor, borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignupScreen()));
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 20, color: buttonColor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
