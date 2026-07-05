import 'package:mongo_dart/mongo_dart.dart';
import '../config/config.dart';

class Mongo {
  static Db? _db;
  static bool _connected = false;

  static Future<bool> connect(Config config) async {
    try {
      _db = Db(config.mongoUri);
      await _db!.open();
      await _db!.command({'ping': 1});
      _connected = true;
      print('\x1B[32m[System] MongoDB connected\x1B[0m');
      return true;
    } catch (e) {
      print('\x1B[31m[MongoDB] Connection failed: $e\x1B[0m');
      return false;
    }
  }

  static bool isConnected() => _connected;

  static Db? get db => _db;

  static Future<void> disconnect() async {
    if (_db != null) {
      await _db!.close();
      _connected = false;
    }
  }
}
