<div align="center">
  <h1>Discord Handler — Dart</h1>
  <p><strong>A production-ready Discord bot framework built with nyxx and MongoDB — slash commands, prefix commands, anti-crash, webhook logging, stream-based async, and a modular src/ architecture.</strong></p>

  <p>
    <a href="https://github.com/RealMtrx/Discord-Handler-Dart/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License"></a>
    <a href="https://github.com/RealMtrx/Discord-Handler-Dart/releases"><img src="https://img.shields.io/badge/version-0.9.0--beta-yellow" alt="Version 0.9.0 Beta"></a>
    <a href="https://github.com/RealMtrx/Discord-Handler-Dart/stargazers"><img src="https://img.shields.io/github/stars/RealMtrx/Discord-Handler-Dart" alt="Stars"></a>
    <a href="https://github.com/RealMtrx/Discord-Handler-Dart/issues"><img src="https://img.shields.io/github/issues/RealMtrx/Discord-Handler-Dart" alt="Issues"></a>
    <a href="https://github.com/RealMtrx/Discord-Handler-Dart/network"><img src="https://img.shields.io/github/forks/RealMtrx/Discord-Handler-Dart" alt="Forks"></a>
    <a href="https://github.com/RealMtrx/Discord-Handler/graphs/contributors"><img src="https://img.shields.io/badge/ecosystem-26%20repos-brightgreen" alt="26 Repos"></a>
    <a href="https://discord.gg/0hu2"><img src="https://img.shields.io/badge/discord-0hu2-5865F2" alt="Discord"></a>
  </p>

  <br>

  <p>
    <a href="#-features">Features</a> •
    <a href="#-quick-start">Quick Start</a> •
    <a href="#-project-structure">Structure</a> •
    <a href="#-api-reference">API</a> •
    <a href="#-database-edition">SQL Edition</a> •
    <a href="#-related-repositories">Ecosystem</a>
  </p>
</div>

---

## Overview

Discord Handler Dart is a production-ready bot framework using **nyxx ^6.9.0** with Dart SDK ^3.0.0. Built on Dart's stream-based async model, it provides a dual command system (slash + prefix), anti-crash protection, HTTP webhook logging, MongoDB persistence via mongo_dart, and per-command cooldowns.

## Features

- **Dual Command System** — Slash and prefix commands with automatic registration
- **Stream-Based Async** — Fully asynchronous with Dart streams and `Future`/`async`/`await`
- **Anti-Crash System** — Global error zone handling
- **Webhook Logging** — HTTP webhook delivery via `http` package for errors and guild events
- **MongoDB Integration** — `mongo_dart ^0.10.0` for persistent data storage
- **Cooldown System** — Per-command cooldown management
- **Environment Configuration** — `dotenv ^4.2.0` for secure config
- **Pub.dev Ecosystem** — Lightweight dependency footprint

## Quick Start

```bash
# Clone the repository
git clone https://github.com/RealMtrx/Discord-Handler-Dart.git
cd Discord-Handler-Dart

# Install dependencies
dart pub get

# Configure environment
cp .env.example .env
# Edit .env with your bot token, MongoDB URI, and webhook URLs

# Run the bot
dart run
```

### Environment Variables

```env
TOKEN=your_bot_token
PREFIX=!
BOT_NAME=Discord Handler
MONGO_URI=mongodb://localhost:27017/discord-handler
ERROR_WEBHOOK=https://discord.com/api/webhooks/...
GUILD_LOG_WEBHOOK=https://discord.com/api/webhooks/...
```

## Project Structure

```
Discord-Handler-Dart/
├── pubspec.yaml                    # Dart project config (nyxx ^6.9.0, mongo_dart)
├── src/
│   ├── main.dart                   # Entry point — initializes bot and starts listener
│   ├── config/Config.dart          # .env configuration parser
│   ├── Core/
│   │   ├── command_utils.dart      # Cooldown map & utility methods
│   │   ├── emojis.dart             # Centralized emoji constants
│   │   └── webhook_util.dart       # Webhook HTTP sender
│   ├── Database/
│   │   └── mongo.dart              # MongoDB client setup (mongo_dart)
│   ├── Events/
│   │   ├── guild_create.dart       # onGuildJoin
│   │   ├── guild_delete.dart       # onGuildLeave
│   │   ├── interaction_create.dart # Slash command dispatcher
│   │   ├── message_create.dart     # Prefix command dispatcher
│   │   └── ready.dart              # onReady
│   ├── Handlers/
│   │   ├── anti_crash.dart         # Global error zone handler
│   │   └── logger.dart             # Console logging utilities
│   ├── Models/
│   │   └── user_model.dart         # MongoDB user document model
│   └── Commands/
│       ├── Prefix/
│       │   └── ping.dart           # Example prefix command
│       └── Slash/
│           └── ping.dart           # Example slash command
```

## API Reference

### Bot Initialization

```dart
// main.dart
import 'package:nyxx/nyxx.dart';
import 'config/Config.dart';
import 'handlers/anti_crash.dart';

void main() async {
  final config = Config();
  AntiCrash.setup();

  final bot = NyxxFactory.createSnowflakeBot(config.token);
  // Register event listeners
  bot.onReady.listen((event) { /* onReady */ });
  bot.onMessageCreate.listen((event) { /* prefix commands */ });
  bot.onSlashCommandInteraction.listen((event) { /* slash commands */ });

  await bot.connect();
}
```

### Creating Slash Commands

Create a file in `src/Commands/Slash/<name>.dart`:

