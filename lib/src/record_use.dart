// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';

import 'arguments.dart';
import 'base.dart';
import 'metadata.dart';
import 'record_use_data_class.dart';
import 'reference.dart';

extension type UsageRecord(RecordUses _recordUses) {
  UsageRecord._(this._recordUses);

  /// Show the metadata for this recording of usages.
  Metadata get metadata => _recordUses.metadata;

  /// Finds all arguments for calls to the [definition].
  ///
  /// The definition must be annotated with `@RecordMethodUse`. If there are no
  /// calls to the definition, either because it was treeshaken, because it
  /// was not annotated, or because it does not exist, returns `false`.
  Iterable<Arguments>? argumentsForCallsTo(Identifier definition) =>
      _callTo(definition)?.references.map((reference) => reference.arguments);

  /// Finds all fields of a const construction of the class at [definition].
  ///
  /// The definition must be annotated with `@RecordAnnotationUse`. If there are
  /// no instances of the definition, either because it was treeshaken, because
  /// it was not annotated, or because it does not exist, returns `null`.
  Iterable<Map<String, dynamic>>? fieldsForConstructionOf(
    Identifier definition,
  ) =>
      _recordUses.instances
          ?.firstWhereOrNull(
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
        (element) {
          final nonConstArguments = element.arguments.nonConstArguments;
          return nonConstArguments?.named?.isNotEmpty ??
              false || (nonConstArguments?.positional?.isNotEmpty ?? false);
        },
      ) ??
      false;

  Uses<CallReference>? _callTo(Identifier definition) => _recordUses.calls
      ?.firstWhereOrNull((call) => call.definition.identifier == definition);
}
