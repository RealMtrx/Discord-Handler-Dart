# Discord Handler Dart

A modern, feature-rich Discord bot handler built with **nyxx**, featuring both slash commands and prefix commands with a robust modular architecture designed for scalability and maintainability.

## 🚀 Features

- **Dual Command System**: Support for both slash commands and prefix commands
- **Modular Architecture**: Clean separation of concerns with dedicated handlers
- **Anti-Crash System**: Comprehensive error handling and monitoring
- **Event-Driven**: Fully event-driven stream-based architecture
- **Webhook Logging**: Real-time logging for errors and guild events
- **MongoDB Integration**: Persistent data storage with mongo_dart
- **Cooldown System**: Per-command cooldown management
- **Environment Configuration**: Secure configuration with dotenv

## 📁 Project Structure

```
Discord-Handler-Dart/
├── pubspec.yaml                  # Dart project configuration
├── src/                          # Source code
│   ├── main.dart                 # Main bot entry point
│   ├── config/Config.dart        # Bot configuration from .env
│   ├── Core/                     # Core utilities
│   │   ├── CommandUtils.dart     # Cooldown and utilities
│   │   ├── Emojis.dart           # Centralized emoji definitions
│   │   └── WebhookUtil.dart      # Webhook utility
│   ├── Database/
│   │   └── Mongo.dart            # MongoDB connection setup
│   ├── Events/                   # Discord event handlers
│   │   ├── GuildCreate.dart      # Handler when bot joins a server
│   │   ├── GuildDelete.dart      # Handler when bot leaves a server
│   │   ├── InteractionCreate.dart# Handles slash command interactions
│   │   ├── MessageCreate.dart    # Handles prefix commands
│   │   └── Ready.dart            # Bot ready event
│   ├── Handlers/                 # Handlers for modularity
│   │   ├── AntiCrash.dart        # Crash prevention and error handling
│   │   └── Logger.dart           # Logger for bot activity
│   ├── Models/
│   │   └── UserModel.dart        # User data model
│   └── Commands/
│       ├── Prefix/               # Prefix commands
│       │   └── ping.dart         # Example prefix ping command
│       └── Slash/                # Slash commands
│           └── ping.dart         # Example slash ping command
```

## 🔧 Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/RealMtrx/Discord-Handler-Dart.git
   cd Discord-Handler-Dart
   ```

2. **Install dependencies**

   ```bash
   dart pub get
   ```

3. **Environment Setup**

   Copy `.env.example` to `.env` and fill in your values:

   ```env
   TOKEN=your_bot_token_here
   PREFIX=!
   BOT_NAME=Discord Handler
   MONGO_URI=mongodb://localhost:27017/discord-handler
   ERROR_WEBHOOK=https://discord.com/api/webhooks/your_webhook
   GUILD_LOG_WEBHOOK=https://discord.com/api/webhooks/your_webhook
   ```

4. **Run the bot**

   ```bash
   dart run
   ```

## 📋 Dependencies

- **nyxx**: ^6.9.0 - Discord API wrapper
- **mongo_dart**: ^1.0 - MongoDB driver
- **dotenv**: ^4.1 - Environment variable management
- **http**: ^1.1 - HTTP client for webhooks

## 📝 Command Development

### Creating Slash Commands

Create a new file in `src/Commands/Slash/[name].dart`:

```dart
import 'package:nyxx/nyxx.dart';
import 'package:nyxx/src/core/snowflake.dart';

class SlashPing {
  static const name = 'ping';
  static const description = 'Replies with Pong!';

  static Future<void> execute(ISlashCommandInteraction interaction) async {
    await interaction.respond(MessageBuilder(content: 'Pong! 🏓'));
  }
}
```

### Creating Prefix Commands

Create a new file in `src/Commands/Prefix/[name].dart`:

```dart
import 'package:nyxx/nyxx.dart';

class PrefixPing {
  static const name = 'ping';

  static Future<void> execute(IMessage message) async {
    await message.channel.sendMessage(MessageBuilder(content: 'Pong! 🏓'));
  }
}
```

---

**Discord Handler** — Built by **Mtrx** — Discord: **0hu2**
