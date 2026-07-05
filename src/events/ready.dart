import 'package:nyxx/nyxx.dart';

class ReadyEvent {
  static Future<void> execute(INyxxGateway client, String botName) async {
    final self = await client.users.fetchCurrentUser();
    await client.http.endpoints.editCurrentUser(PresenceBuilder(
      status: UserStatus.online,
      activity: ActivityBuilder(name: botName, type: ActivityType.game),
    ));
    print('\x1B[32m[Ready] Logged in as ${self.tag}\x1B[0m');
  }
}
