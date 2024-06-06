// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_semver/pub_semver.dart';
import 'package:record_use/record_use_internal.dart';
import 'package:test/test.dart';

void main() {
  test('Json->Object->Json', () {
    expect(UsageRecord.fromJson(recordedUsesJson).toJson(), recordedUsesJson);
  });
  test('Object->Json->Object', () {
    expect(UsageRecord.fromJson(recordedUses.toJson()), recordedUses);
  });
}

final recordedUses = UsageRecord(
  metadata: Metadata(
    version: Version(1, 6, 2, pre: 'wip', build: '5.-.2.z'),
    comment:
        'Recorded references at compile time and their argument values, as far'
        ' as known, to definitions annotated with @RecordReference',
  ),
  instances: [],
  calls: [
    Usage(
      definition: Definition(
        identifier: Identifier(
          uri: Uri.parse('file://lib/_internal/js_runtime/lib/js_helper.dart')
              .toString(),
          parent: 'MyClass',
          name: 'get:loadDeferredLibrary',
        ),
        location: Location(
          uri: Uri.parse('file://lib/_internal/js_runtime/lib/js_helper.dart')
              .toString(),
          line: 12,
          column: 67,
        ),
        loadingUnit: 'part_15.js',
      ),
      references: [
        CallReference(
          arguments: Arguments(
            constArguments: ConstArguments(
              positional: {'0': 'lib_SHA1', '1': false, '2': 1},
              named: {'leroy': 'jenkins', 'freddy': 'mercury'},
            ),
          ),
          location: Location(
            uri: Uri.parse(
                    'file://benchmarks/OmnibusDeferred/dart/OmnibusDeferred.dart')
                .toString(),
            line: 14,
            column: 49,
          ),
          loadingUnit: 'o.js',
        ),
        CallReference(
          arguments: Arguments(
            constArguments: ConstArguments(
              positional: {'0': 'lib_SHA1', '2': 0},
              named: {'leroy': 'jenkins'},
            ),
            nonConstArguments: NonConstArguments(
              positional: ['1'],
              named: ['freddy'],
            ),
          ),
          location: Location(
            uri: Uri.parse(
                    'file://benchmarks/OmnibusDeferred/dart/OmnibusDeferred.dart')
                .toString(),
            line: 14,
            column: 48,
          ),
          loadingUnit: 'o.js',
        ),
      ],
    ),
  ],
);

final recordedUsesJson = {
  'metadata': {
    'comment':
        'Recorded references at compile time and their argument values, as far'
            ' as known, to definitions annotated with @RecordReference',
    'version': '1.6.2-wip+5.-.2.z'
  },
  'uris': [
    'file://lib/_internal/js_runtime/lib/js_helper.dart',
    'file://benchmarks/OmnibusDeferred/dart/OmnibusDeferred.dart'
  ],
  'ids': [
    {'uri': 0, 'parent': 'MyClass', 'name': 'get:loadDeferredLibrary'}
  ],
  'calls': [
    {
      'definition': {
        'id': 0,
        '@': {'line': 12, 'column': 67},
        'loadingUnit': 'part_15.js'
      },
      'references': [
        {
          'arguments': {
            'const': {
              'positional': {'0': 'lib_SHA1', '1': false, '2': 1},
              'named': {'leroy': 'jenkins', 'freddy': 'mercury'}
            }
          },
          'loadingUnit': 'o.js',
          '@': {'uri': 1, 'line': 14, 'column': 49}
        },
        {
          'arguments': {
            'const': {
              'positional': {'0': 'lib_SHA1', '2': 0},
              'named': {'leroy': 'jenkins'}
            },
            'nonConst': {
              'positional': ['1'],
              'named': ['freddy']
            }
          },
          'loadingUnit': 'o.js',
          '@': {'uri': 1, 'line': 14, 'column': 48}
        }
      ]
    }
  ]
};
