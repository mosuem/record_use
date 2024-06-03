// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:version/version.dart';

part 'record_use_internal.dart';

extension type UsageRecord(RecordUses _recordUses) {
  UsageRecord._(this._recordUses);

  /// Show the metadata for this recording of usages.
  Metadata get metadata => _recordUses.metadata;

  /// All annotations used which were recorded for any usage.
  Iterable<Identifier> get annotations => _recordUses.staticFunctionReferences
      .expand((e) => e.annotations.map((e) => e.identifier));

  /// All definitions found for a certain [annotation].
  Iterable<Identifier> definitions(Identifier annotation) =>
      _recordUses.staticFunctionReferences
          .where((element) => element.annotations.any(
                (element) => element.identifier == annotation,
              ))
          .map((e) => e.definition.identifier);

  /// The constant arguments recorded for the [definition].
  Iterable<ConstArguments> forDefinition(Identifier definition) =>
      _recordUses.staticFunctionReferences
          .where((element) => element.definition.identifier == definition)
          .expand((e) => e.references)
          .map((e) => e.arguments?.constArguments)
          .whereType<ConstArguments>();
}
