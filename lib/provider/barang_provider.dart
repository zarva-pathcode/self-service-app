import 'package:flutter/material.dart';
import 'package:self_service_app/helper/app_assets.dart';
import 'package:self_service_app/models/barang.dart';
import 'package:self_service_app/models/kategori.dart';
import 'package:self_service_app/models/order_table.dart';
import 'package:self_service_app/models/response_model.dart';
import 'package:self_service_app/services/app_service.dart';

class BarangProvider extends ChangeNotifier {
  List<double> _listOfTotalDiscount = [];
  List<TableOrder> listOfTableOrder = []; //* List barang yang di Order
  List<Barang> listOfAllBarang = []; //* Kumpulan Semua Barang
  // List<SubAlatBayar> listOfSubPaymentMethod = []; //* List Dari Sub Alat Bayar
  List<Barang> listOfKategoriBarang = [];
  // List<Product> listOfSearchedProduct = [];
  // List<Voucher> listOfVoucher = [];

  int _indexKategori = 0;

  int get selectedIndexKategori => _indexKategori;

  bool barangIsLoading = false;

  List<double> _listOfTotalPrice = [];
  List<double> get listOfTotalPrice => _listOfTotalPrice;

  double _subTotal = 0;
  double get subTotal => _subTotal;

  final List<Kategori> kategoriList = [
    Kategori(
      id: "0",
      nama: "All Menu",
      icon: AppAssets().allMenuIcon,
    ),
    Kategori(
      id: "05-01",
      nama: "Makanan",
      icon: AppAssets().mainCourseIcon,
    ),
    Kategori(
      id: "05-02",
      nama: "Minuman",
      icon: AppAssets().beverageIcon,
    ),
    Kategori(
      id: "05-03",
      nama: "Menu Paket",
      icon: AppAssets().paketIcon,
    ),
    Kategori(
      id: "15-01-01",
      nama: "Camilan",
      icon: AppAssets().snackIcon,
    )
  ];

  getAllBarang() async {
    listOfAllBarang.clear();
    final data = await AppService().getBarangBySpecificRequirement();
    if (data == null) {
      print("Kosong");
    } else {
      ResponseModel response = ResponseModel.fromMap(data['response']);

      for (var json in response.result) {
        listOfAllBarang.add(
          Barang.fromMap(
            json,
          ),
        );
      }
    }
    notifyListeners();
  }

  setBarangByKategori(int? indexKategori) async {
    /* 
    Set Product Berdasarkan Dan Kategori
    */

    barangIsLoading = true;

    if (indexKategori != null) {
      _indexKategori = indexKategori; //* Index Category
    }

    notifyListeners();

    listOfKategoriBarang.clear();

    await getAllBarang();

    switch (indexKategori) {
      case 0:
        barangIsLoading = false;
        notifyListeners();
        break;
      case 1:
        var result =
            listOfAllBarang.where((element) => element.kdGrup == "15-01");
        for (var data in result) {
          listOfKategoriBarang.add(data);
          barangIsLoading = false;
          notifyListeners();
        }
        break;
      case 2:
        var result =
            listOfAllBarang.where((element) => element.kdGrup == "15-02");
        for (var data in result) {
          listOfKategoriBarang.add(data);
          barangIsLoading = false;
          notifyListeners();
        }
        break;
      case 3:
        var result =
            listOfAllBarang.where((element) => element.kdGrup == "15-03");
        for (var data in result) {
          listOfKategoriBarang.add(data);
          barangIsLoading = false;
          notifyListeners();
        }
        break;
      case 4:
        var result =
            listOfAllBarang.where((element) => element.kdSubgrup == "15-01-01");
        for (var data in result) {
          listOfKategoriBarang.add(data);
          barangIsLoading = false;
          notifyListeners();
        }
        break;
      default:
    }
    notifyListeners();
  }

