// flutter
import 'package:flutter/material.dart';
// components
import 'package:udemy_flutter_sns/details/rounded_button.dart';
import 'package:udemy_flutter_sns/details/rounded_password_field.dart';

class PasswordFieldAndButtonScreen extends StatelessWidget {
  const PasswordFieldAndButtonScreen(
      {Key? key,
      required this.appbarTitle,
      required this.buttonText,
      required this.textEditingController,
      required this.toggleObscureText,
      required this.obscureText,
      required this.shadowColor,
      required this.buttonColor,
      required this.onChanged,
      required this.onPressed})
      : super(key: key);

  final String appbarTitle, buttonText;
  final TextEditingController textEditingController;
  final void Function()? toggleObscureText;
  final Color shadowColor, buttonColor;
  final bool obscureText;
  final void Function(String)? onChanged;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RoundedPasswordField(
              onChanged: onChanged,
              passwordEditingController: textEditingController,
              obscureText: obscureText,
              toggleObscureText: toggleObscureText,
              borderColor: Colors.black,
              shadowColor: shadowColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 64.0),
            child: RoundedButton(
              onPressed: onPressed,
              widthRate: 0.85,
              color: buttonColor,
              text: buttonText,
            ),
          )
        ],
      ),
    );
  }
}
