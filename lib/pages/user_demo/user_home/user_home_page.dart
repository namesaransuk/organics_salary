import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:flutter/material.dart';
import 'package:organics_salary/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final cs.CarouselSliderController _controller = cs.CarouselSliderController();

  final List<Map<String, String>> imgList = [
    {
      'title': 'Organics Cosme Korea',
      'subtitle': '18 มีนาคม 2567',
      'img': 'assets/img/user_demo/08.jpg',
      'onpress':
          'https://organicscosme.com/newupdate/cosme_korea/cosme_korea.html',
    },
    {
      'title': 'Organics Trip พาพนักงานเที่ยวสิ้นปี',
      'subtitle': '27-28 ธันวาคม 2566',
      'img': 'assets/img/user_demo/29.jpg',
      'onpress':
          'https://organicscosme.com/newupdate/organicstrip/organicstrip.html',
    },
    {
      'title': 'Miss Grand Sakhon Nakhon',
      'subtitle': '10 ธันวาคม 2566',
      'img': 'assets/img/user_demo/06.jpg',
      'onpress': 'https://organicscosme.com/newupdate/missgrand/mgsakhon.html',
    },
  ];

  int current = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: 130,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/img/user_demo/banner_header.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              child: Container(
                margin: const EdgeInsets.only(top: 115),
                padding: const EdgeInsets.symmetric(horizontal: 50),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/img/user_demo/organics_legendary.png',
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        'assets/img/user_demo/organics.png',
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        'assets/img/user_demo/orgreen.png',
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        'assets/img/user_demo/orinno.png',
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        'assets/img/user_demo/dr_jel.png',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Image.asset('assets/img/user_demo/banner_n005.jpg'),
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                children: [
                  Icon(
                    Icons.campaign_rounded,
                    size: 20,
                    color: AppTheme.ognOrangeGold,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'ข่าวสาร Organics',
                    style: TextStyle(color: AppTheme.ognGreen),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  child: cs.CarouselSlider(
                    carouselController: _controller,
                    options: cs.CarouselOptions(
                        aspectRatio: 2,
                        viewportFraction: 0.8,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 8),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        onPageChanged: (index, reason) {
                          setState(() {
                            current = index;
                          });
                        }),
                    items: imgList
                        .map((item) => Container(
                              child: Container(
                                // margin: EdgeInsets.all(5.0),
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0)),
                                    child: InkWell(
                                      onTap: () => _open('${item['onpress']}'),
                                      child: Stack(
                                        children: <Widget>[
                                          Image.asset(
                                            '${item['img']}',
                                            fit: BoxFit.cover,
                                            width: 1000.0,
                                            height: 300,
                                          ),
                                          Positioned(
                                            bottom: 0.0,
                                            left: 0.0,
                                            right: 0.0,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        150, 0, 0, 0),
                                                    Color.fromARGB(0, 0, 0, 0)
                                                  ],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 20.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '${item['title']}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${item['subtitle']}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : AppTheme.ognOrangeGold)
                              .withOpacity(current == entry.key ? 0.9 : 0.4),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Row(
            children: [
              Icon(
                Icons.dashboard_rounded,
                size: 20,
                color: AppTheme.ognOrangeGold,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Standrad Quality',
                style: TextStyle(color: AppTheme.ognGreen),
              ),
            ],
          ),
        ),
        Image.asset('assets/img/user_demo/standard.png'),
        Container(
          width: double.infinity,
          height: 380,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/img/user_demo/organicscosme_02.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'สมัครงาน',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  const Text(
                    'ยินดีต้องรับผู้ที่สนใจจะร่วมงานกับ ORGANICS',
                    style: TextStyle(fontSize: 14),
                  ),
                  // GridView.count(
                  //   shrinkWrap: true,
                  //   padding: const EdgeInsets.all(20),
                  //   crossAxisSpacing: 10,
                  //   mainAxisSpacing: 10,
                  //   crossAxisCount: 2,
                  //   children: <Widget>[
                  //     Card(
                  //       surfaceTintColor: Colors.white,
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             const Text("พนักงานฝ่ายผลิต"),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     Card(
                  //       surfaceTintColor: Colors.white,
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             const Text("พนักงานฝ่ายควบคุมคุณภาพ"),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     Card(
                  //       surfaceTintColor: Colors.white,
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             const Text("ผู้ช่วยฝ่ายขาย"),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     Card(
                  //       surfaceTintColor: Colors.white,
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             const Text("R&D ฝ่ายผลิตภัณฑ์เสริมอาหาร"),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ตำแหน่ง',
                              ),
                              SizedBox(height: 5),
                              Text(
                                '1. พนักงานฝ่ายผลิต',
                              ),
                              SizedBox(height: 5),
                              Text(
                                '2. พนักงานฝ่ายควบคุมคุณภาพ',
                              ),
                              SizedBox(height: 5),
                              Text(
                                '3. ผู้ช่วยฝ่ายขาย',
                              ),
                              SizedBox(height: 5),
                              Text(
                                '4. R&D ผลิตภัณฑ์เสริมอาหาร',
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'จำนวน',
                            ),
                            SizedBox(height: 5),
                            Text(
                              '-',
                            ),
                            SizedBox(height: 5),
                            Text(
                              '',
                            ),
                            SizedBox(height: 5),
                            Text(
                              '',
                            ),
                            SizedBox(height: 5),
                            Text(
                              '',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'ติดต่อสมัครงานได้ที่',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Phone : 089-8362222 / 095-4753359',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Text(
                    'E-mail : document@organicscosme.com',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Text(
                    'เวลาทำการ วันจันทร์ – เสาร์ เวลา 9.00 – 16.00 น.',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  _open(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.inAppBrowserView,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
