import 'package:pub_semver/pub_semver.dart';

class Metadata {
  final String? comment;
  final Version version;

  Metadata({
    this.comment,
    required this.version,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        comment: json['comment'] as String?,
        version: Version.parse(json['version'] as String),
      );

  Map<String, dynamic> toJson() => {
        if (comment != null) 'comment': comment,
        'version': version.toString(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Metadata &&
        other.comment == comment &&
        other.version == version;
  }

  @override
  int get hashCode {
    return comment.hashCode ^ version.hashCode;
  }

  @override
  String toString() {
    return '''
Metadata(
  comment: $comment,
  version: $version,
)
''';
  }
}
