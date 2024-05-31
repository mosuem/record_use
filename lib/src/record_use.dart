// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:version/version.dart';

class RecordUses {
  Metadata metadata;
  List<StaticFunctionReference> staticFunctionReferences;

  RecordUses({required this.metadata, required this.staticFunctionReferences});

  factory RecordUses.fromJson(Map<String, dynamic> json) => RecordUses(
        metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
        staticFunctionReferences: List<StaticFunctionReference>.from(
            (json['staticFunctionReferences'] as List).map((x) =>
                StaticFunctionReference.fromJson(x as Map<String, dynamic>))),
      );

  Map<String, dynamic> toJson() => {
        'metadata': metadata.toJson(),
        'staticFunctionReferences': staticFunctionReferences
            .map((reference) => reference.toJson())
            .toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is RecordUses &&
        other.metadata == metadata &&
        listEquals(other.staticFunctionReferences, staticFunctionReferences);
  }

  @override
  int get hashCode => metadata.hashCode ^ staticFunctionReferences.hashCode;
}

class Metadata {
  String? comment;
  Version version;
  DateTime timestamp;
  Hashes hashes;

  Metadata({
    this.comment,
    required this.version,
    required this.timestamp,
    required this.hashes,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        comment: json['comment'] as String?,
        version: Version.parse(json['version'] as String),
        timestamp:
            DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
        hashes: Hashes.fromJson(json['hashes'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        if (comment != null) 'comment': comment,
        'version': version.toString(),
        'timestamp': timestamp.millisecondsSinceEpoch,
        'hashes': hashes.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Metadata &&
        other.comment == comment &&
        other.version == version &&
        other.timestamp == timestamp &&
        other.hashes == hashes;
  }

  @override
  int get hashCode {
    return comment.hashCode ^
        version.hashCode ^
        timestamp.hashCode ^
        hashes.hashCode;
  }
}

class Hashes {
  String noPositions;
  String noPositionsNoLoadingUnits;

  Hashes({
    required this.noPositions,
    required this.noPositionsNoLoadingUnits,
  });

  factory Hashes.fromJson(Map<String, dynamic> json) => Hashes(
        noPositions: json['noPositions'] as String,
        noPositionsNoLoadingUnits: json['noPositionsNoLoadingUnits'] as String,
      );

  Map<String, dynamic> toJson() => {
        'noPositions': noPositions,
        'noPositionsNoLoadingUnits': noPositionsNoLoadingUnits,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Hashes &&
        other.noPositions == noPositions &&
        other.noPositionsNoLoadingUnits == noPositionsNoLoadingUnits;
  }

  @override
  int get hashCode => noPositions.hashCode ^ noPositionsNoLoadingUnits.hashCode;
}

class StaticFunctionReference {
  List<Annotation> annotations;
  Definition definition;
  List<Reference> references;

  StaticFunctionReference({
    required this.annotations,
    required this.definition,
    required this.references,
  });

  factory StaticFunctionReference.fromJson(Map<String, dynamic> json) =>
      StaticFunctionReference(
        annotations: (json['annotations'] as List)
            .map((x) => Annotation.fromJson(x as Map<String, dynamic>))
            .toList(),
        definition:
            Definition.fromJson(json['definition'] as Map<String, dynamic>),
        references: (json['references'] as List)
            .map((x) => Reference.fromJson(x as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'annotations': annotations.map((x) => x.toJson()).toList(),
        'definition': definition.toJson(),
        'references': references.map((x) => x.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is StaticFunctionReference &&
        listEquals(other.annotations, annotations) &&
        other.definition == definition &&
        listEquals(other.references, references);
  }

  @override
  int get hashCode =>
      annotations.hashCode ^ definition.hashCode ^ references.hashCode;
}

class Annotation {
  Identifier identifier;
  Map<String, dynamic> fields;

  Annotation({
    required this.identifier,
    required this.fields,
  });

  factory Annotation.fromJson(Map<String, dynamic> json) => Annotation(
        identifier:
            Identifier.fromJson(json['identifier'] as Map<String, dynamic>),
        fields: json['fields'] as Map<String, dynamic>,
      );

  Map<String, dynamic> toJson() => {
        'identifier': identifier.toJson(),
        'fields': fields,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final mapEquals = const DeepCollectionEquality().equals;

    return other is Annotation &&
        other.identifier == identifier &&
        mapEquals(other.fields, fields);
  }

  @override
  int get hashCode => identifier.hashCode ^ fields.hashCode;
}

class Definition {
  Identifier identifier;
  Location location; // Represents the '@' field in the JSON
  String? loadingUnit;

  Definition({
    required this.identifier,
    required this.location,
    this.loadingUnit,
  });

  factory Definition.fromJson(Map<String, dynamic> json) => Definition(
        identifier:
            Identifier.fromJson(json['identifier'] as Map<String, dynamic>),
        location: Location.fromJson(json['@'] as Map<String, dynamic>),
        loadingUnit: json['loadingUnit'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'identifier': identifier.toJson(),
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

class Reference {
  Arguments? arguments;
  String? loadingUnit;
  Location location; // Represents the "@" field in the JSON

  Reference({
    this.arguments,
    this.loadingUnit,
    required this.location,
  });

  factory Reference.fromJson(Map<String, dynamic> json) {
    final argumentsJson = json['arguments'] as Map<String, dynamic>?;
    return Reference(
      arguments:
          argumentsJson != null ? Arguments.fromJson(argumentsJson) : null,
      loadingUnit: json['loadingUnit'] as String?,
      location: Location.fromJson(json['@'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        if (arguments != null) 'arguments': arguments!.toJson(),
        'loadingUnit': loadingUnit,
        '@': location.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Reference &&
        other.arguments == arguments &&
        other.loadingUnit == loadingUnit;
  }

  @override
  int get hashCode => arguments.hashCode ^ loadingUnit.hashCode;
}

class Location {
  Uri uri;
  int line;
  int column;
  Location({
    required this.uri,
    required this.line,
    required this.column,
  });

  factory Location.fromJson(Map<String, dynamic> map) {
    return Location(
      uri: Uri.parse(map['uri'] as String),
      line: map['line'] as int,
      column: map['column'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uri': uri.toString(),
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

class Identifier {
  Uri uri;
  String? parent; // Optional since not all elements have parents
  String name;

  Identifier({
    required this.uri,
    this.parent,
    required this.name,
  });

  factory Identifier.fromJson(Map<String, dynamic> json) => Identifier(
        uri: Uri.parse(json['uri'] as String),
        parent: json['parent'] as String?,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'uri': uri.toString(),
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

class ConstArguments {
  Map<String, dynamic>? positional;
  Map<String, dynamic>? named;

  ConstArguments({this.positional, this.named});

  factory ConstArguments.fromJson(Map<String, dynamic> json) => ConstArguments(
        positional: json['positional'] as Map<String, dynamic>?,
        named: json['named'] as Map<String, dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'positional': positional,
        'named': named,
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
        'positional': positional,
        'named': named,
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