```dart
import 'package:nyxx/nyxx.dart';

class SlashPing {
  static const name = 'ping';
  static const description = 'Replies with Pong!';

  static Future<void> execute(ISlashCommandInteraction interaction) async {
    await interaction.respond(MessageBuilder(content: 'Pong! 🏓'));
  }
}
```

### Creating Prefix Commands

Create a file in `src/Commands/Prefix/<name>.dart`:

```dart
import 'package:nyxx/nyxx.dart';

class PrefixPing {
  static const name = 'ping';

  static Future<void> execute(IMessage message) async {
    await message.channel.sendMessage(MessageBuilder(content: 'Pong! 🏓'));
  }
}
```

## Adding Commands

Commands are auto-discovered at startup by scanning the `Commands/` directory. Drop a new file in `Commands/Slash/` or `Commands/Prefix/` following the class convention, and the handler registers it automatically with no manual wiring required.

## Database Edition

This repository uses **MongoDB** via `mongo_dart`. If you prefer a relational database, check out the **SQL Edition**:

[![Discord-Handler-Dart-Sequelize](https://img.shields.io/badge/Discord--Handler--Dart--Sequelize-drift%20ORM-blue)](https://github.com/RealMtrx/Discord-Handler-Dart-Sequelize)

The SQL edition replaces `mongo.dart` with **drift** ORM and uses SQLite as the default backend (with build_runner code generation).

## Related Repositories

The Discord Handler ecosystem spans **26 repositories** across 13 programming languages — each with a MongoDB edition and a SQL (Sequelize) edition.

### Core Framework (MongoDB)

| Language | Repository |
|---|---|
| TypeScript | [Discord-Handler-Ts](https://github.com/RealMtrx/Discord-Handler-Ts) |
| JavaScript | [Discord-Handler-Js](https://github.com/RealMtrx/Discord-Handler-Js) |
| Python | [Discord-Handler-Py](https://github.com/RealMtrx/Discord-Handler-Py) |
| Java | [Discord-Handler-Java](https://github.com/RealMtrx/Discord-Handler-Java) |
| Kotlin | [Discord-Handler-Kt](https://github.com/RealMtrx/Discord-Handler-Kt) |
| C++ | [Discord-Handler-Cpp](https://github.com/RealMtrx/Discord-Handler-Cpp) |
| C# | [Discord-Handler-Cs](https://github.com/RealMtrx/Discord-Handler-Cs) |
| Go | [Discord-Handler-Go](https://github.com/RealMtrx/Discord-Handler-Go) |
| Rust | [Discord-Handler-Rs](https://github.com/RealMtrx/Discord-Handler-Rs) |
| Dart | [Discord-Handler-Dart](https://github.com/RealMtrx/Discord-Handler-Dart) |
| PHP | [Discord-Handler-Php](https://github.com/RealMtrx/Discord-Handler-Php) |
| Ruby | [Discord-Handler-Rb](https://github.com/RealMtrx/Discord-Handler-Rb) |
| Lua | [Discord-Handler-Lua](https://github.com/RealMtrx/Discord-Handler-Lua) |

### Database Editions (SQL)

| Language | Repository |
|---|---|
| TypeScript | [Discord-Handler-Ts-Sequelize](https://github.com/RealMtrx/Discord-Handler-Ts-Sequelize) |
| JavaScript | [Discord-Handler-Js-Sequelize](https://github.com/RealMtrx/Discord-Handler-Js-Sequelize) |
| Python | [Discord-Handler-Py-Sequelize](https://github.com/RealMtrx/Discord-Handler-Py-Sequelize) |
| Java | [Discord-Handler-Java-Sequelize](https://github.com/RealMtrx/Discord-Handler-Java-Sequelize) |
| Kotlin | [Discord-Handler-Kt-Sequelize](https://github.com/RealMtrx/Discord-Handler-Kt-Sequelize) |
| C++ | [Discord-Handler-Cpp-Sequelize](https://github.com/RealMtrx/Discord-Handler-Cpp-Sequelize) |
| C# | [Discord-Handler-Cs-Sequelize](https://github.com/RealMtrx/Discord-Handler-Cs-Sequelize) |
| Go | [Discord-Handler-Go-Sequelize](https://github.com/RealMtrx/Discord-Handler-Go-Sequelize) |
| Rust | [Discord-Handler-Rs-Sequelize](https://github.com/RealMtrx/Discord-Handler-Rs-Sequelize) |
| Dart | [Discord-Handler-Dart-Sequelize](https://github.com/RealMtrx/Discord-Handler-Dart-Sequelize) |
| PHP | [Discord-Handler-Php-Sequelize](https://github.com/RealMtrx/Discord-Handler-Php-Sequelize) |
| Ruby | [Discord-Handler-Rb-Sequelize](https://github.com/RealMtrx/Discord-Handler-Rb-Sequelize) |
| Lua | [Discord-Handler-Lua-Sequelize](https://github.com/RealMtrx/Discord-Handler-Lua-Sequelize) |

> **Hub repository:** [Discord-Handler](https://github.com/RealMtrx/Discord-Handler) — the multi-language overview and documentation hub.

## License

This project is licensed under the MIT License — see the [LICENSE](https://github.com/RealMtrx/Discord-Handler-Dart/blob/main/LICENSE) file for details.

---

Built by **Mtrx** — Discord: **0hu2**

[![Discord-Handler](https://img.shields.io/badge/Discord--Handler-Ecosystem%20Hub-5865F2)](https://github.com/RealMtrx/Discord-Handler)
