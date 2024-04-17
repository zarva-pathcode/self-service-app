import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TableOrder {
  String kdBrg;
  String namaBarang;
  int jumlah;
  String harga;
  String hargaAsli;
  String photo;
  double totalPerBarang;
  String diskon;
  String keterangan;
  TableOrder({
    required this.kdBrg,
    required this.namaBarang,
    required this.jumlah,
    required this.harga,
    required this.hargaAsli,
    required this.photo,
    required this.totalPerBarang,
    required this.diskon,
    required this.keterangan,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'kdBrg': kdBrg,
      'namaBarang': namaBarang,
      'jumlah': jumlah,
      'harga': harga,
      'hargaAsli': hargaAsli,
      'photo': photo,
      'totalPerBarang': totalPerBarang,
      'diskon': diskon,
      'keterangan': keterangan,
    };
  }

  factory TableOrder.fromMap(Map<String, dynamic> map) {
    return TableOrder(
      kdBrg: map['kdBrg'] as String,
      namaBarang: map['namaBarang'] as String,
      jumlah: map['jumlah'] as int,
      harga: map['harga'] as String,
      hargaAsli: map['hargaAsli'] as String,
      photo: map['photo'] as String,
      totalPerBarang: map['totalPerBarang'] as double,
      diskon: map['diskon'] as String,
      keterangan: map['keterangan'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TableOrder.fromJson(String source) =>
      TableOrder.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TableOrder(kdBrg: $kdBrg, namaBarang: $namaBarang, jumlah: $jumlah, harga: $harga, hargaAsli: $hargaAsli, photo: $photo, totalPerBarang: $totalPerBarang, diskon: $diskon, keterangan: $keterangan)';
  }

  @override
  bool operator ==(covariant TableOrder other) {
    if (identical(this, other)) return true;
  
    return 
      other.kdBrg == kdBrg &&
      other.namaBarang == namaBarang &&
      other.jumlah == jumlah &&
      other.harga == harga &&
      other.hargaAsli == hargaAsli &&
      other.photo == photo &&
      other.totalPerBarang == totalPerBarang &&
      other.diskon == diskon &&
      other.keterangan == keterangan;
  }

  @override
  int get hashCode {
    return kdBrg.hashCode ^
      namaBarang.hashCode ^
      jumlah.hashCode ^
      harga.hashCode ^
      hargaAsli.hashCode ^
      photo.hashCode ^
      totalPerBarang.hashCode ^
      diskon.hashCode ^
      keterangan.hashCode;
  }

  TableOrder copyWith({
    String? kdBrg,
    String? namaBarang,
    int? jumlah,
    String? harga,
    String? hargaAsli,
    String? photo,
    double? totalPerBarang,
    String? diskon,
    String? keterangan,
  }) {
    return TableOrder(
      kdBrg: kdBrg ?? this.kdBrg,
      namaBarang: namaBarang ?? this.namaBarang,
      jumlah: jumlah ?? this.jumlah,
      harga: harga ?? this.harga,
      hargaAsli: hargaAsli ?? this.hargaAsli,
      photo: photo ?? this.photo,
      totalPerBarang: totalPerBarang ?? this.totalPerBarang,
      diskon: diskon ?? this.diskon,
      keterangan: keterangan ?? this.keterangan,
    );
  }
}
