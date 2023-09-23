//dart
import 'dart:async';
// flutter
import 'package:flutter/material.dart';
// packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
// models
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/mute_users_model.dart';
import 'package:udemy_flutter_sns/models/sns_bottom_navigation_bar_model.dart';
import 'package:udemy_flutter_sns/models/themes_model.dart';
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
import 'package:udemy_flutter_sns/views/main/search_page.dart';
import 'package:udemy_flutter_sns/views/main/profile_screen.dart'; // CupertinoWidgetsのためにimport追加

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load();
    await Firebase.initializeApp(); // ここでFirebaseを初期化します。
    runApp(const ProviderScope(child: MyApp()));
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance
        .recordError(error, stackTrace); // ここで初期化されたFirebaseCrashlyticsを使用します。
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrong();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          FlutterError.onError =
              FirebaseCrashlytics.instance.recordFlutterError;
          final User? onceUser = FirebaseAuth.instance.currentUser;
          final ThemeModel themeModel = ref.watch(themeProvider);
          return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            title: appTitle,
            theme: themeModel.isDarkTheme
                ? darkThemeData(context: context)
                : lightThemeData(context: context),
            home: onceUser == null
                ? const LoginPage()
                : onceUser.emailVerified
                    ? MyHomePage(
                        themeModel: themeModel,
                      )
                    : const VerifyEmailPage(),
          );
        }

        return Loading();
      },
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Something went wrong!'),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key, required this.themeModel}) : super(key: key);
  final ThemeModel themeModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // MainModelが起動し、init()が実行されます
    final MainModel mainModel = ref.watch(mainProvider);
    final SNSBottomNavigationBarModel snsBottomNavigationBarModel =
        ref.watch(snsBottomNavigationBarProvider);
    return Scaffold(
      body: mainModel.isLoading
          ? Center(
              child: Text(returnL10n(context: context)!.loading),
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
                  themeModel: themeModel, muteUsersModel: MuteUsersModel(),
                ),
                SearchPage(
                  mainModel: mainModel,
                ),
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
