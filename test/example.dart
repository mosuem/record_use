// ignore_for_file: non_constant_identifier_names, prefer_function_declarations_over_variables, lines_longer_than_80_chars, unused_field

import 'package:pub_semver/pub_semver.dart';
import 'package:record_use/record_use_internal.dart';
import 'package:record_use/src/record_use.dart';

void main() {
  final usage = UsageRecord(recordedJUses).fieldsForConstructionOf(jMethodIdid);
  final buffer = StringBuffer();
  for (final useCase in usage ?? <Map<String, dynamic>>[]) {
    final id = JMethodId.fromJson(useCase);
    buffer.writeln('$id');
  }
  print(buffer.toString());
}

/*


 package:foo


*/

class Foo extends JObject {
  @JClassId('...')
  static final _jClass = Object();

  @JMethodId('package.something.Foo', '<init>', '...')
  static final _new_id = Object();

  @JMethodId('package.something.Foo', '<init>', '...')
  static final _new1_id = Object();

  static final _foo_id = () {};

  @JMethodId('package.something.Foo', 'foo', '')
  void foo(JString str) {
    _foo_id();
  }

  // the same for bar()
}

/*

Mocks

*/

class RecordAnnotationUse {
  const RecordAnnotationUse();
}

// package:jni
@RecordAnnotationUse()
class JClassId {
  const JClassId(String s);
}

@RecordAnnotationUse()
class JMethodId {
  final String id;
  final String jMethodName;
  final String s;

  const JMethodId(this.id, this.jMethodName, this.s);

  factory JMethodId.fromJson(Map<String, dynamic> useCase) => JMethodId(
        useCase['id'] as String,
        useCase['jMethodName'] as String,
        useCase['s'] as String,
      );
  @override
  String toString() {
    return '$id, $jMethodName, $s';
  }
}

class JObject {}

class JString {}

final jClassIdid = Identifier(
  uri: Uri.parse('package:foo/somefile.dart').toString(),
  name: 'JClassId',
);

final jMethodIdid = Identifier(
  uri: Uri.parse('package:foo/somefile.dart').toString(),
  name: 'JMethodId',
);
final recordedJUses = RecordUses(
  metadata: Metadata(
    version: Version(0, 1, 0),
  ),
  instances: [
    Uses(
      definition: Definition(
        identifier: jClassIdid,
        location: Location(
          uri: Uri.parse('package:foo/somefile.dart').toString(),
          line: 50,
          column: 20,
        ),
      ),
      references: [
        InstanceReference(
          location: Location(
            uri: Uri.parse('package:foo/somefile.dart').toString(),
            line: 28,
            column: 20,
          ),
          fields: {'s': '...'},
        ),
      ],
    ),
    Uses(
      definition: Definition(
        identifier: jMethodIdid,
        location: Location(
          uri: Uri.parse('package:foo/somefile.dart').toString(),
          line: 50,
          column: 20,
        ),
      ),
      references: [
        InstanceReference(
          location: Location(
            uri: Uri.parse('package:foo/somefile.dart').toString(),
            line: 15,
            column: 20,
          ),
          fields: {
            'id': 'package.something.Foo',
            'jMethodName': '<init>',
            's': '...',
          },
        ),
        InstanceReference(
          location: Location(
            uri: Uri.parse('package:foo/somefile.dart').toString(),
            line: 17,
            column: 20,
          ),
          fields: {
            'id': 'package.something.Foo',
            'jMethodName': '<init>',
            's': '...',
          },
        ),
        InstanceReference(
          location: Location(
            uri: Uri.parse('package:foo/somefile.dart').toString(),
            line: 30,
            column: 20,
          ),
          fields: {
            'id': 'package.something.Foo',
            'jMethodName': 'foo',
            's': '',
          },
        ),
      ],
    ),
  ],
);
