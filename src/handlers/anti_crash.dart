import 'dart:async';
import '../core/webhook_util.dart';

class AntiCrash {
  static String? _webhookUrl;

  static void init({String? webhookUrl}) {
    _webhookUrl = webhookUrl;

    runZonedGuarded(() {
      // Errors will be caught by the zone
    }, (Object error, StackTrace stack) {
      final msg = '$error\n$stack';
      print('\x1B[31m[AntiCrash] Unhandled error: $msg\x1B[0m');
      if (_webhookUrl != null) {
        WebhookUtil.sendWebhook(_webhookUrl!, '**Unhandled Error**\n```\n$msg\n```');
      }
    });

    print('\x1B[32m[AntiCrash] Active\x1B[0m');
  }

  static void reportError(String title, String message) {
    print('\x1B[31m[AntiCrash] $title: $message\x1B[0m');
    if (_webhookUrl != null) {
      WebhookUtil.sendWebhook(_webhookUrl!, '**$title**\n```\n$message\n```');
    }
  }
}
