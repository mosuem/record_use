// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';

import 'data_classes/arguments.dart';
import 'data_classes/identifier.dart';
import 'data_classes/metadata.dart';
import 'data_classes/reference.dart';
import 'data_classes/usage.dart';
import 'data_classes/usage_record.dart';

extension type RecordUse._(UsageRecord _recordUses) {
  /// Show the metadata for this recording of usages.
  Metadata get metadata => _recordUses.metadata;

  /// Finds all arguments for calls to the [definition].
  ///
  /// The definition must be annotated with `@RecordMethodUse`. If there are no
  /// calls to the definition, either because it was treeshaken, because it
  /// was not annotated, or because it does not exist, returns `null`.
  ///
  /// Returns an empty list if the arguments were not collected.
  Iterable<Arguments>? argumentsForCallsTo(Identifier definition) =>
      _callTo(definition)
          ?.references
          .map((reference) => reference.arguments)
          .whereType();

  /// Finds all fields of a const construction of the class at [definition].
  ///
  /// The definition must be annotated with `@RecordAnnotationUse`. If there are
  /// no instances of the definition, either because it was treeshaken, because
  /// it was not annotated, or because it does not exist, returns `null`.
  Iterable<Map<String, dynamic>>? fieldsForConstructionOf(
    Identifier definition,
  ) =>
      _recordUses.instances
          .firstWhereOrNull(
              (instance) => instance.definition.identifier == definition)
          ?.references
          .map((reference) => reference.fields);

  /// Checks if any call to [definition] has non-const arguments.
  ///
  /// The definition must be annotated with `@RecordMethodUse`. If there are no
  /// calls to the definition, either because it was treeshaken, because it
  /// was not annotated, or because it does not exist, returns `false`.
  bool hasNonConstArguments(Identifier definition) =>
      _callTo(definition)?.references.any(
        (reference) {
          final nonConstArguments = reference.arguments?.nonConstArguments;
          final hasNamed = nonConstArguments?.named.isNotEmpty ?? false;
          final hasPositional =
              nonConstArguments?.positional.isNotEmpty ?? false;
          return hasNamed || hasPositional;
        },
      ) ??
      false;

  Usage<CallReference>? _callTo(Identifier definition) => _recordUses.calls
      .firstWhereOrNull((call) => call.definition.identifier == definition);
}
