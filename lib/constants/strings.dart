// packages
import 'package:uuid/uuid.dart';

// titles
const String appTitle = "SNS";
const String signupTitle = "新規登録";
const String loginTitle = "ログイン";
const String accountTitle = "アカウント";
const String themeTitle = "テーマ";
const String profileTitle = "プロフィール";
const String adminTitle = "管理者";
const String createPostTitle = "投稿を作成";
const String commentTitle = "コメント";
const String replyTitle = "リプライ";
const String editProfilePageTitle = "プロフィール編集ページ";
const String muteUsersPageTitle = "ミュートしているユーザー";
const String muteCommentsPageTitle = "ミュートしているコメント";
const String mutePostsPageTitle = "ミュートしている投稿";
// texts
const String mailAddressText = "メールアドレス";
const String passwordText = "パスワード";
const String signupText = "新規登録を行う";
const String cropperTitle = "Cropper";
const String loginText = "ログインする";
const String logoutText = "ログアウトを行う";
const String loadingText = "Loading";
const String uploadText = "アップロードする";
const String reloadText = "再読み込みを行う";
const String createCommentText = "コメントを作成";
const String createReplyText = "リプライを作成";
const String editProfileText = "プロフィールを編集する";
const String updateText = "更新する";
const String showMuteUsersText = "ミュートしているユーザーを表示する";
const String showMuteCommentsText = "ミュートしているコメントを表示する";
const String showMutePostsText = "ミュートしている投稿を表示する";
const String yesText = "Yes";
const String noText = "No";
const String backText = "戻る";
const String muteUserText = "ユーザーをミュート";
const String muteCommentText = "コメントをミュート";
const String mutePostText = "投稿をミュート";
const String unMuteUserText = "ユーザーのミュートを解除する";
const String unMuteCommentText = "コメントのミュートを解除";
const String unMutePostText = "投稿のミュートを解除";
// alert message
const String muteUserAlertMsg = 'ユーザーをミュートしますが本当によろしいですか？';
const String muteCommentAlertMsg = "コメントをミュートしますが本当によろしいですか？";
const String mutePostAlertMsg = "投稿をミュートしますが本当によろしいですか？";
const String unMuteUserAlertMsg = 'ユーザーのミュートを解除しますが本当によろしいですか？';
const String unMuteCommentAlertMsg = "コメントのミュートを解除しますが本当によろしいですか？";
const String unMutePostAlertMsg = "投稿のミュートを解除しますが本当によろしいですか？";
// FieldKey
const String usersFieldKey = "users";
// message
const String userCreatedMsg = "ユーザーが作成できました";
const String noAccountMsg = "アカウントをお持ちでない場合";
// prefs key
const String isDarkThemePrefsKey = "isDarkTheme";
// bottom navigation bar
const String homeText = "Home";
const String searchText = "Search";
const String profileText = "Profile";
String returnUuidV4() {
  const Uuid uuid = Uuid();
  return uuid.v4();
}

String returnJpgFileName() => "${returnUuidV4()}.jpg";
