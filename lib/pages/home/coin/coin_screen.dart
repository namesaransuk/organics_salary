import 'package:flutter/material.dart';
import 'package:organics_salary/theme.dart';

import 'package:organics_salary/pages/home/coin/details.dart';
import 'package:organics_salary/pages/home/coin/resorces_list.dart';

class CoinScreen extends StatelessWidget {
  const CoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            children: [
              Image(
                image: AssetImage('img/coin/ogn_coin.png'),
                width: 80,
                height: 80,
              ),
              Text(
                "0",
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
          Row(
            children: List.generate(
              2,
              (index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(index),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.only(right: 10, top: 10),
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      width: 210,
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              color: AppTheme.ognGreen,
                            ),
                            height: 30,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  names[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            // crossAxisAlignment:
                            //     CrossAxisAlignment.center,
                            // mainAxisAlignment:
                            //     MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Stack(
                                  // crossAxisAlignment:
                                  //     CrossAxisAlignment.center,
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: Image(
                                        image: images[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: MediaQuery.of(context).padding.top +
                                          150,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50),
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Row(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.start,
                                            children: [
                                              const Image(
                                                image: AssetImage(
                                                    'img/coin/ogn_coin2.png'),
                                                width: 17,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                prices[index],
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
