# `record_use`
This package provides the data classes for the usage recording feature.

Dart objects with the `@RecordUse` annotation are being recorded at compile 
time, providing the user with information. The information depends on the object
being recorded.

- If placed on a static method, the annotation means that calls to the method
are being recorded. If the `arguments` parameter is set to `true`, then
arguments will also be recorded, as far as they can be inferred at compile time.
- If placed on a class with a constant constructor, the annotation means that
any constant instance of the class will be recorded. This is particularly useful
when placing 

Example
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
  @RecordUse(arguments: true)
  static stringMetadata(int i) {
    return i + 1;
  }

  @RecordMetadata(3.14)
  @RecordUse(arguments: true)
  static doubleMetadata(int i) {
    return i + 1;
  }

  @RecordMetadata(42)
  @RecordUse(arguments: true)
  static intMetadata(int i) {
    return i + 1;
  }

  @RecordMetadata(true)
  @RecordUse(arguments: true)
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
This code will generate a JSON file that contains the following information:

## Installation
To install the record_use package, run the following command:

```bash
dart pub add record_use
```

## Contributing
Contributions are welcome! Please open an issue or submit a pull request.