
import 'dart:convert';

class Pelanggan {
  String? idPelanggan;
  String? namaPelanggan;
  String? lokasi;
  String? kdCus;
  String? kdKota;
  String? kdArea;
  Pelanggan({
    this.idPelanggan,
    this.namaPelanggan,
    this.lokasi,
    this.kdCus,
    this.kdKota,
    this.kdArea,
  });
  

  Pelanggan copyWith({
    String? idPelanggan,
    String? namaPelanggan,
    String? lokasi,
    String? kdCus,
    String? kdKota,
    String? kdArea,
  }) {
    return Pelanggan(
      idPelanggan: idPelanggan ?? this.idPelanggan,
      namaPelanggan: namaPelanggan ?? this.namaPelanggan,
      lokasi: lokasi ?? this.lokasi,
      kdCus: kdCus ?? this.kdCus,
      kdKota: kdKota ?? this.kdKota,
      kdArea: kdArea ?? this.kdArea,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_pelanggan': idPelanggan,
      'nama_pelanggan': namaPelanggan,
      'lokasi': lokasi,
      'kd_cus': kdCus,
      'kd_kota': kdKota,
      'kd_area': kdArea,
    };
  }

  factory Pelanggan.fromMap(Map<String, dynamic> map) {
    return Pelanggan(
      idPelanggan: map['id_pelanggan'] != null ? map['id_pelanggan'] as String : null,
      namaPelanggan: map['nama_pelanggan'] != null ? map['nama_pelanggan'] as String : null,
      lokasi: map['lokasi'] != null ? map['lokasi'] as String : null,
      kdCus: map['kd_cus'] != null ? map['kd_cus'] as String : null,
      kdKota: map['kd_kota'] != null ? map['kd_kota'] as String : null,
      kdArea: map['kd_area'] != null ? map['kd_area'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pelanggan.fromJson(String source) => Pelanggan.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pelanggan(id_pelanggan: $idPelanggan, nama_pelanggan: $namaPelanggan, lokasi: $lokasi, kd_cus: $kdCus, kd_kota: $kdKota, kd_area: $kdArea)';
  }

  @override
  bool operator ==(covariant Pelanggan other) {
    if (identical(this, other)) return true;
  
    return 
      other.idPelanggan == idPelanggan &&
      other.namaPelanggan == namaPelanggan &&
      other.lokasi == lokasi &&
      other.kdCus == kdCus &&
      other.kdKota == kdKota &&
      other.kdArea == kdArea;
  }

  @override
  int get hashCode {
    return idPelanggan.hashCode ^
      namaPelanggan.hashCode ^
      lokasi.hashCode ^
      kdCus.hashCode ^
      kdKota.hashCode ^
      kdArea.hashCode;
  }
}
