// packages
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:algolia/algolia.dart';

class Application {
  static final Algolia algolia = Algolia.init(
    applicationId: dotenv.env["ALGOLIA_APP_ID"]!,
    apiKey: dotenv.env["ALGOLIA_ADMIN_KEY"]!,
  );
}
