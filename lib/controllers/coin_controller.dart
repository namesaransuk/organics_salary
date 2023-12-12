import 'package:get/get.dart';
import 'package:organics_salary/models/coin_model.dart';
import 'package:organics_salary/controllers/loading_controller.dart';

class CoinController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  var coinList = RxList<CoinModel>();
  var selectedMode = 0.obs;

  Future<void> loadData(int mode) async {
    loadingController.dialogLoading();

    var response = [];

    switch (mode) {
      case 0:
        response = [
          {
            'id': '1',
            'name': 'DR.X',
            'img': 'img/coin/xy.png',
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
        break;
      case 1:
        response = [
          {
            'id': '1',
            'name': 'DR.X',
            'img': 'img/coin/xy.png',
            'coin': 700,
          },
        ];
        break;
    }

    var coinJSONList = response;

    var mappedCoinList = coinJSONList.map(
      (profileJSON) {
        return CoinModel.fromMap(profileJSON);
      },
    );

    var convertedCoinList = RxList<CoinModel>.of(mappedCoinList);

    selectedMode.value = mode;
    coinList.assignAll(convertedCoinList);

    await Future.delayed(const Duration(seconds: 1), () {
      Get.back();
    });
  }
}
