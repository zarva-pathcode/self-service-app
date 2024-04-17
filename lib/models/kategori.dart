import 'dart:convert';

class Kategori {
  String id;
  String nama;
  String icon;

  Kategori({
    required this.id,
    required this.nama,
    required this.icon
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'icon': icon
    };
  }

  factory Kategori.fromMap(Map<String, dynamic> map) {
    return Kategori(
      id: map['id'] as String,
      nama: map['nama'] as String,
      icon: map['icon'] as String
    );
  }

  String toJson() => json.encode(toMap());

  factory Kategori.fromJson(String source) =>
      Kategori.fromMap(json.decode(source) as Map<String, dynamic>);
}
