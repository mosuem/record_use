// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';

import 'base.dart';
import 'metadata.dart';
import 'reference.dart';

class RecordUses {
  final Metadata metadata;
  final Map<Definition, List<CallReference>>? calls;
  final Map<Definition, List<InstanceReference>>? instances;

  RecordUses({
    required this.metadata,
    this.calls,
    this.instances,
  });

  factory RecordUses.fromJson(Map<String, dynamic> json) {
    final identifiers = (json['identifiers'] as List)
        .whereType<Map<String, dynamic>>()
        .map(Identifier.fromJson)
        .toList();

    final callsJson = json['calls'] as Map<String, dynamic>;
    final calls = {
      Definition.fromJson(
        callsJson['definition'] as Map<String, dynamic>,
        identifiers,
      ): (callsJson['references'] as List)
          .map((x) => CallReference.fromJson(x as Map<String, dynamic>))
          .toList(),
    };

    final instancesJson = json['instances'] as Map<String, dynamic>;
    final instances = {
      Definition.fromJson(
        instancesJson['definition'] as Map<String, dynamic>,
        identifiers,
      ): (instancesJson['references'] as List)
          .map((x) => InstanceReference.fromJson(x as Map<String, dynamic>))
          .toList(),
    };
    return RecordUses(
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      calls: calls,
      instances: instances,
    );
  }

  Map<String, dynamic> toJson() {
    final identifiers = [
      if (calls != null) ...calls!.keys,
      if (instances != null) ...instances!.keys,
    ].map((definition) => definition.identifier).toList();
    return {
      'metadata': metadata.toJson(),
      'identifiers':
          identifiers.map((identifier) => identifier.toJson()).toList(),
      if (calls != null)
        'calls': calls!.entries
            .map((entry) => {
                  'definition': entry.key.toJson(identifiers),
                  'references':
                      entry.value.map((reference) => reference.toJson())
                })
            .toList(),
      if (instances != null)
        'instances': instances!.entries
            .map((entry) => {
                  'definition': entry.key.toJson(identifiers),
                  'references':
                      entry.value.map((reference) => reference.toJson())
                })
            .toList(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is RecordUses &&
        other.metadata == metadata &&
        listEquals(other.calls, calls);
  }

  @override
  int get hashCode => metadata.hashCode ^ calls.hashCode;
}

class Uses<T extends Reference> {
  final Definition definition;
  final List<T> references;

  Uses({
    required this.definition,
    required this.references,
  });

  factory Uses.fromJson(
    Map<String, dynamic> json,
    List<Identifier> identifiers,
    T Function(Map<String, dynamic>) constr,
  ) =>
      Uses(
        definition: Definition.fromJson(
          json['definition'] as Map<String, dynamic>,
          identifiers,
        ),
        references: (json['references'] as List)
            .map((x) => constr(x as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson(List<Identifier> identifiers) => {
        'definition': definition.toJson(identifiers),
        'references': references.map((x) => x.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Uses &&
        other.definition == definition &&
        listEquals(other.references, references);
  }

  @override
  int get hashCode => definition.hashCode ^ references.hashCode;
}

class Annotation {
  final Identifier identifier;
  final Map<String, dynamic> fields;

  Annotation({
    required this.identifier,
    required this.fields,
  });

  factory Annotation.fromJson(
    Map<String, dynamic> json,
    List<Identifier> identifiers,
  ) =>
      Annotation(
        identifier: identifiers[json['identifier'] as int],
        fields: json['fields'] as Map<String, dynamic>,
      );

  Map<String, dynamic> toJson(List<Identifier> identifiers) => {
        'identifier': identifiers.indexOf(identifier),
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
