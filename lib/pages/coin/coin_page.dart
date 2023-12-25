import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/coin_controller.dart';
import 'package:organics_salary/theme.dart';

class CoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        title: Text(
          'Organics Coin',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.ognGreen,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          ListView(
            // shrinkWrap: true,
            children: const [
              GetMainUI(),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }
}

class GetMainUI extends StatefulWidget {
  const GetMainUI({super.key});

  @override
  State<GetMainUI> createState() => _GetMainUIState();
}

class _GetMainUIState extends State<GetMainUI> with TickerProviderStateMixin {
  late bool screenMode;
  final box = GetStorage();
  final CoinController coinController = Get.put(CoinController());

  @override
  Widget build(BuildContext context) {
    coinController.loadData(0);

    return Obx(() => Column(
          children: [
            Container(
              width: double.infinity,
              color: AppTheme.bgSoftGreen,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset('assets/img/coin/titleimg.jpg'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'คอยน์ : ${box.read('coins')}',
                          style: TextStyle(
                              color: AppTheme.ognGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Image(
                          image: AssetImage('assets/img/coin/ogn_coin.png'),
                          width: 25,
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'จำนวน coin ที่ใช้แลก',
                          style: TextStyle(
                              color: AppTheme.ognGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Wrap(
                            spacing: 10,
                            alignment: WrapAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildFilterItems(0, 'ทั้งหมด'),
                              _buildFilterItems(1, '1-100'),
                              _buildFilterItems(2, '100-500'),
                              _buildFilterItems(3, '500-1000'),
                              _buildFilterItems(4, '1000 ขึ้นไป'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: screenMode ? 3 : 2,
                        // childAspectRatio: MediaQuery.of(context).size.width * 0.001
                        childAspectRatio: 0.7),
                    itemCount: coinController.coinList.length,
                    itemBuilder: (context, index) {
                      var coin = coinController.coinList[index];

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Image.asset(
                                '${coin.img}',
                                width:
                                    MediaQuery.of(context).size.height * 0.15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${coin.coin}' ?? '',
                                      style: TextStyle(
                                        color: AppTheme.ognGreen,
                                      ),
                                    ),
                                    Image(
                                      image: AssetImage(
                                          'assets/img/coin/ogn_coin.png'),
                                      width: 20,
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                coin.name ?? '',
                                style: TextStyle(
                                    color: AppTheme.ognGreen,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                      showDragHandle: true,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 40),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            // mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              // const Text('Modal BottomSheet'),
                                              // ElevatedButton(
                                              //   child: const Text('Close BottomSheet'),
                                              //   onPressed: () => Navigator.pop(context),
                                              // ),
                                              Image.asset(
                                                '${coin.img}',
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      coin.name ?? '',
                                                      style: TextStyle(
                                                          color:
                                                              AppTheme.ognGreen,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.circle,
                                                          color:
                                                              AppTheme.ognGreen,
                                                          size: 15,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          'รายละเอียด',
                                                          style: TextStyle(
                                                              color: AppTheme
                                                                  .ognGreen,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Text(
                                                        coin.description ?? '',
                                                        style: TextStyle(
                                                          color:
                                                              AppTheme.ognGreen,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  child: ElevatedButton(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text('${coin.coin}'),
                                                          Image(
                                                            image: AssetImage(
                                                                'assets/img/coin/ogn_coin.png'),
                                                            width: 20,
                                                            height: 20,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                  ),
                                                ),
                                              ),
                                              // Padding(
                                              //   padding: const EdgeInsets.only(bottom: 20),
                                              //   child: ElevatedButton(
                                              //     child: const Text('Close BottomSheet'),
                                              //     onPressed: () => Navigator.pop(context),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('แลกรางวัล'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),

                  // ----------------------------------------------------------------------------
                ],
              ),
            ),
          ],
        ));
  }

  Widget _buildFilterItems(int mode, String title) {
    final isSelected = coinController.selectedMode.value == mode;

    return InkWell(
      onTap: () {
        coinController.loadData(mode);
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : null,
          // border:
          //     isSelected ? Border.all(width: 0.15, color: Colors.grey) : null,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.5,
                    // blurRadius: 7,
                    offset: Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? AppTheme.ognGold : AppTheme.ognGreen,
              fontWeight: isSelected ? FontWeight.bold : null,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width >= 600;
  }
}
