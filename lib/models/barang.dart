import 'dart:convert';

class Barang {
  String? kdBrg;
  String? nama;
  String? harga;
  String? hargaAsli;
  String? kdSubgrup;
  String? kdGrup;
  String? photo;
  String? diskon;
  Barang({
    this.kdBrg,
    this.nama,
    this.harga,
    this.hargaAsli,
    this.kdSubgrup,
    this.kdGrup,
    this.photo,
    this.diskon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'kd_brg': kdBrg,
      'nama': nama,
      'harga': harga,
      'harga_asli': hargaAsli,
      'kd_subgrup': kdSubgrup,
      'kd_grup': kdGrup,
      'photo': photo,
      'diskon': diskon,
    };
  }

  factory Barang.fromMap(Map<String, dynamic> map) {
    return Barang(
      kdBrg: map['kd_brg'] != null ? map['kd_brg'] as String : null,
      nama: map['nama'] != null ? map['nama'] as String : null,
      harga: map['harga'] != null ? map['harga'] as String : null,
      hargaAsli: map['harga_asli'] != null ? map['harga_asli'] as String : null,
      kdSubgrup: map['kd_subgrup'] != null ? map['kd_subgrup'] as String : null,
      kdGrup: map['kd_grup'] != null ? map['kd_grup'] as String : null,
      photo: map['photo'] != null ? map['photo'] as String : null,
      diskon: map['diskon'] != null ? map['diskon'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Barang.fromJson(String source) =>
      Barang.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(kd_brg: $kdBrg, nama: $nama, harga: $harga, harga_asli: $hargaAsli ,kd_subgrup: $kdSubgrup, kd_grup: $kdGrup, photo: $photo, diskon: $diskon)';
  }
}