  updateQty(bool isIncrement, int index) {
    /*
    Update Jumlah Barang Per Satu Jumlah
    */
    if (isIncrement) {
      if (listOfTableOrder[index].jumlah <= 9999) {
        listOfTableOrder[index].jumlah = listOfTableOrder[index].jumlah + 1;
        // _qtyC[index].text = "${listOfTableOrder[index].jumlah}";
        listOfTableOrder[index].totalPerBarang =
            double.parse(listOfTableOrder[index].harga) *
                listOfTableOrder[index].jumlah;
        _listOfTotalPrice[index] = double.parse(listOfTableOrder[index].harga) *
            listOfTableOrder[index].jumlah;
        // _listOfTotalDiscount[index] =
        //     double.parse(listOfTableOrder[index].diskon) *
        //         listOfTableOrder[index].jumlah;
        // countSubTotalAndDiskon();
        countTotalHarga();
        // countTotalByTarifFee();
      }
    } else {
      if (listOfTableOrder[index].jumlah > 1) {
        listOfTableOrder[index].jumlah = listOfTableOrder[index].jumlah - 1;
        // _qtyC[index].text = "${listOfTableOrder[index].jumlah}";
        listOfTableOrder[index].totalPerBarang =
            double.parse(listOfTableOrder[index].harga) *
                listOfTableOrder[index].jumlah;
        _listOfTotalPrice[index] = double.parse(listOfTableOrder[index].harga) *
            listOfTableOrder[index].jumlah;
        // _listOfTotalDiscount[index] =
        //     double.parse(listOfTableOrder[index].diskon) *
        //         listOfTableOrder[index].jumlah;
        // countSubTotalAndDiskon();
        countTotalHarga();
        // countTotalByTarifFee();
      } else if (listOfTableOrder[index].jumlah == 1) {
        removeBarangOnList(index);
      }
    }
    notifyListeners();
  }

  countTotalHarga() {
    /* 
    Penghitungan untuk Mencari Final Total
    */
    _subTotal = _listOfTotalPrice.reduce((value, element) => value + element);

    notifyListeners();
  }

  addToOrder(Barang barang, {Function()? onResponse}) async {
    //? index dari data barang yang dipilih itu sama
    var index =
        listOfTableOrder.indexWhere((element) => element.kdBrg == barang.kdBrg);
    print("Index  : $index");

    if (index == -1) {
      // ? Menambahkan keterangan
      listOfTableOrder.add(
        TableOrder(
          kdBrg: barang.kdBrg!,
          namaBarang: barang.nama!,
          harga: barang.harga!,
          photo: barang.photo ?? "",
          hargaAsli: "",
          jumlah: 1,
          totalPerBarang: double.parse(barang.harga!),
          diskon: "",
          keterangan: "",
        ),
      );

      // keyList.currentState!.insertItem(listOfTableOrder.length - 1);

      _listOfTotalPrice.add(double.parse(barang.harga!));
      // _listOfTotalDiscount.add(double.parse(product.diskon!));
      // _listOfNativeTotalPrice.add(double.parse(product.hargaAsli!));

      // countSubTotalAndDiskon();
      countTotalHarga();
    } else {
      //? Jika Barang sudah masuk tabel
      onResponse!();
    }

    notifyListeners();
  }

  removeBarangOnList(int index) {
    listOfTableOrder.removeAt(index);
    _listOfTotalPrice.removeAt(index);

    if (listOfTableOrder.length > 1) {
      //? jika order lebih dari satu Barang
      countTotalHarga();
    } else if (listOfTableOrder.length == 1) {
      //? jika order hanya satu barang
      _subTotal = _listOfTotalPrice[0];
      countTotalHarga();
    } else {
      //? Jika order Kosong
      _subTotal = 0;
    }
    notifyListeners();
  }

  removeBarangById(String kdBrg) {
    listOfTableOrder.removeWhere((element) => element.kdBrg == kdBrg);
    // _listOfTotalPrice.removeAt(index);
    // _listOfTotalDiscount.removeAt(index);

    // if (listOfTableOrder.length > 1) {
    //   //? jika order lebih dari satu Barang
    //   // countSubTotalAndDiskon();
    //   // countFinalTotal();
    //   // countTotalByTarifFee();
    // } else if (listOfTableOrder.length == 1) {
    //   //? jika order hanya satu barang
    //   // _subTotal = _listOfTotalPrice[0];
    //   // _discount = _listOfTotalDiscount[0];
    //   // countFinalTotal();
    //   // countTotalByTarifFee();
    // } else {
    //   //? Jika order Kosong
    //   // _subTotal = 0;
    //   // _discount = 0;
    //   // _finalTotal = 0;
    //   // _finalTotalTemp = 0;
    //   // _userPayInput.clear();
    //   // _tarifFee = 0;
    //   // _paymentInstrument = SubAlatBayar(
    //   //   kdAlat: "-",
    //   //   kdsubAlat: "-",
    //   //   nama: "Pilih Pembayaran",
    //   //   photo: "-",
    //   //   tarifFee: "0",
    //   //   caraHitung: "-",
    //   //   keterangan: "-",
    //   //   acuanFee: "-",
    //   //   bPacking: "-",
    //   // );

    //   // _change = 0;
    // }
    notifyListeners();
  }

  resetOrder() {
    listOfTableOrder.clear();
    listOfTotalPrice.clear();
    notifyListeners();
  }
}
