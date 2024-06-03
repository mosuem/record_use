import 'package:pub_semver/pub_semver.dart';

class Metadata {
  final String? comment;
  final Version version;
  final DateTime timestamp;

  Metadata({
    this.comment,
    required this.version,
    required this.timestamp,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        comment: json['comment'] as String?,
        version: Version.parse(json['version'] as String),
        timestamp:
            DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
      );

  Map<String, dynamic> toJson() => {
        if (comment != null) 'comment': comment,
        'version': version.toString(),
        'timestamp': timestamp.millisecondsSinceEpoch,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Metadata &&
        other.comment == comment &&
        other.version == version &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return comment.hashCode ^ version.hashCode ^ timestamp.hashCode;
  }

  @override
  String toString() {
    return '''
Metadata(
  comment: $comment,
  version: $version,
  timestamp: $timestamp,
)
''';
  }
}
