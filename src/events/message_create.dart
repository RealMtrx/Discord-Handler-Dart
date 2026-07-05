import 'package:nyxx/nyxx.dart';
import '../commands/prefix/ping.dart';
import '../config/config.dart';

class MessageCreateEvent {
  static final Map<String, void Function(IMessage, List<String>)> _prefixCommands = {
    PrefixPing.name: PrefixPing.execute,
    for (final alias in PrefixPing.aliases) alias: PrefixPing.execute,
  };

  static Future<void> execute(IMessage message, Config config) async {
    if (message.author.isBot) return;
    final content = message.content;
    if (!content.startsWith(config.prefix)) return;

    final withoutPrefix = content.substring(config.prefix.length).trim();
    final parts = withoutPrefix.split(RegExp(r'\s+'));
    if (parts.isEmpty) return;

    final commandName = parts.first.toLowerCase();
    final args = parts.sublist(1);

    final handler = _prefixCommands[commandName];
    if (handler == null) return;

    try {
      await handler(message, args);
    } catch (e) {
      print('\x1B[31m[Prefix] Error in $commandName: $e\x1B[0m');
    }
  }
}
