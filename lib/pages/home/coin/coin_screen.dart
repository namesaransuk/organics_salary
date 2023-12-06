import 'package:flutter/material.dart';
import 'package:organics_salary/theme.dart';

import 'package:organics_salary/pages/home/coin/details.dart';
import 'package:organics_salary/pages/home/coin/resorces_list.dart';

class CoinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}

class GetMainUI extends StatefulWidget {
  const GetMainUI({super.key});

  @override
  State<GetMainUI> createState() => _GetMainUIState();
}

class _GetMainUIState extends State<GetMainUI> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/img/coin/ogn_coin.png'),
                width: 60,
                height: 60,
              ),
              Text(
                "1000",
                style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // crossAxisSpacing: 100.0,
              // mainAxisSpacing: 100.0,
            ),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Card(
                color: AppTheme.ognGreen,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        names[index],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Image(
                                width: double.infinity,
                                image: images[index],
                                // fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: MediaQuery.of(context).padding.left + 30,
                              right: MediaQuery.of(context).padding.right + 30,
                              child: SizedBox(
                                height: 30,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                      showDragHandle: true,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SizedBox(
                                          height: 200,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                const Text('Modal BottomSheet'),
                                                ElevatedButton(
                                                  child: const Text(
                                                      'Close BottomSheet'),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 1,
                                    backgroundColor:
                                        Color.fromARGB(171, 255, 255, 255),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            'assets/img/coin/ogn_coin2.png'),
                                        width: 14,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        prices[index],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
