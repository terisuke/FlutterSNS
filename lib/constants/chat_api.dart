// chat_api.dart
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ChatAPI {
  String? _apiKey;

  String get apiKey => _apiKey ??= dotenv.env['OPEN_API_KEY']!;
  Future<String> requestChatAPI(String text) async {
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    };
    final messages = [
      {
        "role": "system",
        "content":
            "You are a Tweet assistant that suggests example tweets. We suggest one example of tweets that are in line with the user's sentiments, based on the user's text input, in the user's language, and based on the time and context of the user's country.",
      },
      {
        "role": "user",
        "content": text,
      },
    ];
    final payload = {
      "model": "gpt-3.5-turbo",
      "max_tokens": 2000,
      "messages": messages,
    };
    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: headers,
      body: jsonEncode(payload),
    );
    // ログ出力
    print('Request URL: ${response.request!.url}');
    print('Request Headers: ${response.request!.headers}');
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseData != null &&
          responseData['choices'] != null &&
          responseData['choices'].isNotEmpty) {
        return responseData['choices'][0]['message']['content'].toString();
      } else {
        throw Exception('Invalid API response.');
      }
    } else {
      throw Exception(
          'Failed to load response. Status code: ${response.statusCode}');
    }
  }

  Future<String> requestRevisionAPI(String text) async {
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    };

    final messages = [
      {
        "role": "system",
        "content":
            "You are a tweet rewriter. Check the content that the user wants to tweet, and if it contains words that make people uncomfortable or give the wrong impression, rewrite the tweet to imitate the user's thoughts and speaking style so that more people can relate to it. Please make suggestions in the language your users use.",
      },
      {
        "role": "user",
        "content": text,
      },
    ];

    final payload = {
      "model": "gpt-3.5-turbo",
      "max_tokens": 2000,
      "messages": messages,
    };

    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: headers,
      body: jsonEncode(payload),
    );

    print('Request URL: ${response.request!.url}');
    print('Request Headers: ${response.request!.headers}');
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseData != null &&
          responseData['choices'] != null &&
          responseData['choices'].isNotEmpty) {
        return responseData['choices'][0]['message']['content'].toString();
      } else {
        throw Exception('Invalid API response.');
      }
    } else {
      throw Exception(
          'Failed to load response. Status code: ${response.statusCode}');
    }
  }
}
