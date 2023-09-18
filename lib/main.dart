// flutter
import 'package:flutter/material.dart';
// packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// models
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/sns_bottom_navigation_bar_model.dart';
import 'package:udemy_flutter_sns/models/themes_model.dart';
import 'package:udemy_flutter_sns/views/main/search_page.dart';
// options
import 'firebase_options.dart';
// constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/themes.dart';
// components
import 'package:udemy_flutter_sns/views/main/articles_screen.dart';
import 'package:udemy_flutter_sns/views/auth/verify_email_page.dart';
import 'package:udemy_flutter_sns/details/sns_bottom_navigation_bar.dart';
import 'package:udemy_flutter_sns/views/login_page.dart';
import 'package:udemy_flutter_sns/views/main/home_screen.dart';
import 'package:udemy_flutter_sns/views/main/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // MyAppが起動した最初の時にユーザーがログインしているかどうかの確認
    // この変数を1回きり
    final User? onceUser = FirebaseAuth.instance.currentUser;
    final ThemeModel themeModel = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: themeModel.isDarkTheme
          ? darkThemeData(context: context)
          : lightThemeData(context: context),
      home: onceUser == null
          ? const LoginPage()
          : // ユーザーが存在していない
          onceUser.emailVerified
              ? MyHomePage(
                  themeModel: themeModel,
                ) // ユーザーは存在していて、メールアドレスが認証されている
              : const VerifyEmailPage(), // ユーザーは存在しているが、メールアドレスが認証されていない
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key, required this.themeModel}) : super(key: key);
  final ThemeModel themeModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MainModel mainModel = ref.watch(mainProvider);
    final SNSBottomNavigationBarModel snsBottomNavigationBarModel =
        ref.watch(snsBottomNavigationBarProvider);

    return Scaffold(
      body: mainModel.isLoading
          ? const Center(
              child: Text(loadingText),
            )
          : PageView(
              controller: snsBottomNavigationBarModel.pageController,
              onPageChanged: (index) =>
                  snsBottomNavigationBarModel.onPageChanged(index: index),
              // childrenの個数はElementsの数
              children: [
                // 注意：ページじゃないのでScaffold
                HomeScreen(
                  mainModel: mainModel,
                  themeModel: themeModel,
                ),
                SearchPage(mainModel: mainModel),
                const ArticlesScreen(),
                ProfileScreen(
                  mainModel: mainModel,
                ),
              ],
            ),
      bottomNavigationBar: SNSBottomNavigationBar(
          snsBottomNavigationBarModel: snsBottomNavigationBarModel),
    );
  }
}
