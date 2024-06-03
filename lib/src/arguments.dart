import 'package:collection/collection.dart';

class Arguments {
  ConstArguments? constArguments;
  NonConstArguments? nonConstArguments;

  Arguments({
    this.constArguments,
    this.nonConstArguments,
  });

  factory Arguments.fromJson(Map<String, dynamic> json) {
    final constJson = json['const'] as Map<String, dynamic>?;
    final nonConstJson = json['nonConst'] as Map<String, dynamic>?;
    return Arguments(
      constArguments:
          constJson != null ? ConstArguments.fromJson(constJson) : null,
      nonConstArguments: nonConstJson != null
          ? NonConstArguments.fromJson(nonConstJson)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (constArguments != null) 'const': constArguments!.toJson(),
        if (nonConstArguments != null) 'nonConst': nonConstArguments!.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Arguments &&
        other.constArguments == constArguments &&
        other.nonConstArguments == nonConstArguments;
  }

  @override
  int get hashCode => constArguments.hashCode ^ nonConstArguments.hashCode;
}

class ConstArguments {
  Map<String, dynamic>? positional;
  Map<String, dynamic>? named;

  ConstArguments({this.positional, this.named});

  factory ConstArguments.fromJson(Map<String, dynamic> json) => ConstArguments(
        positional: json['positional'] as Map<String, dynamic>?,
        named: json['named'] as Map<String, dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        if (positional != null) 'positional': positional!,
        if (named != null) 'named': named!,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final mapEquals = const DeepCollectionEquality().equals;

    return other is ConstArguments &&
        mapEquals(other.positional, positional) &&
        mapEquals(other.named, named);
  }

  @override
  int get hashCode => positional.hashCode ^ named.hashCode;
}

class NonConstArguments {
  List<dynamic>? positional;
  List<String>? named; // Assuming named arguments are strings (keys)

  NonConstArguments({this.positional, this.named});

  factory NonConstArguments.fromJson(Map<String, dynamic> json) =>
      NonConstArguments(
        positional: json['positional'] as List,
        named: json['named'] as List<String>?,
      );

  Map<String, dynamic> toJson() => {
        if (positional != null) 'positional': positional!,
        if (named != null) 'named': named!,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is NonConstArguments &&
        listEquals(other.positional, positional) &&
        listEquals(other.named, named);
  }

  @override
  int get hashCode => positional.hashCode ^ named.hashCode;
}
