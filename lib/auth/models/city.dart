class City {
  final String id;
  final String governorateId;
  final String name;
  final String nameAr;

  City({
    required this.id,
    required this.governorateId,
    required this.name,
    required this.nameAr,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        governorateId: json["governorate_id"],
        name: json["city_name_en"],
        nameAr: json["city_name_ar"],
      );
}
