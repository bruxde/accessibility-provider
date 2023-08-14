import 'package:flutter/foundation.dart';

class AudioCue {
  final String name;
  final String url;
  final Uint8List? bytes;

  AudioCue({
    this.url = '',
    this.bytes,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "url": url,
    };
  }

  static AudioCue fromJson(Map<String, dynamic> json) {
    return AudioCue(
      name: json["name"] ?? "",
      url: json["url"] ?? "",
    );
  }

  AudioCue copyWith({
    String? id,
    String? name,
    String? url,
    Uint8List? bytes,
  }) {
    return AudioCue(
      url: url ?? this.url,
      name: name ?? this.name,
      bytes: bytes ?? this.bytes,
    );
  }
}
