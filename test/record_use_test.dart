import 'package:pub_semver/pub_semver.dart';
import 'package:record_use/record_use_internal.dart';
import 'package:test/test.dart';

void main() {
  test('First Test', () {
    expect(recordedUses.toJson(), recordedUsesJson);
  });
  test('First Test', () {
    expect(RecordUses.fromJson(recordedUsesJson), recordedUses);
  });
}

final recordedUses = RecordUses(
  metadata: Metadata(
    version: Version(1, 6, 2, pre: 'wip', build: '5.-.2.z'),
    timestamp: DateTime.fromMillisecondsSinceEpoch(321432153),
    comment:
        'Recorded references at compile time and their argument values, as far'
        ' as known, to definitions annotated with @RecordReference',
  ),
  instances: [],
  calls: [
    Uses(
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
    'version': '1.6.2-wip+5.-.2.z',
    'timestamp': 321432153,
    'hashes': {
      'noPositions': 'dasdsadfasfwagwraf',
      'noPositionsNoLoadingUnits': 'fdsfdsafdsagh'
    }
  },
  'staticFunctionReferences': [
    {
      'annotations': [
        {
          'id': {
            'uri': 'file://lib/_internal/js_runtime/lib/js_helper.dart',
            'name': 'RecordReference'
          },
          'fields': {
            '_metadata': {'key': true}
          }
        }
      ],
      'definition': {
        'id': {
          'uri': 'file://lib/_internal/js_runtime/lib/js_helper.dart',
          'parent': 'MyClass',
          'name': 'get:loadDeferredLibrary'
        },
        '@': {
          'uri': 'file://lib/_internal/js_runtime/lib/js_helper.dart',
          'line': 12,
          'column': 67
        },
        'loadingUnit': 'part_15.js'
      },
      'references': [
        {
          'arguments': {
            'const': {
              'positional': {'0': 'lib_SHA1', '1': false, '2': 1},
              'named': {'leroy': 'jenkins', 'freddy': 'mercury'}
            },
          },
          'loadingUnit': 'o.js',
          '@': {
            'uri':
                'file://benchmarks/OmnibusDeferred/dart/OmnibusDeferred.dart',
            'line': 14,
            'column': 49
          }
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
          '@': {
            'uri':
                'file://benchmarks/OmnibusDeferred/dart/OmnibusDeferred.dart',
            'line': 14,
            'column': 48
          }
        }
      ]
    }
  ]
};
