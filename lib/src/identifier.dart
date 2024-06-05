class Identifier {
  String uri;
  String? parent; // Optional since not all elements have parents
  String name;

  Identifier({
    required this.uri,
    this.parent,
    required this.name,
  });

  factory Identifier.fromJson(Map<String, dynamic> json, List<String> uris) =>
      Identifier(
        uri: uris[json['uri'] as int],
        parent: json['parent'] as String?,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson(List<String> uris) => {
        'uri': uris.indexOf(uri),
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
