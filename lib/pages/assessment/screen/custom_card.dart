import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final Color backgroundColor;
  final String title;
  final String subtitle;
  final IconData icon;

  const CustomCard({
    super.key,
    required this.backgroundColor,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  late bool screenMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 382,
      height: screenMode ? 240 : 160,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Shape
          Positioned(
            // top: 2,
            bottom: -55,
            left: 10,
            child: Opacity(
              opacity: 0.4,
              child: Row(
                children: [
                  Container(
                    width: 25,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 25,
                    height: 155,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 25,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(widget.icon,
                            color: Colors.white, size: screenMode ? 24 : 20),
                        const SizedBox(width: 8),
                        Text(
                          widget.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenMode ? 18 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "20/02/2025",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenMode ? 18 : 16,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    widget.subtitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenMode ? 30 : 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
    print('SCREEN : ${MediaQuery.of(context).size.width}');
  }
}
