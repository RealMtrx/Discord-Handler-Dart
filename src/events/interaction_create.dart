import 'package:nyxx/nyxx.dart';
import '../commands/slash/ping.dart';
import '../core/emojis.dart';

class InteractionCreateEvent {
  static Future<void> execute(IInteraction interaction) async {
    if (interaction is! ISlashCommandInteraction) return;
    final cmd = interaction.commandName;

    try {
      if (cmd == SlashPing.name) {
        await SlashPing.execute(interaction);
      } else {
        await interaction.respond(MessageBuilder(
          content: '${Emojis.error} Unknown command.',
          flags: MessageFlags.ephemeral,
        ));
      }
    } catch (e) {
      print('\x1B[31m[InteractionCreate] Error in /$cmd: $e\x1B[0m');
      if (!interaction.hasResponded) {
        await interaction.respond(MessageBuilder(
          content: '${Emojis.error} Error executing command!',
          flags: MessageFlags.ephemeral,
        ));
      }
    }
  }
}
