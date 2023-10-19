// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// constants
import 'package:udemy_flutter_sns/constants/strings.dart';
// components
import 'package:udemy_flutter_sns/details/rounded_text_field.dart';
import 'package:udemy_flutter_sns/details/rounded_password_field.dart';
import 'package:udemy_flutter_sns/details/rounded_button.dart';
// models
import 'package:udemy_flutter_sns/models/signup_model.dart';

final Uri _url = Uri.parse('https://fir-flutter-77794.web.app/privacypolicy.html');
class SignupPage extends ConsumerWidget {
  const SignupPage({Key? key}) : super(key: key);
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
    }
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignupModel signupModel = ref.watch(signupProvider);
    final TextEditingController emailEditingController =
        TextEditingController(text: signupModel.email);
    final TextEditingController passwordEditingController =
        TextEditingController(text: signupModel.password);
    return Scaffold(
      appBar: AppBar(
        title: const Text(signupTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundedTextField(
              controller: emailEditingController,
              keyboardType: TextInputType.emailAddress,
              onChanged: (text) => signupModel.email = text,
              borderColor: Colors.black,
              shadowColor: const Color(0xFF77BFA3).withOpacity(0.3),
              hintText: mailAddressText),
          RoundedPasswordField(
              onChanged: (text) => signupModel.password = text,
              passwordEditingController: passwordEditingController,
              obscureText: signupModel.isObscure,
              toggleObscureText: () => signupModel.toggleIsObscure(),
              borderColor: Colors.black,
              shadowColor: const Color(0xFFEDEEC9)),
          RoundedButton(
            onPressed: () async {
              if (emailEditingController.text.isEmpty || passwordEditingController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.emptyform))
                );
                return;
              }
              await signupModel.createUser(context: context);
            },
            widthRate: 0.85,
            color: Colors.red.withOpacity(0.5),
            text: signupText
            ),
          ElevatedButton(onPressed: _launchUrl, child: const Text('Privacy Policy'))
        ],
      ),
    );
  }
}
