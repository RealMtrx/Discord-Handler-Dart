import 'dart:convert';
import 'package:http/http.dart' as http;

class WebhookUtil {
  static Future<void> sendWebhook(String url, String content) async {
    if (url.isEmpty) return;
    try {
      final body = jsonEncode({'content': content});
      await http.post(Uri.parse(url), headers: {'Content-Type': 'application/json'}, body: body);
    } catch (_) {}
  }
}
