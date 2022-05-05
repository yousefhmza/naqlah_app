class Governorate {
  final String id;
  final String name;
  final String nameAr;

  Governorate({
    required this.id,
    required this.name,
    required this.nameAr,
  });

  factory Governorate.fromJson(Map<String, dynamic> json) => Governorate(
        id: json["id"],
        name: json["governorate_name_en"],
        nameAr: json["governorate_name_ar"],
      );
}
