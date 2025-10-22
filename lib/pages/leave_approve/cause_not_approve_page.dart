import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/leave_approve_controller.dart';
import 'package:organics_salary/theme.dart';
// import 'package:stepper_a/stepper_a.dart';

class CauseNotApprovePage extends StatefulWidget {
  const CauseNotApprovePage({super.key});

  @override
  State<CauseNotApprovePage> createState() {
    return _CauseNotApprovePageState();
  }
}

class _CauseNotApprovePageState extends State<CauseNotApprovePage>
    with TickerProviderStateMixin {
  final leaveApproveController = Get.find<LeaveApproveController>();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final item = Get.arguments;

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
          'เหตุผลการไม่อนุมัติ',
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.warning_rounded,
                          size: 18,
                          color: AppTheme.ognOrangeGold,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Expanded(
                            child: Text(
                          'เหตุผลที่ไม่อนุมัติ',
                          style: TextStyle(color: AppTheme.ognMdGreen),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        leaveApproveController.detailApprove.value = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกเหตุผล';
                        }
                        return null;
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
                        labelText: 'กรุณากรอกเหตุผล',
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
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 35),
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
                      if (_formKey.currentState?.validate() ?? false) {
                        Get.toNamed(
                          'confirm-leave-approve',
                          arguments: {
                            'item': item,
                            'mode': 2,
                          },
                        );
                      }
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
