// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Voucher {
  String noPocer;
  // String cakupan;
  String nilai;
  // String hargaJual;
  // String tglTerbit;
  // String tglDaluarsa;
  Voucher({
    required this.noPocer,
    // required this.cakupan,
    required this.nilai,
    // required this.hargaJual,
    // required this.tglTerbit,
    // required this.tglDaluarsa,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'no_pocer': noPocer,
      // 'cakupan': cakupan,
      'nilai': nilai,
      // 'harga_jual': hargaJual,
      // 'tgl_terbit': tglTerbit,
      // 'tgl_daluarsa': tglDaluarsa,
    };
  }

  factory Voucher.fromMap(Map<String, dynamic> map) {
    return Voucher(
      noPocer: map['no_pocer'] as String,
      // cakupan: map['cakupan'] as String,
      nilai: map['nilai'] as String,
      // hargaJual: map['harga_jual'] as String,
      // tglTerbit: map['tgl_terbit'] as String,
      // tglDaluarsa: map['tgl_daluarsa'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Voucher.fromJson(String source) =>
      Voucher.fromMap(json.decode(source) as Map<String, dynamic>);
}
