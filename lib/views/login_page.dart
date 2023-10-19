// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/details/forget_password_text.dart';
import 'package:url_launcher/url_launcher.dart';
// components
import 'package:udemy_flutter_sns/details/rounded_text_field.dart';
import 'package:udemy_flutter_sns/details/rounded_password_field.dart';
import 'package:udemy_flutter_sns/details/rounded_button.dart';
// model
import 'package:udemy_flutter_sns/models/login_model.dart';
// constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;

final Uri _url = Uri.parse('https://fir-flutter-77794.web.app/privacypolicy.html');
class LoginPage extends ConsumerWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoginModel loginModel = ref.watch(loginProvider);
    final TextEditingController emailEditingController =
        TextEditingController(text: loginModel.email);
    final TextEditingController passwordEditingController =
        TextEditingController(text: loginModel.password);
    return Scaffold(
      appBar: AppBar(
        title: const Text(loginTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundedTextField(
              controller: emailEditingController,
              keyboardType: TextInputType.emailAddress,
              onChanged: (text) => loginModel.email = text,
              borderColor: Colors.black,
              shadowColor: Colors.red.withOpacity(0.3),
              hintText: mailAddressText),
          RoundedPasswordField(
            onChanged: (text) => loginModel.password = text,
            passwordEditingController: passwordEditingController,
            obscureText: loginModel.isObscure,
            toggleObscureText: () => loginModel.toggleIsObscure(),
            borderColor: Colors.black,
            shadowColor: Colors.blue.withOpacity(0.3),
          ),
          RoundedButton(
              onPressed: () async => await loginModel.login(context: context),
              widthRate: 0.85,
              color: Colors.green,
              text: loginText),
          TextButton(
              onPressed: () => routes.toSignupPage(context: context),
              child: const Text(noAccountMsg)),
          const ForgetPasswordText(),
          ElevatedButton(onPressed: _launchUrl, child: const Text('Privacy Policy'))
        ],
      ),
    );
  }
}
