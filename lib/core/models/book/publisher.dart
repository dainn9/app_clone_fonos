import '../base_model.dart';

class Publisher implements BaseModel {
  final String? publisherId;
  final String? publisherName;
  final String? description;
  final String? website;
  final int? foundedYear;

  Publisher({
    this.publisherId,
    this.publisherName,
    this.description,
    this.website,
    this.foundedYear,
  });

  factory Publisher.fromJson(Map<String, dynamic> json) {
    return Publisher(
      publisherId: json['publisherId'],
      publisherName: json['publisherName'],
      description: json['description'],
      website: json['website'],
      foundedYear: json['foundedYear'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'publisherId': publisherId,
      'publisherName': publisherName,
      'description': description,
      'website': website,
      'foundedYear': foundedYear,
    };
  }
}
