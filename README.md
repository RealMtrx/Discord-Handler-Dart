# Discord Handler Dart

A modern, feature-rich Discord bot handler built with Dart and nyxx, featuring both slash commands and prefix commands with a robust modular architecture.

## Features

- Slash commands and prefix commands
- MongoDB integration with mongo_dart
- Modular architecture (commands, events, handlers)
- Anti-crash system with error reporting
- Cooldown system
- Unicode emoji exports
- Webhook logging

## Prerequisites

- Dart SDK 3.0+

## Setup

1. Clone the repository
2. Copy `.env.example` to `.env` and fill in your bot token and other configuration
3. Run the bot:

```bash
dart pub get
dart run src/main.dart
```

## Project Structure

```
src/
├── main.dart                    # Entry point
├── config/config.dart           # Configuration loader
├── commands/slash/ping.dart     # Slash ping command
├── commands/prefix/ping.dart    # Prefix ping command
├── core/emojis.dart             # Unicode emoji exports
├── core/command_utils.dart      # Cooldown utilities
├── core/webhook_util.dart       # Webhook utility
├── database/mongo.dart          # MongoDB connection
├── events/ready.dart            # Ready event
├── events/guild_create.dart     # Guild join event
├── events/guild_delete.dart     # Guild leave event
├── events/interaction_create.dart # Slash command handler
├── events/message_create.dart   # Prefix command handler
├── handlers/anti_crash.dart     # Error handling
├── handlers/logger.dart         # Startup logger
└── models/user_model.dart       # User data model
```

## License

MIT License - see [LICENSE](LICENSE) for details.
