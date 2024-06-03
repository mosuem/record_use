// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'record_use.dart';

extension RecordUseExtension on RecordUses {
  Map<String, dynamic> toJson() => {
        'metadata': metadata.toJson(),
        'staticFunctionReferences': staticFunctionReferences
            .map((reference) => reference.toJson())
            .toList(),
      };

  int hashFor(Identifier id) => Object.hashAll(
      staticFunctionReferences.map((e) => e.hashFor(id)).whereType<int>());

  static RecordUses fromJson(Map<String, dynamic> json) => RecordUses(
        metadata: MetadataExtension.fromJson(
            json['metadata'] as Map<String, dynamic>),
        staticFunctionReferences: List<StaticFunctionReference>.from(
            (json['staticFunctionReferences'] as List).map((x) =>
                StaticFunctionReference.fromJson(x as Map<String, dynamic>))),
      );
}

extension MetadataExtension on Metadata {
  static Metadata build({
    String? comment,
    required Version version,
    required DateTime timestamp,
    required Hashes hashes,
  }) =>
      Metadata._(
        comment: comment,
        version: version,
        timestamp: timestamp,
        hashes: hashes,
      );

  static Metadata fromJson(Map<String, dynamic> json) => Metadata._(
        comment: json['comment'] as String?,
        version: Version.parse(json['version'] as String),
        timestamp:
            DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
        hashes: Hashes.fromJson(json['hashes'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        if (comment != null) 'comment': comment,
        'version': version.toString(),
        'timestamp': timestamp.millisecondsSinceEpoch,
        'hashes': hashes.toJson(),
      };
}
