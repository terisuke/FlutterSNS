// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/models/auth/account_model.dart';
import 'package:udemy_flutter_sns/views/auth/components/password_field_and_button_screen.dart';

class ReauthenticationPage extends ConsumerWidget {
  const ReauthenticationPage({
    Key? key,
    required this.accountModel,
  }) : super(key: key);
  final AccountModel accountModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController textEditingController =
        TextEditingController(text: accountModel.password);
    return PasswordFieldAndButtonScreen(
      appbarTitle: reauthenticationPageTitle,
      buttonText: reauthenticateText,
      textEditingController: textEditingController,
      toggleObscureText: () => accountModel.toggleIsObscure(),
      obscureText: accountModel.isObscure,
      shadowColor: Colors.green.withOpacity(0.3),
      buttonColor: Colors.orange.withOpacity(0.5),
      onChanged: (value) => accountModel.password = value,
      onPressed: () async =>
          await accountModel.reauthenticateWithCredential(context: context),
    );
  }
}
