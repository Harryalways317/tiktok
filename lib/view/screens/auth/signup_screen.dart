import 'package:flutter/material.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/view/widgets/text_input_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  final TextEditingController user_name_controller = TextEditingController();
  final TextEditingController email_controller = TextEditingController();
  final TextEditingController password_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
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
                "Register",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () => authController.pickImage(),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.black,
                    ),
                    Positioned(
                      child: Icon(Icons.add_a_photo),
                      bottom: -5,
                      left: 80,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                    controller: user_name_controller,
                    labelText: "Username",
                    icon: Icons.person,
                    isObscure: false),
              ),
              SizedBox(
                height: 10,
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
                onTap: () => authController.registerUser(user_name_controller.text, email_controller.text, password_controller.text, authController.profilePhoto),
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                      color: buttonColor, borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      "Register",
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
                    "Already have an account",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 20, color: buttonColor),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
