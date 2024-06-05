import 'identifier.dart';
import 'location.dart';

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
        identifier.uri,
        null,
      ),
      loadingUnit: json['loadingUnit'] as String?,
    );
  }

  Map<String, dynamic> toJson(
    List<Identifier> identifiers,
    List<String> uris,
  ) =>
      {
        'id': identifiers.indexOf(identifier),
        '@': location.toJson(),
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
