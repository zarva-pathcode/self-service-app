

import '../helper/constant.dart';

class ApiPath {
  static Uri getProductData = Uri.parse("$remoteEndpoint/get_data_barang.php");
  static Uri getJenisProductData =
      Uri.parse("$remoteEndpoint/get_data_jenis_barang.php");
  static Uri checkNoFaktur = Uri.parse("$remoteEndpoint/check_no_faktur.php");
  static Uri postPaymentPenjualan =
      Uri.parse("$remoteEndpoint/post_penjualan_data.php");
  static Uri postJualDetil =
      Uri.parse("$remoteEndpoint/post_jualdetil_data.php");
  static Uri getDataVoucher(String tgl) =>
      Uri.parse("$remoteEndpoint/get_data_voucher.php?tgl=$tgl");
  static Uri loginUserNetwork = Uri.parse("$remoteEndpoint/login_user.php");
  static Uri getAlatBayar = Uri.parse("$remoteEndpoint/get_alat_bayar.php");
  static Uri getSpecificBarang({
    required String tgl,
    required String kdKota,
    required String kdAplikasi,
    required String kdCus,
  }) =>
      Uri.parse(
          "$remoteEndpoint/get_specific_data_barang.php?kd_kota=$kdKota&kd_aplikasi=$kdAplikasi&kd_cus=$kdCus&tgl=$tgl");
  static Uri getBarangBySpecificRequirement = Uri.parse("$remoteEndpoint/barang/get_by_specific_requirement.php");
}
