// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';

import 'base.dart';
import 'metadata.dart';
import 'reference.dart';

class RecordUses {
  final Metadata metadata;
  final List<Uses<CallReference>>? calls;
  final List<Uses<InstanceReference>>? instances;

  RecordUses({
    required this.metadata,
    this.calls,
    this.instances,
  });

  factory RecordUses.fromJson(Map<String, dynamic> json) {
    final uris = json['uris'] as List<String>;
    final identifiers = (json['identifiers'] as List)
        .whereType<Map<String, dynamic>>()
        .map(
          (e) => Identifier.fromJson(e, uris),
        )
        .toList();
    return RecordUses(
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      calls: (json['methodCalls'] as List)
          .map((x) => Uses.fromJson(
                x as Map<String, dynamic>,
                identifiers,
                uris,
                CallReference.fromJson,
              ))
          .toList(),
      instances: (json['constantInstances'] as List)
          .map((x) => Uses.fromJson(
                x as Map<String, dynamic>,
                identifiers,
                uris,
                InstanceReference.fromJson,
              ))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final identifiers = <Identifier>{
      if (calls != null) ...calls!.map((call) => call.definition.identifier),
      if (instances != null)
        ...instances!.map((instance) => instance.definition.identifier),
    }.toList();
    final uris = <String>{
      ...identifiers.map((e) => e.uri),
      if (calls != null)
        ...calls!.expand((call) => [
              call.definition.location.uri,
              ...call.references.map((reference) => reference.location.uri),
            ]),
      if (instances != null)
        ...instances!.expand((instance) => [
              instance.definition.location.uri,
              ...instance.references.map((reference) => reference.location.uri),
            ]),
    }.toList();
    return {
      'metadata': metadata.toJson(),
      'uris': uris,
      'ids': identifiers.map((identifier) => identifier.toJson(uris)).toList(),
      if (calls != null && calls!.isNotEmpty)
        'methodCalls': calls!
            .map((reference) => reference.toJson(identifiers, uris))
            .toList(),
      if (instances != null && instances!.isNotEmpty)
        'constantInstances': instances!
            .map((reference) => reference.toJson(identifiers, uris))
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
    List<String> uris,
    T Function(Map<String, dynamic>, List<String>) constr,
  ) =>
      Uses(
        definition: Definition.fromJson(
          json['definition'] as Map<String, dynamic>,
          identifiers,
        ),
        references: (json['references'] as List)
            .map((x) => constr(x as Map<String, dynamic>, uris))
            .toList(),
      );

  Map<String, dynamic> toJson(
    List<Identifier> identifiers,
    List<String> uris,
  ) =>
      {
        'definition': definition.toJson(identifiers, uris),
        'references': references.map((x) => x.toJson(uris)).toList(),
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
        identifier: identifiers[json['id'] as int],
        fields: json['fields'] as Map<String, dynamic>,
      );

  Map<String, dynamic> toJson(List<Identifier> identifiers) => {
        'id': identifiers.indexOf(identifier),
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
