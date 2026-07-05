import 'package:nyxx/nyxx.dart';

class GuildDeleteEvent {
  static void execute(Snowflake guildId) {
    print('\x1B[33m[GuildDelete] Left: $guildId\x1B[0m');
  }
}
