// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flash/flash.dart';

void showFlashBar(
    {required BuildContext context,
    required TextEditingController textEditingController,
    required void Function(String)? onChanged,
    required String titleString,
    required Color primaryActionColor,
    required Widget Function(BuildContext, FlashController<Object?>,
            void Function(void Function()))?
        primayActionBuilder}) {
  context.showFlashBar(
    content: Form(
        child: TextFormField(
      controller: textEditingController,
      style: const TextStyle(fontWeight: FontWeight.bold),
      onChanged: onChanged,
      maxLength: 10,
    )),
    title: Text(titleString),
    primaryActionBuilder: primayActionBuilder,
    // 閉じる時の動作
    negativeActionBuilder: (context, controller, _) {
      return InkWell(
        child: const Icon(Icons.close),
        onTap: () async => await controller.dismiss(),
      );
    },
  );
}
