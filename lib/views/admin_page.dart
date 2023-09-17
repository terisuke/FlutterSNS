// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/details/rounded_button.dart';
// model
import 'package:udemy_flutter_sns/models/admin_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';

class AdminPage extends ConsumerWidget {
  const AdminPage({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AdminModel adminModel = ref.watch(adminProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(adminTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RoundedButton(
              onPressed: () async => await adminModel.admin(),
              widthRate: 0.85,
              color: Colors.blue,
              text: adminTitle,
            ),
          )
        ],
      ),
    );
  }
}
