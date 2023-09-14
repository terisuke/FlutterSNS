// flutter
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer(
      {Key? key,
      required this.borderColor,
      required this.child,
      required this.shadowColor})
      : super(key: key);
  final Color borderColor;
  final Color shadowColor;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    // これはデバイスのサイズを取得
    final size = MediaQuery.of(context).size;
    //　デバイスの横の長さ
    final double width = size.width;
    // Centerで囲むと真ん中に配置される
    return Center(
      child: Container(
        // marginとは余白のこと
        // symmetricとは対称
        // verticalとは上下
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        width: width * 0.9,
        decoration: BoxDecoration(
            // 全方向にボーダーがつきます
            border: Border.all(color: borderColor),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 8.0,
                offset: const Offset(0, 0),
              )
            ],
            borderRadius: BorderRadius.circular(16.0)),
        child: child,
      ),
    );
  }
}
