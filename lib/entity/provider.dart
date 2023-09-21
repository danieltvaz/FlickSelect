class Provider {
  final String logo_path;
  final String provider_id;
  final String provider_name;
  final String display_priority;

  Provider(
      {required this.logo_path,
      required this.provider_id,
      required this.provider_name,
      required this.display_priority});

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      logo_path: json['logo_path'],
      provider_id: json['provider_id'],
      provider_name: json['provider_name'],
      display_priority: json['display_priority'],
    );
  }
}
