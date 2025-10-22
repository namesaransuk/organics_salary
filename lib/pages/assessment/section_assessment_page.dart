import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/assessment_controller.dart';
import 'package:organics_salary/theme.dart';

class SectionAssessmentPage extends StatefulWidget {
  const SectionAssessmentPage(
      {super.key}); // ใช้ named constructor ที่มีชื่อ key

  @override
  State<SectionAssessmentPage> createState() => _SectionAssessmentPageState();
}

class _SectionAssessmentPageState extends State<SectionAssessmentPage> {
  final AssessmentController assessmentController =
      Get.put(AssessmentController());
  int? selectedValue;

  @override
  void initState() {
    super.initState();
    // assessmentController.loadData();
  }

  @override
  void dispose() {
    // Get.delete<AssessmentController>();
    super.dispose();
  }

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
          'แบบประเมินของบริษัท',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  elevation: 0.3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '1. Ownership - มีความรับผิดชอบและทุ่มเทในงาน',
                              style: TextStyle(
                                color: AppTheme.ognMdGreen,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceAround, // จัดให้ห่างกันเท่ากัน
                              children: List.generate(5, (index) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Radio<int>(
                                      fillColor: WidgetStatePropertyAll(
                                          Colors.grey[400]),
                                      focusColor: AppTheme.ognMdGreen,
                                      visualDensity: VisualDensity.compact,
                                      value: index + 1,
                                      groupValue: selectedValue,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      "ตัวเลือก",
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 12),
                                    ),
                                    Text(
                                      "(${index + 1})",
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 12),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.ognOrangeGold,
                ),
                onPressed: () {
                  Get.toNamed('recomment-assessment');
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ถัดไป',
                          style: TextStyle(
                            color: Colors.white,
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
    );
  }
}
