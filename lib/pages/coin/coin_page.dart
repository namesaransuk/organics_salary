import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/coin_controller.dart';
import 'package:organics_salary/theme.dart';

import 'package:organics_salary/pages/coin/details.dart';
import 'package:organics_salary/pages/coin/resorces_list.dart';

class CoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  @override
  Widget build(BuildContext context) {
    final CoinController coinController = Get.put(CoinController());
    coinController.loadData();

    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Placeholder(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image(
                    image: AssetImage('assets/img/coin/ogn_coin.png'),
                    width: 40,
                    height: 40,
                  ),
                  Text(
                    "1000",
                    style: TextStyle(
                        color: AppTheme.ognGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      'จำนวน coin ที่ใช้แลก',
                      style: TextStyle(
                          color: AppTheme.ognGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Text(
                                '1-100',
                                style: TextStyle(
                                  color: AppTheme.ognGreen,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Text(
                                '100-500',
                                style: TextStyle(
                                  color: AppTheme.ognGreen,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Text(
                                '500-1000',
                                style: TextStyle(
                                  color: AppTheme.ognGreen,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Text(
                                '1000 ขึ้นไป',
                                style: TextStyle(
                                  color: AppTheme.ognGreen,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenMode ? 4 : 2,
                ),
                itemCount: coinController.coinList.length,
                itemBuilder: (context, index) {
                  var coin = coinController.coinList[index];

                  return InkWell(
                    onTap: () {
                      showModalBottomSheet<void>(
                          showDragHandle: true,
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 200,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Text('Modal BottomSheet'),
                                    ElevatedButton(
                                      child: const Text('Close BottomSheet'),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Image.asset(
                              '${coin.img}',
                              width: MediaQuery.of(context).size.height * 0.15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Transform.scale(
                                    scale: 0.8,
                                    child: IconButton.filled(
                                      onPressed: () {},
                                      icon: Icon(Icons.filter_drama),
                                      iconSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              coin.name ?? '',
                              style: TextStyle(
                                  color: AppTheme.ognGreen,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
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
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenMode ? 4 : 2,
                ),
                itemCount: coinController.coinList.length,
                itemBuilder: (context, index) {
                  var coin = coinController.coinList[index];

                  return InkWell(
                    onTap: () {
                      showModalBottomSheet<void>(
                          showDragHandle: true,
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 200,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Text('Modal BottomSheet'),
                                    ElevatedButton(
                                      child: const Text('Close BottomSheet'),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Image.asset(
                              '${coin.img}',
                              width: MediaQuery.of(context).size.height * 0.15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
                        Column(
                          children: [
                            Text(
                              coin.name ?? '',
                              style: TextStyle(
                                  color: AppTheme.ognGreen,
                                  fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('แลกรางวัล'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

              // ----------------------------------------------------------------------------

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Image(
              //       image: AssetImage('assets/img/coin/ogn_coin.png'),
              //       width: 60,
              //       height: 60,
              //     ),
              //     Text(
              //       "1000",
              //       style: TextStyle(
              //           color: Colors.teal,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 30),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              // GridView.builder(
              //   shrinkWrap: true,
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: screenMode ? 3 : 1,
              //     // crossAxisSpacing: 100.0,
              //     // mainAxisSpacing: 100.0,
              //   ),
              //   itemCount: 3,
              //   itemBuilder: (context, index) {
              //     return Card(
              //       color: AppTheme.ognGreen,
              //       child: Column(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Text(
              //               names[index],
              //               style: TextStyle(
              //                 fontSize: 16,
              //                 color: Colors.white,
              //               ),
              //             ),
              //           ),
              //           Expanded(
              //             child: Container(
              //               color: Colors.white,
              //               child: Stack(
              //                 children: [
              //                   InkWell(
              //                     onTap: () {},
              //                     child: Image(
              //                       width: double.infinity,
              //                       image: images[index],
              //                       // fit: BoxFit.cover,
              //                     ),
              //                   ),
              //                   Positioned(
              //                     bottom: 10,
              //                     left: MediaQuery.of(context).padding.left + 30,
              //                     right: MediaQuery.of(context).padding.right + 30,
              //                     child: InkWell(
              //                       onTap: () {
              //                         showModalBottomSheet<void>(
              //                           showDragHandle: true,
              //                           context: context,
              //                           builder: (BuildContext context) {
              //                             return SizedBox(
              //                               height: 200,
              //                               child: Center(
              //                                 child: Column(
              //                                   mainAxisAlignment:
              //                                       MainAxisAlignment.center,
              //                                   mainAxisSize: MainAxisSize.min,
              //                                   children: <Widget>[
              //                                     const Text('Modal BottomSheet'),
              //                                     ElevatedButton(
              //                                       child: const Text(
              //                                           'Close BottomSheet'),
              //                                       onPressed: () =>
              //                                           Navigator.pop(context),
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ),
              //                             );
              //                           },
              //                         );
              //                       },
              //                       child: Container(
              //                         padding: EdgeInsets.symmetric(
              //                             horizontal: 25, vertical: 10),
              //                         decoration: BoxDecoration(
              //                           color: Color.fromARGB(186, 240, 240, 240),
              //                           borderRadius: BorderRadius.circular(20.0),
              //                           boxShadow: <BoxShadow>[
              //                             BoxShadow(
              //                               color: Color.fromRGBO(0, 0, 0, 0.57),
              //                               blurRadius: 5,
              //                             )
              //                           ],
              //                         ),
              //                         child: Row(
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.center,
              //                           mainAxisAlignment: MainAxisAlignment.center,
              //                           children: [
              //                             Image(
              //                               image: AssetImage(
              //                                   'assets/img/coin/ogn_coin2.png'),
              //                               width: 14,
              //                             ),
              //                             SizedBox(
              //                               width: 5,
              //                             ),
              //                             Text(
              //                               prices[index],
              //                               style: const TextStyle(
              //                                 color: Colors.black,
              //                                 fontWeight: FontWeight.bold,
              //                                 fontSize: 10,
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // )
            ],
          ),
        ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width >= 600;
  }
}
