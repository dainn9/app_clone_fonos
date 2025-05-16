import '../base_model.dart';
import 'audiobook.dart';

class Download implements BaseModel {
  final String? downloadId;
  final String? appUserId;
  final String? audiobookId;
  final DateTime? downloadDate;
  final String? deviceInfo;
  final String? ipAddress;
  final Audiobook? audiobook;

  Download({
    this.downloadId,
    this.appUserId,
    this.audiobookId,
    this.downloadDate,
    this.deviceInfo,
    this.ipAddress,
    this.audiobook,
  });

  factory Download.fromJson(Map<String, dynamic> json) {
    return Download(
      downloadId: json['downloadId'],
      appUserId: json['appUserId'],
      audiobookId: json['audiobookId'],
      downloadDate: json['downloadDate'] != null ? DateTime.parse(json['downloadDate']) : null,
      deviceInfo: json['deviceInfo'],
      ipAddress: json['ipAddress'],
      audiobook: json['audiobook'] != null ? Audiobook.fromJson(json['audiobook']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'downloadId': downloadId,
      'appUserId': appUserId,
      'audiobookId': audiobookId,
      'downloadDate': downloadDate?.toIso8601String(),
      'deviceInfo': deviceInfo,
      'ipAddress': ipAddress,
      'audiobook': audiobook?.toJson(),
    };
  }
}
