// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';

import 'base.dart';
import 'metadata.dart';
import 'reference.dart';

class RecordUses {
  final Metadata metadata;
  final List<MethodCall>? methodCalls;
  final List<ConstantInstance>? constantInstances;

  RecordUses({
    required this.metadata,
    this.methodCalls,
    this.constantInstances,
  });

  factory RecordUses.fromJson(Map<String, dynamic> json) {
    final identifiers = (json['identifiers'] as List)
        .whereType<Map<String, dynamic>>()
        .map(Identifier.fromJson)
        .toList();
    return RecordUses(
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      methodCalls: (json['methodCalls'] as List)
          .map((x) =>
              MethodCall.fromJson(x as Map<String, dynamic>, identifiers))
          .toList(),
      constantInstances: (json['constantInstances'] as List)
          .map((x) =>
              ConstantInstance.fromJson(x as Map<String, dynamic>, identifiers))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final identifiers = <Identifier>[
      if (methodCalls != null)
        ...methodCalls!.expand(
          (call) => [
            ...call.annotations.map((annotation) => annotation.identifier),
            call.definition.identifier,
          ],
        ),
      if (constantInstances != null)
        ...constantInstances!.expand(
          (instance) => [
            ...instance.annotations.map((annotation) => annotation.identifier),
            instance.definition.identifier,
          ],
        ),
    ];
    return {
      'metadata': metadata.toJson(),
      'identifiers':
          identifiers.map((identifier) => identifier.toJson()).toList(),
      if (methodCalls != null)
        'methodCalls': methodCalls!
            .map((reference) => reference.toJson(identifiers))
            .toList(),
      if (constantInstances != null)
        'constantInstances': constantInstances!
            .map((reference) => reference.toJson(identifiers))
            .toList(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is RecordUses &&
        other.metadata == metadata &&
        listEquals(other.methodCalls, methodCalls);
  }

  @override
  int get hashCode => metadata.hashCode ^ methodCalls.hashCode;
}

class MethodCall {
  final List<Annotation> annotations;
  final Definition definition;
  final List<CallReference> references;

  MethodCall({
    required this.annotations,
    required this.definition,
    required this.references,
  });

  factory MethodCall.fromJson(
    Map<String, dynamic> json,
    List<Identifier> identifiers,
  ) =>
      MethodCall(
        annotations: (json['annotations'] as List)
            .map((x) =>
                Annotation.fromJson(x as Map<String, dynamic>, identifiers))
            .toList(),
        definition: Definition.fromJson(
          json['definition'] as Map<String, dynamic>,
          identifiers,
        ),
        references: (json['references'] as List)
            .map((x) => CallReference.fromJson(x as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson(List<Identifier> identifiers) => {
        'annotations': annotations.map((x) => x.toJson(identifiers)).toList(),
        'definition': definition.toJson(identifiers),
        'references': references.map((x) => x.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is MethodCall &&
        listEquals(other.annotations, annotations) &&
        other.definition == definition &&
        listEquals(other.references, references);
  }

  @override
  int get hashCode =>
      annotations.hashCode ^ definition.hashCode ^ references.hashCode;

  int? hashFor(Identifier id) =>
      annotations.any((annotation) => annotation.identifier == id)
          ? definition.hashCode ^ references.hashCode
          : null;
}

class ConstantInstance {
  final List<Annotation> annotations;
  final Definition definition;
  final List<InstanceReference> references;

  ConstantInstance({
    required this.annotations,
    required this.definition,
    required this.references,
  });

  factory ConstantInstance.fromJson(
    Map<String, dynamic> json,
    List<Identifier> identifiers,
  ) =>
      ConstantInstance(
        annotations: (json['annotations'] as List)
            .map((x) =>
                Annotation.fromJson(x as Map<String, dynamic>, identifiers))
            .toList(),
        definition: Definition.fromJson(
          json['definition'] as Map<String, dynamic>,
          identifiers,
        ),
        references: (json['references'] as List)
            .map((x) => InstanceReference.fromJson(x as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson(List<Identifier> identifiers) => {
        'annotations': annotations.map((x) => x.toJson(identifiers)).toList(),
        'definition': definition.toJson(identifiers),
        'references': references.map((x) => x.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is MethodCall &&
        listEquals(other.annotations, annotations) &&
        other.definition == definition &&
        listEquals(other.references, references);
  }

  @override
  int get hashCode =>
      annotations.hashCode ^ definition.hashCode ^ references.hashCode;

  int? hashFor(Identifier id) =>
      annotations.any((annotation) => annotation.identifier == id)
          ? definition.hashCode ^ references.hashCode
          : null;
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
