import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/assessment_controller.dart';
import 'package:organics_salary/theme.dart';
// import 'package:stepper_a/stepper_a.dart';

class RecommentAssessmentPage extends StatefulWidget {
  const RecommentAssessmentPage({super.key});

  @override
  State<RecommentAssessmentPage> createState() {
    return _RecommentAssessmentPageState();
  }
}

class _RecommentAssessmentPageState extends State<RecommentAssessmentPage>
    with TickerProviderStateMixin {
  final AssessmentController assessmentController =
      Get.put(AssessmentController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final item = Get.arguments;

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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.circleInfo,
                        size: 18,
                        color: AppTheme.ognOrangeGold,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Expanded(
                          child: Text(
                        'คำแนะนำเพิ่มเติม (ถ้ามี)',
                        style: TextStyle(color: AppTheme.ognMdGreen),
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      assessmentController.detailRecomment.value = value;
                    },
                    textAlign: TextAlign.start,
                    maxLines: 7,
                    style: const TextStyle(
                        color: AppTheme.ognMdGreen, fontSize: 14),
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      filled: true,
                      fillColor: Colors.white,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 25),
                      labelText: 'คำแนะนำ',
                      labelStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      hintStyle: const TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        borderSide:
                            BorderSide(width: 1, color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        borderSide:
                            BorderSide(width: 1, color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      'ยกเลิก',
                      style: TextStyle(color: AppTheme.ognOrangeGold),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.ognOrangeGold,
                    ),
                    // onPressed: submit,
                    onPressed: () {
                      Get.toNamed('confirm-assessment');
                    },
                    child: const SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Center(
                          child: Text(
                            'ยืนยัน',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
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
}
