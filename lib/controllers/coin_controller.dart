import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:organics_salary/models/coin_model.dart';
import 'package:organics_salary/controllers/loading_controller.dart';

class CoinController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  var coinList = <CoinModel>[];

  Future<void> loadData() async {
    // loadingController.dialogLoading();
    // print('TEST:');

    // var connect = Get.find<GetConnect>();

    // var response = await connect.get(
    //   'https://651d740c44e393af2d59d2b4.mockapi.io/api/profiles',
    // );

    // var coinJSONList = response.body;
    // await Future.delayed(const Duration(seconds: 1), () {
    //   Get.back();
    // });
    var response = [
      {
        'id': '21',
        'name': 'DR.X',
        'img': 'img/coin/xy.jpg',
        'coin': 700,
      },
      {
        'id': '2',
        'name': 'IPHONE 15 (Black)',
        'img': 'img/coin/iphone15.png',
        'coin': 1500,
      },
      {
        'id': '3',
        'name': 'iPad Air (Silver)',
        'img': 'img/coin/ipadair.png',
        'coin': 2000,
      },
    ];
    var coinJSONList = response;

    var mappedCoinList = coinJSONList.map(
      (profileJSON) {
        return CoinModel.fromMap(profileJSON);
      },
    );

    var convertedCoinList = List<CoinModel>.from(mappedCoinList);

    coinList = convertedCoinList;
  }
}
