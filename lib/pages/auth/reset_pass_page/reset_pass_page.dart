import 'package:flutter/material.dart';
import 'package:organics_salary/theme.dart';

class ResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        // width: 200,
                        // height: 200,
                        child: Image.asset("assets/img/resetpass.jpg"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "ลืมรหัสผ่าน?",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "โปรดกรอกข้อมูลให้ครบเพื่อยืนยันตัวตนในการเปลี่ยนรหัสผ่าน",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        obscureText: true,
                        // onChanged: (value) => setState(() {
                        //   password = value;
                        // }),
                        // onSubmitted: (val) => submit(),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 16),
                          labelText: "รหัสพนักงาน",
                          labelStyle: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                          ),
                          // errorText: passwordError,
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
                        height: 10,
                      ),
                      TextField(
                        obscureText: true,
                        // onChanged: (value) => setState(() {
                        //   password = value;
                        // }),
                        // onSubmitted: (val) => submit(),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 16),
                          labelText: "รหัสบัตรประชาชน",
                          labelStyle: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                          ),
                          // errorText: passwordError,
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
                        height: 10,
                      ),
                      ElevatedButton(
                        child: Text(
                          "ตรวจสอบ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
