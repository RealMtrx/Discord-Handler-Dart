import 'package:nyxx/nyxx.dart';

class GuildCreateEvent {
  static void execute(IGuild guild) {
    print('\x1B[36m[GuildCreate] Joined: ${guild.name} (${guild.id})\x1B[0m');
  }
}
