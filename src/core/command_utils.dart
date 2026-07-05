class CooldownResult {
  final bool onCooldown;
  final int timeLeft;

  CooldownResult({required this.onCooldown, this.timeLeft = 0});
}

class CommandUtils {
  static final Map<String, DateTime> _cooldowns = {};

  static CooldownResult checkCooldown(String userId, String commandName, {int cooldownMs = 3000}) {
    final key = '$userId:$commandName';
    final now = DateTime.now();
    final lastUsed = _cooldowns[key];

    if (lastUsed != null) {
      final elapsed = now.difference(lastUsed).inMilliseconds;
      if (elapsed < cooldownMs) {
        return CooldownResult(onCooldown: true, timeLeft: ((cooldownMs - elapsed) / 1000).ceil());
      }
    }

    _cooldowns[key] = now;
    return CooldownResult(onCooldown: false);
  }
}
