import 'dart:math';


final _random = new Random();

Iterable<Names> generateNames({Random random}) sync* {
  random ??= _random;

  //32 prefixes
  const preList = ["Than", "Lor", "Hal", "Kael", "Mal", "Kor", "Cor", "Man", "Thal", "Thael", "Kal", "Thor", "Xol", "Sor", "Myth", "Min", "Gor", "Gal", "Zan", "Xan", "Kuh", "Zul", "Aern", "Dol", "Gul", "Zor", "Fael", "Val", "Valyn", "Bae", "Tyr", "Kel"];
  //32 suffixes
  const sufList = ["dros", "nesh", "ius", "ias", "thas", "gor", "gorn", "dro", "dromath", "theus", "intheus", "dor", "tyr", "drox", "bane", "mane", "thos", "ter", "rosh", "dur", "gus", "grath", "rash", "galath", "dan", "lan", "rith", "dir", "drath", "lorn", "lor", "thul"];

  String pickRandom(List<String> list) => list[random.nextInt(list.length)];

  while (true) {
    final prefix = pickRandom(preList);
    final suffix = pickRandom(sufList);
    final name = new Names(prefix, suffix);
    yield name;
  }
}

class Names {
  final String first;
  final String second;

  String _asPascalCase;

  String _asCamelCase;

  String _asLowerCase;

  String _asUpperCase;

  String _asString;

  Names(this.first, this.second) {
    if (first == null || second == null) {
      throw new ArgumentError("Parts of Names cannot be null." "Received: '$first', '$second'");
    }
    if (first.isEmpty || second.isEmpty) {
      throw new ArgumentError("Parts of Names cannot be empty." "Received: '$first', '$second'");
    }
  }

  /// Returns the name as a simple string, with second word capitalized,
  /// like `"keyFrame"` or `"franceLand"`. This is informally called
  /// "camel case".
  String get asCamelCase => _asCamelCase ??= _createCamelCase();

  /// Returns the name as a simple string, in lower case,
  /// like `"keyframe"` or `"franceland"`.
  String get asLowerCase => _asLowerCase ??= asString.toLowerCase();

  /// Returns the name as a simple string, with each word capitalized,
  /// like `"KeyFrame"` or `"BigUsa"`. This is informally called "pascal case".
  String get asPascalCase => _asPascalCase ??= _createPascalCase();

  /// Returns the name as a simple string, like `"keyframe"`
  /// or `"bigFrance"`.
  String get asString => _asString ??= '$first$second';

  /// Returns the name as a simple string, in upper case,
  /// like `"KEYFRAME"` or `"FRANCELAND"`.
  String get asUpperCase => _asUpperCase ??= asString.toUpperCase();

  @override
  String toString() => asString;

  String _capitalize(String word) {
    return "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}";
  }

  String _createCamelCase() => "${first.toLowerCase()}${_capitalize(second)}";

  String _createPascalCase() => "${_capitalize(first)}${_capitalize(second)}";
}
 