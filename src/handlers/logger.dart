class StartupData {
  final String name;
  final int prefix;
  final int slash;
  final int events;
  final bool anticrash;
  final bool mongo;

  StartupData({
    required this.name,
    required this.prefix,
    required this.slash,
    required this.events,
    required this.anticrash,
    required this.mongo,
  });
}

class Logger {
  static void startupReport(StartupData data) {
    final line = '\x1B[36m\u2500' * 55 + '\x1B[0m';

    print('');
    print(line);
    print('  \x1B[1;36m${data.name}\x1B[0m');
    print(line);
    print('  ${_statusEmoji(data.slash > 0)} Slash Commands: ${data.slash}');
    print('  ${_statusEmoji(data.prefix > 0)} Prefix Commands: ${data.prefix}');
    print('  ${_statusEmoji(data.events > 0)} Events Loaded: ${data.events}');
    print('  ${_statusEmoji(data.anticrash)} AntiCrash: ${data.anticrash ? "Active" : "Inactive"}');
    print('  ${_statusEmoji(data.mongo)} MongoDB: ${data.mongo ? "Connected" : "Disconnected"}');
    print(line);
    print('  \x1B[35mBot is now online and fully operational.\x1B[0m');
    print('');
  }

  static String _statusEmoji(bool ok) => ok ? '\u2705' : '\u274C';
}
