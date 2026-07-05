import 'package:nyxx/nyxx.dart';
import '../../core/emojis.dart';
import '../../core/command_utils.dart';

class SlashPing {
  static const String name = 'ping';
  static const String description = 'Replies with Pong!';
  static const int cooldownMs = 3000;

  static Future<void> execute(ISlashCommandInteraction interaction) async {
    final userId = interaction.user.id.toString();
    final cooldown = CommandUtils.checkCooldown(userId, name, cooldownMs: cooldownMs);

    if (cooldown.onCooldown) {
      await interaction.respond(MessageBuilder(
        content: '${Emojis.loading} Please wait ${cooldown.timeLeft} seconds before using this command again.',
        flags: MessageFlags.ephemeral,
      ));
      return;
    }

    await interaction.respond(MessageBuilder(
      content: '${Emojis.success} Pong!',
      flags: MessageFlags.ephemeral,
    ));
  }
}
