// flutter
import 'package:flash/flash_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/flash.dart';
import 'package:fluttertoast/fluttertoast.dart' as fluttertoast;
import 'package:udemy_flutter_sns/constants/bools.dart';
import 'package:udemy_flutter_sns/constants/strings.dart';
Function func = () {
  
};
void showFlash(
    {required BuildContext context,
    required TextEditingController textEditingController,
    required void Function(String)? onChanged,
    required String titleString,
    required Color primaryActionColor,
    required Widget Function(BuildContext, FlashController<Object?>,
            void Function(void Function()))?
        primaryActionBuilder}) {
    context.showFlash(
    builder: (context, controller) {
      return FlashBar(
        controller: controller,
        content: Form(
          child: TextFormField(
            controller: textEditingController,
            style: const TextStyle(fontWeight: FontWeight.bold),
            onChanged: onChanged, // onChangedは外部から渡された関数を指定しています
            maxLength: 10,
          ),
        ),
        title: Text(titleString), // titleStringは外部から渡された変数を指定しています
        actions: [
          if (primaryActionBuilder != null)
            primaryActionBuilder(context, controller,
                func()), // primaryActionBuilderは外部から渡された関数を指定しています
          InkWell(
            child: const Icon(Icons.close),
            onTap: () async => await controller.dismiss(),
          ),
        ],
      );
    },
    persistent: true, // persistentプロパティは元のコードに基づいて設定されています
  );
  }

// onRefreshの内部
  Future<void> processNewDocs(
      {required List<String> muteUids,
      required List<String> mutePostIds,
      required List<DocumentSnapshot<Map<String, dynamic>>> docs,
      required Query<Map<String, dynamic>> query}) async {
    if (docs.isNotEmpty) {
      final qshot = await query.limit(30).endBeforeDocument(docs.first).get();
      final reversed = qshot.docs.reversed.toList();
      for (final doc in reversed) {
        // 正しいユーザーかどうかの処理と、重複処理
        final map = doc.data();
        if (isValidUser(muteUids: muteUids, map: map) &&
            !reversed.contains(doc) &&
            isValidPost(mutePostIds: mutePostIds, map: map))
          docs.insert(0, doc);
      }
    }
  }

// onReloadの内部
  Future<void> processBasicDocs(
      {required List<String> muteUids,
      required List<String> mutePostIds,
      required List<DocumentSnapshot<Map<String, dynamic>>> docs,
      required Query<Map<String, dynamic>> query}) async {
    final qshot = await query.limit(30).get();
    final basicDocs = qshot.docs;
    docs.removeWhere((element) => true); // 中身を全部削除
    for (final doc in basicDocs) {
      final map = doc.data();
      if (isValidUser(muteUids: muteUids, map: map) &&
          !docs.contains(doc) &&
          isValidPost(mutePostIds: mutePostIds, map: map)) docs.add(doc);
    }
  }

// onLoadingの内部
  Future<void> processOldDocs(
      {required List<String> muteUids,
      required List<String> mutePostIds,
      required List<DocumentSnapshot<Map<String, dynamic>>> docs,
      required Query<Map<String, dynamic>> query}) async {
    if (docs.isNotEmpty) {
      final qshot = await query.limit(30).startAfterDocument(docs.last).get();
      final oldDocs = qshot.docs;
      for (final doc in oldDocs) {
        final map = doc.data();
        if (isValidUser(muteUids: muteUids, map: map) &&
            !docs.contains(doc) &&
            isValidPost(mutePostIds: mutePostIds, map: map)) docs.add(doc);
      }
    }
  }

  void showPopup(
      {required BuildContext context,
      required Widget Function(BuildContext) builder}) {
    showCupertinoModalPopup(context: context, builder: builder);
  }
  void showFlashBar(
    {required BuildContext context,
    required TextEditingController textEditingController,
    required void Function(String)? onChanged,
    required String titleString,
    required Color primaryActionColor,
    required Widget Function(BuildContext, FlashController<Object?>,
            void Function(void Function()))?
        primaryActionBuilder}) {
 context.showFlash(
    builder: (context, controller) {
      return FlashBar(
        controller: controller,
        title: Text(titleString),
        content: Form(
          child: TextFormField(
            controller: textEditingController,
            style: const TextStyle(fontWeight: FontWeight.bold),
            onChanged: onChanged,
            maxLength: 10,
          ),
        ),
        actions: [
          if (primaryActionBuilder != null)
            primaryActionBuilder(context, controller, func()),
          InkWell(
            child: const Icon(Icons.close),
            onTap: () async => await controller.dismiss(),
          ),
        ],
      );
    },
    persistent: true, // 必要に応じてpersistent属性を設定してください
  );
 
}
  Future<void> showFluttertoast({required String msg}) async {
try {
        await fluttertoast.Fluttertoast.showToast(
            msg: msg,
            toastLength: fluttertoast.Toast.LENGTH_SHORT,
            gravity: fluttertoast.ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.purple,
            textColor: Colors.white,
            fontSize: 16.0);
    } catch (e) {
        print("Error in showToast: $e");  // エラーログ追加
    }
}

  void showFlashDialog(
      {required BuildContext context,
      required Widget content,
      required Widget Function(BuildContext, FlashController<Object?>,
              void Function(void Function()))?
          positiveActionBuilder}) {
    context.showFlash(
    builder: (context, controller) {
      return FlashBar(
        controller: controller,
        content: content,
        actions: [
          (positiveActionBuilder != null) ?
            positiveActionBuilder(context, controller, func()):
          TextButton(
            onPressed: () async => await controller.dismiss(),
            child: const Text(backText),
          ),
        ],
      );
    },
    persistent: true, // 必要に応じてpersistent属性を設定してください
  );

  }
