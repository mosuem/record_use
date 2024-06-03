// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';

import 'base.dart';
import 'metadata.dart';
import 'record_use_data_class.dart';
import 'reference.dart';

extension type UsageRecord(RecordUses _recordUses) {
  UsageRecord._(this._recordUses);

  /// Show the metadata for this recording of usages.
  Metadata get metadata => _recordUses.metadata;

  /// Finds all references to the [definition].
  Iterable<CallReference>? calls(Identifier definition) =>
      _recordUses.methodCalls
          ?.firstWhereOrNull((call) => call.definition.identifier == definition)
          ?.references;

  /// Finds all instances of the  [definition].
  Iterable<InstanceReference>? instances(Identifier definition) =>
      _recordUses.constantInstances
          ?.firstWhereOrNull(
              (instance) => instance.definition.identifier == definition)
          ?.references;
}
