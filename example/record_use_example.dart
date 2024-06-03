import 'package:record_use/record_use_internal.dart';

void doStuff(UsageRecord usage) {
  print(usage.metadata.toString());
  print(usage.annotations);
}
