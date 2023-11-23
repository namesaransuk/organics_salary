import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:organics_salary/controllers/salary_controller.dart';
import 'package:get/get.dart';

final List<String> slipList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
];

class SalaryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SalaryScreenState();
  }
}

class _SalaryScreenState extends State<SalaryScreen> {
  String reason = '';
  bool _isLoading = false;
  final CarouselController _controller = CarouselController();
  final SalaryController salaryController = Get.put(SalaryController());

  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      reason = changeReason.toString();
    });
  }

  final List<Widget> imageSliders = slipList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            'No. ${slipList.indexOf(item)} image',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: <Widget>[
          Expanded(
              child: CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
              initialPage: 2,
              enlargeCenterPage: true,
              onPageChanged: onPageChange,
            ),
            carouselController: _controller,
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                child: ElevatedButton(
                  onPressed: () => _controller.previousPage(),
                  child: Text('←'),
                ),
              ),
              ...Iterable<int>.generate(slipList.length).map(
                (int pageIndex) => Flexible(
                  child: ElevatedButton(
                    onPressed: () => _controller.animateToPage(pageIndex),
                    child: Text("$pageIndex"),
                  ),
                ),
              ),
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    _controller.nextPage();
                    salaryController.fetchUsers();
                  },
                  child: Text('→'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
