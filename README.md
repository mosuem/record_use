# `package:record_use`


> [!CAUTION]
> This is an experimental package, and it's API can break at any time. Use at
> your own discretion.

This package provides the data classes for the usage recording feature in the
Dart SDK.

Dart objects with the `@RecordUse` annotation are being recorded at compile 
time, providing the user with information. The information depends on the object
being recorded.

- If placed on a static method, the annotation means that arguments passed to
the method will be recorded, as far as they can be inferred at compile time.
- If placed on a class with a constant constructor, the annotation means that
any constant instance of the class will be recorded. This is particularly useful
when using the class as an annotation.

## Example

```dart
import 'package:meta/meta.dart' show RecordUse;

void main() {
  print(SomeClass.stringMetadata(42));
  print(SomeClass.doubleMetadata(42));
  print(SomeClass.intMetadata(42));
  print(SomeClass.boolMetadata(42));
}

class SomeClass {
  @RecordMetadata('leroyjenkins')
  @RecordUse()
  static stringMetadata(int i) {
    return i + 1;
  }

  @RecordMetadata(3.14)
  @RecordUse()
  static doubleMetadata(int i) {
    return i + 1;
  }

  @RecordMetadata(42)
  @RecordUse()
  static intMetadata(int i) {
    return i + 1;
  }

  @RecordMetadata(true)
  @RecordUse()
  static boolMetadata(int i) {
    return i + 1;
  }
}

@RecordUse()
class RecordMetadata {
  final Object metadata;

  const RecordMetadata(this.metadata);
}

```
This code will generate a data file that contains both the `metadata` values of
the `RecordMetadata` instances, as well as the arguments for the different
methods annotated with `@RecordUse()`.

This information can then be accessed in a link hook as follows:
```dart
import 'package:native_assets_cli/native_assets_cli.dart';

void main(List<String> arguments){
  link(arguments, (config, output) async {
    final uses = config.recordedUses;
    
    final args = uses.constArgumentsTo(boolMetadataId));
    //[args] is an iterable of arguments, in this case containing "42"

    final fields = uses.instanceReferencesTo(recordMetadataId);
    //[fields] is an iterable of the fields of the class, in this case
    //containing
    // {"arguments": "leroyjenkins"}
    // {"arguments": 3.14}
    // {"arguments": 42}
    // {"arguments": true}

    ... // Do something with the information, such as tree-shaking native assets
  });
}
```

## Installation
To install the record_use package, run the following command:

```bash
dart pub add record_use
```

## Internals

The data is stored in protobuf format. Two schemas are provided:

### [usages_read](lib/src/proto/usages_read.proto)
This is the schema for the internal API for the storage format, which is used
in the SDK for writing the data, and in the [record_use](lib/src/record_use.dart) format for retrieving the
data for the queries from the user.

### [usages_storage](lib/src/proto/usages_storage.proto)
This schema is for the storage of the data, and contains some optimizations such
as collecting all URIs in a table, to avoid repetitions.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request.