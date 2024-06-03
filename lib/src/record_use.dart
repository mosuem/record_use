// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';

import 'arguments.dart';
import 'base.dart';
import 'metadata.dart';
import 'record_use_data_class.dart';

extension type UsageRecord(RecordUses _recordUses) {
  UsageRecord._(this._recordUses);

  /// Show the metadata for this recording of usages.
  Metadata get metadata => _recordUses.metadata;

  /// Finds all arguments for the call to the [definition].
  Iterable<Arguments>? argumentsForCallsTo(Identifier definition) =>
      _recordUses.calls?.entries
          .firstWhereOrNull((call) => call.key.identifier == definition)
          ?.value
          .map((reference) => reference.arguments);

  /// Finds all instances of the  [definition].
  Iterable<Map<String, dynamic>>? fieldsForConstructionOf(
    Identifier definition,
  ) =>
      _recordUses.instances?.entries
          .firstWhereOrNull((instance) => instance.key.identifier == definition)
          ?.value
          .map((reference) => reference.fields);
}
