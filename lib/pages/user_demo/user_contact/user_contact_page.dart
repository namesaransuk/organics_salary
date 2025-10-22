import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:organics_salary/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class UserContactPage extends StatefulWidget {
  const UserContactPage({super.key});

  @override
  State<UserContactPage> createState() => _UserContactPageState();
}

class _UserContactPageState extends State<UserContactPage> {
  final cs.CarouselSliderController _controller = cs.CarouselSliderController();

  final List<Map<String, String>> imgList = [
    {
      'title': 'Organics Cosme Co., Ltd.',
      'subtitle': 'บริษัท ออกานิกส์ คอสเม่ จำกัด',
      'address':
          'ที่อยู่ : 87/5 หมู่ 2 ต.บ่อพลับ อ.เมือง จ.นครปฐม 73000 (สำนักงานใหญ่)',
      'img': 'assets/img/user_demo/Map_OrganicsCosme_01.jpg',
      'onpress':
          'https://www.google.com/maps/place/Organics+Cosme+-+รับผลิตเครื่องสำอาง/@13.8292733,100.084164,17z/data=!3m1!4b1!4m6!3m5!1s0x30e2ef2102c4efa7:0x9c47c3213b3834e5!8m2!3d13.8292733!4d100.084164!16s%2Fg%2F11gycfy1vh?entry=ttu',
    },
    {
      'title': 'Organics Innovations Co., Ltd.',
      'subtitle': 'บริษัท ออกานิกส์ อินโนเวชั่นส์ จำกัด',
      'address':
          'ที่อยู่ : 78/9 หมู่ 3 ต.บ่อพลับ อ.เมือง จ.นครปฐม 73000 (สำนักงานใหญ่)',
      'img': 'assets/img/user_demo/Map_Organics_Innovations_01.jpg',
      'onpress':
          'https://www.google.com/maps/place/Organics+Cosme+-+รับผลิตเครื่องสำอาง/@13.8292733,100.084164,17z/data=!3m1!4b1!4m6!3m5!1s0x30e2ef2102c4efa7:0x9c47c3213b3834e5!8m2!3d13.8292733!4d100.084164!16s%2Fg%2F11gycfy1vh?entry=ttu',
    },
    {
      'title': 'Organics Greens Farm Co., Ltd.',
      'subtitle': 'บริษัท ออกานิกส์ กรีนส์ฟาร์ม จำกัด',
      'address':
          'ที่อยู่ : 78/9 หมู่ 3 ต.บ่อพลับ อ.เมือง จ.นครปฐม 73000 (สำนักงานใหญ่)',
      'img': 'assets/img/user_demo/contactgreensfarm_01.png',
      'onpress':
          'https://www.google.com/maps/place/Organics+Cosme+-+รับผลิตเครื่องสำอาง/@13.8292733,100.084164,17z/data=!3m1!4b1!4m6!3m5!1s0x30e2ef2102c4efa7:0x9c47c3213b3834e5!8m2!3d13.8292733!4d100.084164!16s%2Fg%2F11gycfy1vh?entry=ttu',
    },
  ];

  int current = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            cs.CarouselSlider(
              carouselController: _controller,
              options: cs.CarouselOptions(
                  aspectRatio: 1.8,
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  // autoPlay: true,
                  // autoPlayInterval: const Duration(seconds: 8),
                  // autoPlayAnimationDuration: const Duration(milliseconds: 800),
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              child: InkWell(
                                onTap: () => _open('${item['onpress']}'),
                                child: Image.asset(
                                  '${item['img']}',
                                  fit: BoxFit.cover,
                                  width: 1000.0,
                                  height: 300,
                                ),
                              )),
                        ),
                      ))
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${imgList[current]['title']}',
                    style: const TextStyle(
                        color: AppTheme.ognMdGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    '${imgList[current]['subtitle']}',
                    style: const TextStyle(color: AppTheme.ognMdGreen),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${imgList[current]['address']}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.ognSmGreen),
                    onPressed: () {
                      // _makePhoneCall('0954753359');
                      _open('${imgList[current]['onpress']}');
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Google Maps',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // GridView.count(
                  //   shrinkWrap: true,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   crossAxisCount: 2,
                  //   crossAxisSpacing: 10,
                  //   mainAxisSpacing: 10,
                  //   padding: EdgeInsets.all(10),
                  //   children: [
                  //     Card(
                  //       color: AppTheme.ognXsmGreen,
                  //       child: InkWell(
                  //         // style: ElevatedButton.styleFrom(backgroundColor: AppTheme.ognOrangeGold),
                  //         onTap: () {
                  //           _makePhoneCall('0945192222');
                  //         },
                  //         child: buttonContent(Icons.phone_rounded, '094-5192222'),
                  //       ),
                  //     ),
                  //     Card(
                  //       color: AppTheme.stepperYellow,
                  //       child: InkWell(
                  //         // style: ElevatedButton.styleFrom(backgroundColor: AppTheme.ognOrangeGold),
                  //         onTap: () {
                  //           _makeSendEmail('document@organicscosme.com');
                  //         },
                  //         child: buttonContent(Icons.email_rounded, 'contact@organicscosme.com'),
                  //       ),
                  //     ),
                  //     InkWell(
                  //       // style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  //       onTap: () {
                  //         _open('https://www.facebook.com/organicscosme/');
                  //       },
                  //       child: buttonContent(Icons.facebook_rounded, 'facebook.com/organicscosme'),
                  //     ),
                  //     InkWell(
                  //       // style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  //       onTap: () {
                  //         _open('https://line.me/ti/p/%40@OrganicsCosme');
                  //       },
                  //       child: buttonContent(FontAwesomeIcons.line, 'OrganicsCosme'),
                  //     ),
                  //   ],
                  // ),
                  // ------------------------------------------------------------
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      'หรือสามารถติดต่อตาม Contact ด้านล่าง',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.ognOrangeGold),
                    onPressed: () {
                      _makePhoneCall('0945192222');
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '094-5192222',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.ognOrangeGold),
                    onPressed: () {
                      _makeSendEmail('document@organicscosme.com');
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'contact@organicscosme.com',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      _open('https://www.facebook.com/organicscosme/');
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.facebook_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'facebook.com/organicscosme',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      _open('https://line.me/ti/p/%40@OrganicsCosme');
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.line,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'OrganicsCosme',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  Widget buttonContent(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
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

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      print('Could not launch $launchUri');
    }
  }

  Future<void> _makeSendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'ติดต่อสอบถาม'},
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      print('Could not launch $launchUri');
    }
  }
}
