import 'package:dotenv/dotenv.dart' as dotenv;

class Config {
  final String token;
  final String clientId;
  final String botName;
  final String prefix;
  final List<String> ownerIds;
  final String mongoUri;
  final String? errorWebhook;
  final String? slashCommandWebhook;
  final String? prefixCommandWebhook;
  final String? joinGuildWebhook;
  final String? leaveGuildWebhook;
  final String? readyWebhook;

  Config._({
    required this.token,
    required this.clientId,
    required this.botName,
    required this.prefix,
    required this.ownerIds,
    required this.mongoUri,
    this.errorWebhook,
    this.slashCommandWebhook,
    this.prefixCommandWebhook,
    this.joinGuildWebhook,
    this.leaveGuildWebhook,
    this.readyWebhook,
  });

  factory Config.load() {
    final env = dotenv.Dotenv()..load();
    return Config._(
      token: env['TOKEN'] ?? '#',
      clientId: env['CLIENT_ID'] ?? '#',
      botName: env['BOT_NAME'] ?? 'Discord Handler',
      prefix: env['PREFIX'] ?? r'$',
      ownerIds: (env['OWNER_IDS'] ?? '#').split(',').map((s) => s.trim()).toList(),
      mongoUri: env['MONGODB_URI'] ?? '#',
      errorWebhook: _nullIfBlank(env['ERROR_WEBHOOK']),
      slashCommandWebhook: _nullIfBlank(env['SLASH_COMMAND_WEBHOOK']),
      prefixCommandWebhook: _nullIfBlank(env['PREFIX_COMMAND_WEBHOOK']),
      joinGuildWebhook: _nullIfBlank(env['JOIN_GUILD_WEBHOOK']),
      leaveGuildWebhook: _nullIfBlank(env['LEAVE_GUILD_WEBHOOK']),
      readyWebhook: _nullIfBlank(env['READY_WEBHOOK']),
    );
  }

  static String? _nullIfBlank(String? s) {
    if (s == null || s.trim().isEmpty) return null;
    return s;
  }
}
