import 'package:flutter/material.dart';
import 'package:organics_salary/theme.dart';

class ChangePassPage extends StatelessWidget {
  const ChangePassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/img/reset-password.png',
                width: 150,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Card(
              surfaceTintColor: AppTheme.bgSoftGreen,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.ognGreen,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'เปลี่ยนแปลงรหัสผ่าน',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (value) {
                            // setState(() {
                            //   empId = value;
                            // });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            labelText: 'รหัสผ่านเดิม',
                            // errorText: empIdError,
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: AppTheme.ognGreen),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        Divider(
                          height: 50,
                        ),
                        TextField(
                          onChanged: (value) {
                            // setState(() {
                            //   empId = value;
                            // });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            labelText: 'รหัสผ่านใหม่',
                            // errorText: empIdError,
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: AppTheme.ognGreen),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          onChanged: (value) {
                            // setState(() {
                            //   empId = value;
                            // });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            labelText: 'ยืนยันรหัสผ่านใหม่',
                            // errorText: empIdError,
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: AppTheme.ognGreen),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('ยืนยัน'),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
