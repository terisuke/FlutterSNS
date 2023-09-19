// flutter
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
// constants
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;

class ForgetPasswordText extends StatelessWidget {
  const ForgetPasswordText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Center(
        // textでボタンを作成したい場合は、RichText
        child: RichText(
          text: TextSpan(
              style: const TextStyle(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: "パスワードを忘れた場合",
                    style: const TextStyle(color: Colors.lightGreen),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () =>
                          routes.toVerifyPasswordResetPage(context: context))
              ]),
        ),
      ),
    );
  }
}
