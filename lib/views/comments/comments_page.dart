// flutter
import 'package:flutter/material.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/details/reload_screen.dart';
import 'package:udemy_flutter_sns/details/rounded_button.dart';
import 'package:udemy_flutter_sns/domain/comment/comment.dart';
// domains
import 'package:udemy_flutter_sns/domain/post/post.dart';
import 'package:udemy_flutter_sns/models/comments_model.dart';
// models
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/views/refresh_screen.dart';

class CommentsPage extends ConsumerWidget {
  const CommentsPage(
      {Key? key,
      required this.post,
      required this.postDoc,
      required this.mainModel})
      : super(key: key);

  final Post post;
  final DocumentSnapshot<Map<String, dynamic>> postDoc;
  final MainModel mainModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CommentsModel commentsModel = ref.watch(commentsProvider);
    final commentDocs = commentsModel.commentDocs;
    return Scaffold(
      appBar: AppBar(title: const Text(commentTitle)),
      body: commentDocs.isEmpty
          ? ReloadScreen(
              onReload: () async =>
                  await commentsModel.onReload(postDoc: postDoc))
          : RefreshScreen(
              onRefresh: () async =>
                  await commentsModel.onRefresh(postDoc: postDoc),
              onLoading: () async => commentsModel.onLoading(postDoc: postDoc),
              refreshController: commentsModel.refreshController,
              child: ListView.builder(
                  itemCount: commentDocs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final commentDoc = commentDocs[index];
                    final Comment comment =
                        Comment.fromJson(commentDoc.data()!);
                    return Container();
                  })),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: const Icon(Icons.new_label),
          onPressed: () => commentsModel.showCommentFlashBar(
              context: context, mainModel: mainModel, postDoc: postDoc)),
    );
  }
}
