// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/details/rounded_button.dart';
import 'package:udemy_flutter_sns/details/rounded_text_field.dart';
import 'package:udemy_flutter_sns/details/user_image.dart';
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:udemy_flutter_sns/models/edit_profile_model.dart';
// constants
import 'package:udemy_flutter_sns/models/main_model.dart';

class EditProfilePage extends ConsumerWidget {
  const EditProfilePage({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FirestoreUser firestoreUser = mainModel.firestoreUser;
    final EditProfileModel editProfileModel = ref.watch(editProfileProvider);
    final TextEditingController textEditingController =
        TextEditingController(text: editProfileModel.userName);
    return Scaffold(
      appBar: AppBar(
        title: const Text(editProfilePageTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () async => await editProfileModel.onImageTapped(),
                child: editProfileModel.croppedFile == null
                    ? UserImage(
                        length: 160.0,
                        userImageURL: mainModel.firestoreUser.userImageURL,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(160.0),
                        child: Image.file(editProfileModel.croppedFile!),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: RoundedTextField(
                keyboardType: TextInputType.name,
                onChanged: (value) => editProfileModel.userName = value,
                controller: textEditingController,
                shadowColor: Colors.red.withOpacity(0.3),
                borderColor: Colors.black,
                hintText: firestoreUser.userName,
              ),
            ),
            Center(
              child: RoundedButton(
                  onPressed: () async => await editProfileModel.updateUserInfo(
                      context: context, mainModel: mainModel),
                  widthRate: 0.85,
                  color: Colors.green,
                  text: updateText),
            )
          ],
        ),
      ),
    );
  }
}
