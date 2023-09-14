// flutter
import 'package:flutter/material.dart';
// components
import 'package:udemy_flutter_sns/details/card_container.dart';
// domain
import 'package:udemy_flutter_sns/domain/comment/comment.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final Comment comment;
  @override
  Widget build(BuildContext context) {
    return CardContainer(
        borderColor: Colors.green,
        child: ListTile(
          title: Text(comment.comment),
        ));
  }
}
