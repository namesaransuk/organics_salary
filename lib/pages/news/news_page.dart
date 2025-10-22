import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/news_controller.dart';
import 'package:organics_salary/theme.dart';

final NewsController newsController = Get.put(NewsController());

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData.fallback(),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: AppTheme.ognOrangeGold,
          onPressed: () => Navigator.pop(context, false),
        ),
        title: const Text(
          'ข่าวสาร',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: newsController.newsList.isNotEmpty
          ? ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: newsController.newsList.map((item) {
                      print(newsController.newsList);
                      return Container(
                        height: 120,
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.shade300, width: 1),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        child: InkWell(
                          onTap: () => newsController.loadSectionData(item.id),
                          child: ClipRRect(
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.circular(20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: item.newsImg1 != null &&
                                          item.newsImg1 != '' &&
                                          item.newsImg1 != 'null'
                                      ? Image.network(
                                          '${item.newsImg1}',
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/img/logo.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${item.announcementTopic}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: AppTheme.ognMdGreen,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${item.announcementContent}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[500]),
                                            softWrap: false,
                                            maxLines: 3,
                                            overflow:
                                                TextOverflow.ellipsis, // new
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Row(
                                            //   children: [
                                            //     Icon(
                                            //       Icons.remove_red_eye_rounded,
                                            //       size: 16,
                                            //       color: Colors.grey[400],
                                            //     ),
                                            //     SizedBox(
                                            //       width: 3,
                                            //     ),
                                            //     Text(
                                            //       '69',
                                            //       style: TextStyle(
                                            //         color: Colors.grey[400],
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            )
          : SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/news/megaphone.png',
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'ไม่มีข่าวสารในขณะนี้',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
