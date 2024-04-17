
import 'dart:convert';

class AlatBayar {
  String? kdAlat;
  String? nama;
  String? photo;
  AlatBayar({
    this.kdAlat,
    this.nama,
    this.photo,
  });


  AlatBayar copyWith({
    String? kdAlat,
    String? nama,
    String? photo,
  }) {
    return AlatBayar(
      kdAlat: kdAlat ?? this.kdAlat,
      nama: nama ?? this.nama,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'kd_alat': kdAlat,
      'nama': nama,
      'photo': photo,
    };
  }

  factory AlatBayar.fromMap(Map<String, dynamic> map) {
    return AlatBayar(
      kdAlat: map['kd_alat'] != null ? map['kd_alat'] as String : null,
      nama: map['nama'] != null ? map['nama'] as String : null,
      photo: map['photo'] != null ? map['photo'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AlatBayar.fromJson(String source) => AlatBayar.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AlatBayar(kd_alat: $kdAlat, nama: $nama, photo: $photo)';

  @override
  bool operator ==(covariant AlatBayar other) {
    if (identical(this, other)) return true;
  
    return 
      other.kdAlat == kdAlat &&
      other.nama == nama &&
      other.photo == photo;
  }

  @override
  int get hashCode => kdAlat.hashCode ^ nama.hashCode ^ photo.hashCode;
}
