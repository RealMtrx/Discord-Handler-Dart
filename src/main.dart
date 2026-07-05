import 'dart:io';
import 'package:nyxx/nyxx.dart';
import 'commands/slash/ping.dart';
import 'config/config.dart';
import 'events/ready.dart';
import 'events/guild_create.dart';
import 'events/guild_delete.dart';
import 'events/interaction_create.dart';
import 'events/message_create.dart';
import 'handlers/anti_crash.dart';
import 'handlers/logger.dart';
import 'database/mongo.dart';

Future<void> main() async {
  stdout.writeln('\x1B[36m\u2554\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2557\x1B[0m');
  stdout.writeln('\x1B[36m\u2551     Starting Discord Handler     \u2551\x1B[0m');
  stdout.writeln('\x1B[36m\u255A\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u2550\u255D\x1B[0m');
  stdout.writeln();

  final config = Config.load();

  stdout.writeln('\x1B[34m[System] Initializing AntiCrash...\x1B[0m');
  AntiCrash.init(webhookUrl: config.errorWebhook);

  stdout.writeln('\x1B[34m[System] Connecting to MongoDB...\x1B[0m');
  final mongoConnected = await Mongo.connect(config);

  stdout.writeln('\x1B[34m[System] Connecting to Discord...\x1B[0m');
  final client = await Nyxx.connectGateway(
    config.token,
    GatewayIntents.allUnprivileged | GatewayIntents.messageContent,
  );

  client.onReady.listen((event) async {
    await ReadyEvent.execute(client, config.botName);

    try {
      await client.http.endpoints.createGlobalSlashCommand(
        client.self.id,
        SlashCommandBuilder(SlashPing.name, SlashPing.description, []),
      );
      print('\x1B[32m[Commands] Slash command \'ping\' registered\x1B[0m');
    } catch (e) {
      print('\x1B[31m[Commands] Failed to register ping: $e\x1B[0m');
    }

    Logger.startupReport(StartupData(
      name: config.botName,
      prefix: 1,
      slash: 1,
      events: 5,
      anticrash: true,
      mongo: mongoConnected,
    ));
  });

  client.onGuildCreate.listen((event) {
    GuildCreateEvent.execute(event.guild);
  });

  client.onGuildDelete.listen((event) {
    GuildDeleteEvent.execute(event.guildId);
  });

  client.onInteractionCreate.listen((event) async {
    await InteractionCreateEvent.execute(event.interaction);
  });

  client.onMessageCreate.listen((event) async {
    await MessageCreateEvent.execute(event.message, config);
  });

  await Future.delayed(Duration.zero);
}
