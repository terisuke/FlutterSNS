// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/models/auth/update_password_model.dart';
import 'package:udemy_flutter_sns/views/auth/components/password_field_and_button_screen.dart';

class UpdatePasswordPage extends ConsumerWidget {
  const UpdatePasswordPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UpdatePasswordModel updatePasswordModel =
        ref.watch(updatePasswordProvider);
    final TextEditingController textEditingController =
        TextEditingController(text: updatePasswordModel.newPassword);
    return PasswordFieldAndButtonScreen(
        appbarTitle: updatePasswordPageTitle,
        buttonText: updatePasswordText,
        textEditingController: textEditingController,
        toggleObscureText: () => updatePasswordModel.toggleIsObscure(),
        obscureText: updatePasswordModel.isObscure,
        shadowColor: Colors.green.withOpacity(0.3),
        buttonColor: Colors.orange.withOpacity(0.5),
        onChanged: (value) => updatePasswordModel.newPassword = value,
        onPressed: () async =>
            await updatePasswordModel.updatePassword(context: context));
  }
}
