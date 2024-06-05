// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';

import 'definition.dart';
import 'identifier.dart';
import 'reference.dart';

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
