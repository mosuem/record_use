import 'arguments.dart';
import 'base.dart';

sealed class Reference {
  final String? loadingUnit;
  // Represents the "@" field in the JSON

  final Location location;

  const Reference({this.loadingUnit, required this.location});

  Map<String, dynamic> toJson() => {
        'loadingUnit': loadingUnit,
        '@': location.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Reference &&
        other.loadingUnit == loadingUnit &&
        other.location == location;
  }

  @override
  int get hashCode => loadingUnit.hashCode ^ location.hashCode;
}

final class CallReference extends Reference {
  final Arguments arguments;

  const CallReference({
    required this.arguments,
    super.loadingUnit,
    required super.location,
  });

  factory CallReference.fromJson(Map<String, dynamic> json) {
    return CallReference(
      arguments: Arguments.fromJson(json['arguments'] as Map<String, dynamic>),
      loadingUnit: json['loadingUnit'] as String?,
      location: Location.fromJson(json['@'] as Map<String, dynamic>),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'arguments': arguments.toJson(),
        ...super.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CallReference && other.arguments == arguments;
  }

  @override
  int get hashCode => arguments.hashCode;
}

final class InstanceReference extends Reference {
  final Map<String, dynamic> fields;

  InstanceReference({
    super.loadingUnit,
    required super.location,
    required this.fields,
  });

  factory InstanceReference.fromJson(Map<String, dynamic> json) {
    return InstanceReference(
      loadingUnit: json['loadingUnit'] as String?,
      location: Location.fromJson(json['@'] as Map<String, dynamic>),
      fields: json['fields'] as Map<String, dynamic>,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'fields': fields,
        ...super.toJson(),
      };
}
