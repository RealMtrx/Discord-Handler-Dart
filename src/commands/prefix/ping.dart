import 'package:nyxx/nyxx.dart';
import '../../core/emojis.dart';
import '../../core/command_utils.dart';

class PrefixPing {
  static const String name = 'ping';
  static const String description = 'Replies with Pong!';
  static const List<String> aliases = ['p'];
  static const int cooldownMs = 3000;

  static Future<void> execute(IMessage message, List<String> args) async {
    final userId = message.author.id.toString();
    final cooldown = CommandUtils.checkCooldown(userId, name, cooldownMs: cooldownMs);

    if (cooldown.onCooldown) {
      await message.channel.sendMessage(MessageBuilder(
        content: '${Emojis.loading} Please wait ${cooldown.timeLeft} seconds before using this command again.',
      ));
      return;
    }

    await message.channel.sendMessage(MessageBuilder(
      content: '${Emojis.success} Pong!',
    ));
  }
}
