class Definition {
  final Identifier identifier;
  final Location location; // Represents the '@' field in the JSON
  final String? loadingUnit;

  Definition({
    required this.identifier,
    required this.location,
    this.loadingUnit,
  });

  factory Definition.fromJson(
    Map<String, dynamic> json,
    List<Identifier> identifiers,
  ) {
    final identifier = identifiers[json['id'] as int];
    return Definition(
      identifier: identifier,
      location: Location.fromJson(
        json['@'] as Map<String, dynamic>,
        uri: identifier.uri,
      ),
      loadingUnit: json['loadingUnit'] as String?,
    );
  }

  Map<String, dynamic> toJson(List<Identifier> identifiers) => {
        'id': identifiers.indexOf(identifier),
        '@': location.toJson(withUri: false),
        'loadingUnit': loadingUnit,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Definition &&
        other.identifier == identifier &&
        other.loadingUnit == loadingUnit;
  }

  @override
  int get hashCode => identifier.hashCode ^ loadingUnit.hashCode;
}

class Location {
  String uri;
  int line;
  int column;
  Location({
    required this.uri,
    required this.line,
    required this.column,
  });

  factory Location.fromJson(Map<String, dynamic> map, {String? uri}) {
    return Location(
      uri: uri ?? map['uri'] as String,
      line: map['line'] as int,
      column: map['column'] as int,
    );
  }

  Map<String, dynamic> toJson({bool withUri = true}) {
    return {
      if (withUri) 'uri': uri,
      'line': line,
      'column': column,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Location &&
        other.uri == uri &&
        other.line == line &&
        other.column == column;
  }

  @override
  int get hashCode => uri.hashCode ^ line.hashCode ^ column.hashCode;
}

class Identifier {
  String uri;
  String? parent; // Optional since not all elements have parents
  String name;

  Identifier({
    required this.uri,
    this.parent,
    required this.name,
  });

  factory Identifier.fromJson(Map<String, dynamic> json) => Identifier(
        uri: json['uri'] as String,
        parent: json['parent'] as String?,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'uri': uri,
        if (parent != null) 'parent': parent,
        'name': name,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Identifier &&
        other.uri == uri &&
        other.parent == parent &&
        other.name == name;
  }

  @override
  int get hashCode => uri.hashCode ^ parent.hashCode ^ name.hashCode;
}
