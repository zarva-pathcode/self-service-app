import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:self_service_app/services/api_path.dart';

class AppService {
  Future getAllProductData() async {
    final resp = await http.get(ApiPath.getProductData);
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body);

      return data;
    } else {
      throw "Error, ${resp.statusCode}";
    }
  }

  Future getProductSpecific(
      {required String tgl,
      required String kdKota,
      required String kdAplikasi,
      required String kdCus}) async {
    //? networkURL
    final resp = await http.get(ApiPath.getSpecificBarang(
        tgl: tgl, kdKota: kdKota, kdAplikasi: kdAplikasi, kdCus: kdCus));
    //? localURL
    // final resp = await http.get(ApiPath.getDataBarangFromLocal(
    //   tgl: tgl,
    //   kdKota: kdKota,
    //   kdAplikasi: kdAplikasi,
    //   kdCus: kdCus,
    // ));

    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body);
      // print(data);
      return data;
    } else {
      throw "Error, ${resp.statusCode}";
    }
  }

  Future getBarangBySpecificRequirement() async {
    final headers = <String,String>{
      "kd_kota" : "BDG",
    };

    final resp = await http.post(
      ApiPath.getBarangBySpecificRequirement,
      body: headers
    );

    if (resp.statusCode == 200) {
      final data = json.decode(resp.body);
      if (data!=null) {
        print("Ada Datanya");
      }
      return data;

    } else {
      throw "Error, ${resp.statusCode}";
    }
  }

  Future getAlatBayar() async {
    //? remoteURL
    final resp = await http.get(ApiPath.getAlatBayar);

    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body);
      return data;
    } else {
      throw "Error, ${resp.statusCode}";
    }
  }

  Future getVoucher() async {
    //? networkURL
    final resp = await http.get(ApiPath.getDataVoucher("2022-05-12"));

    //?localURL
    // final resp = await http.get(ApiPath.getDataVoucher("2022-05-12"));

    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body);

      return data;
    } else {
      throw "Error, ${resp.statusCode}";
    }
  }

  static Future postTojualDetil({
    required String jadi,
    required String faktur,
    required String kdAplikasi,
    required String kdPromo,
    required String kdCus,
    required String banyak,
    required String harga,
    required String diskon,
    required String jumlah,
    required String kdBarang,
    required String penyajian,
  }) async {
    final resp = await http.post(
      ApiPath.postJualDetil,
      body: {
        "faktur_jualdetil": jadi,
        "faktur_penjualan": faktur,
        "kd_cus": kdCus,
        "kd_aplikasi": kdAplikasi,
        "kd_promo": kdPromo,
        "kd_barang": kdBarang,
        "banyak": banyak,
        "harga": harga,
        "diskon": diskon,
        "jumlah": jumlah,
        "penyajian": penyajian,
      },
    );

    if (resp.statusCode == 200) {
      // print("Status Code : ${resp.statusCode}");
      print(resp.body);
      final data = jsonDecode(resp.body);
      print(data);
      return data;
    } else {
      throw "Error, Status Code ${resp.statusCode}";
    }
  }

  static Future postToPenjualan({
    required String faktur,
    required String kdAplikasi,
    required String kdCus,
    required String noMeja,
    required String namaKasir,
    required String subjumlah,
    required String ppn,
    required String jumlah,
    required String byrPocer,
    required String byrTunai,
    required String byrNonTunai,
    required String kdAlatBayar,
    required String noUrut,
    required String kdSubAlatBayar,
    required String subJumlahOffline,
    required String ketAplikasi,
    required String dasarFee,
    required String acuanFee,
    required String tarifFee,
    required String bPaking,
    required String noOnline,
    required String noOffline,
    required String tarifPb1,
  }) async {
    var map = {
      "faktur_penjualan": faktur,
      "kd_aplikasi": kdAplikasi,
      "kd_cus": kdCus,
      "no_meja": noMeja,
      "nama_kasir": namaKasir,
      "subjumlah": subjumlah,
      "ppn": ppn,
      "jumlah": jumlah,
      "byr_pocer": byrPocer,
      "byr_tunai": byrTunai,
      "byr_non_tunai": byrNonTunai,
      "kd_alatbayar": kdAlatBayar,
      "no_urut": noUrut,
      "kdsub_alatbayar": kdSubAlatBayar,
      "subjumlah_offline": subJumlahOffline,
      "ket_aplikasi": ketAplikasi,
      "dasar_fee": dasarFee,
      "acuan_fee": acuanFee,
      "tarif_fee": tarifFee,
      "b_paking": bPaking,
      "no_online": noOnline,
      "no_offline": noOffline,
      "tarif_pb1": tarifPb1,
    };
    final resp = await http.post(
      ApiPath.postPaymentPenjualan,
      body: map,
    );

    print("SENDING : $map");
    print("RESPONS : ${resp.body}");
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body);

      return data;
    } else {
      throw "Error, ${resp.statusCode}";
    }
  }
}
