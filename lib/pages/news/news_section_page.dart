import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/news_controller.dart';
import 'package:organics_salary/theme.dart';

final NewsController newsController = Get.put(NewsController());

class NewsSectionPage extends StatefulWidget {
  const NewsSectionPage({super.key});

  @override
  State<NewsSectionPage> createState() => _NewsSectionPageState();
}

class _NewsSectionPageState extends State<NewsSectionPage> {
  int _current = 0;
  final cs.CarouselSliderController _controller = cs.CarouselSliderController();

  // final List<String> imgList = [
  //   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  //   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  //   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  // ];

  final List<String> imgList = newsController.newsSectionList
      .expand((item) => [
            item.newsImg1,
            item.newsImg2,
            item.newsImg3,
          ])
      .where((img) => img != null)
      .cast<String>()
      .toList();

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList.map((item) {
      return Container(
        // margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          // borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Image.network(
            item,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      );
    }).toList();

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
      body: ListView(
        children: newsController.newsSectionList.map((item) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              item.newsImg1 != null
                  ? Column(
                      children: [
                        cs.CarouselSlider(
                          items: imageSliders,
                          carouselController: _controller,
                          options: cs.CarouselOptions(
                              // autoPlay: true,
                              // aspectRatio: 1.0,
                              clipBehavior: Clip.antiAlias,
                              viewportFraction: 1.0,
                              enlargeCenterPage: false,
                              onPageChanged: (index, reason) {
                                setState(
                                  () {
                                    _current = index;
                                  },
                                );
                              }),
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
                                      .withOpacity(
                                          _current == entry.key ? 0.9 : 0.4),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.announcementTopic}',
                      style: const TextStyle(
                          fontSize: 20, color: AppTheme.ognGreen),
                    ),
                    Text('${item.announcementContent}'),
                  ],
                ),
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}
