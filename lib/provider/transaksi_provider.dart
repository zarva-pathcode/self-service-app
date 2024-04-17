import 'package:flutter/material.dart';
import 'package:self_service_app/models/alat_bayar.dart';
import 'package:self_service_app/models/response_model.dart';
import 'package:self_service_app/services/app_service.dart';

class TransaksiProvider with ChangeNotifier {
  List<AlatBayar> listOfAlatBayar = [];

  bool alatBayarIsLoading = false;

  Future getAlatBayar() async {
    //? remoteURL

    alatBayarIsLoading = true;

    notifyListeners();

    listOfAlatBayar.clear();

    final data = await AppService().getAlatBayar();
    if (data == null) {
      print("Kosong");
    } else {
      ResponseModel response = ResponseModel.fromMap(data['response']);

      for (var json in response.result) {
        if (json["photo"] != null) {
          listOfAlatBayar.add(
            AlatBayar.fromMap(
              json,
            ),
          );
        }
      }
    }
    alatBayarIsLoading = false;
    notifyListeners();
  }
}
