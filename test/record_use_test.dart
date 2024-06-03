import 'package:record_use/record_use_internal.dart';
import 'package:test/test.dart';
import 'package:version/version.dart';

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
    version: Version(1, 6, 2, preRelease: ['wip'], build: '5.-.2.z'),
    timestamp: DateTime.fromMillisecondsSinceEpoch(321432153),
    hashes: Hashes(
      noPositions: 'dasdsadfasfwagwraf',
      noPositionsNoLoadingUnits: 'fdsfdsafdsagh',
    ),
    comment:
        'Recorded references at compile time and their argument values, as far'
        ' as known, to definitions annotated with @RecordReference',
  ),
  staticFunctionReferences: [
    StaticFunctionReference(
      annotations: [
        Annotation(
          identifier: Identifier(
            uri:
                Uri.parse('file://lib/_internal/js_runtime/lib/js_helper.dart'),
            name: 'RecordReference',
          ),
          fields: {
            '_metadata': {'key': true}
          },
        ),
      ],
      definition: Definition(
        identifier: Identifier(
          uri: Uri.parse('file://lib/_internal/js_runtime/lib/js_helper.dart'),
          parent: 'MyClass',
          name: 'get:loadDeferredLibrary',
        ),
        location: Location(
          uri: Uri.parse('file://lib/_internal/js_runtime/lib/js_helper.dart'),
          line: 12,
          column: 67,
        ),
        loadingUnit: 'part_15.js',
      ),
      references: [
        Reference(
          arguments: Arguments(
            constArguments: ConstArguments(
              positional: {'0': 'lib_SHA1', '1': false, '2': 1},
              named: {'leroy': 'jenkins', 'freddy': 'mercury'},
            ),
          ),
          location: Location(
            uri: Uri.parse(
                'file://benchmarks/OmnibusDeferred/dart/OmnibusDeferred.dart'),
            line: 14,
            column: 49,
          ),
          loadingUnit: 'o.js',
        ),
        Reference(
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
                'file://benchmarks/OmnibusDeferred/dart/OmnibusDeferred.dart'),
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
          'identifier': {
            'uri': 'file://lib/_internal/js_runtime/lib/js_helper.dart',
            'name': 'RecordReference'
          },
          'fields': {
            '_metadata': {'key': true}
          }
        }
      ],
      'definition': {
        'identifier': {
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
