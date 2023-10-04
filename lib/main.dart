//dart
import 'dart:async';
// flutter
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; 
// options
import 'firebase_options.dart';
// packages
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:udemy_flutter_sns/constants/others.dart';
import 'package:sentry/sentry.dart';
// models
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/mute_users_model.dart';
import 'package:udemy_flutter_sns/models/sns_bottom_navigation_bar_model.dart';
import 'package:udemy_flutter_sns/models/themes_model.dart';
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
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const ProviderScope(child: BootStrap()));
  }, (error, stackTrace) {
    if (!kIsWeb && Firebase.apps.length > 0) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    } else {
      print('Error occurred, but Firebase is not initialized');
      print('Error: $error');
      print('StackTrace: $stackTrace');
    }
  });
}

class BootStrap extends StatefulWidget {
  const BootStrap({Key? key}) : super(key: key);

  @override
  _BootStrapState createState() => _BootStrapState();
}

class _BootStrapState extends State<BootStrap> {
  bool _initialized = false;

  Future<void> initializeApp() async {
    await dotenv.load(fileName: ".env");
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    if (!kIsWeb) {
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    }

    Sentry.init(
      (options) {
        options.dsn = dotenv.env['SENTRY_DSN']!;
      },
      appRunner: () {}, // Sentryの初期化のみ行い、ここでは何も起動しない
    );

    setState(() {
      _initialized = true;
    });
  }

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    if (_initialized) {
      return const MyApp();
    }

    return Loading();
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

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
                  themeModel: themeModel,
                  muteUsersModel: MuteUsersModel(),
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
