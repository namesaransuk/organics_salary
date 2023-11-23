import 'package:get/get.dart';
import 'package:organics_salary/models/sheet_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SalaryController extends GetxController {
  var connect = Get.find<GetConnect>();

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    try {
      var response = await connect.post(
          "https://script.google.com/macros/s/AKfycbzR_inTrrtEKk6AlfZ856ysAzMoo_NVFis7xKERTS4jpFiyT1MT7RfmD__HvndQpKyU/exec",null);
      // var response = await http.post(Uri.parse(
      //     "http://script.google.com/macros/s/AKfycbzR_inTrrtEKk6AlfZ856ysAzMoo_NVFis7xKERTS4jpFiyT1MT7RfmD__HvndQpKyU/exec"));
          // "https://script.googleusercontent.com/macros/echo?user_content_key=QaMFApUoCbQTcXj5nJwfgnlPPbCx-TS5jXzeffQVwFE1UbyGeLKHzrUG2w7Z57BmG_zxVRAx_ogA7I2yyeSralJzTMel3u-Im5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnC_OgmT6cp65fzD7CSHDlxOrMZFRiKoBbqrDHoo5qhGQRMTfMSDyFj5p09lakTqxCRhh4wFfRqSiTV8jCDhYCn7n6oMV7BTxmtz9Jw9Md8uu&lib=MCqtzRpUbzPAv5UZSauo9rnoLM9bSnHJz"));
      // return jsonDecode(result.body);

      print(response.body);

      if (response.body != null) {
        if (response.body.isNotEmpty) {
          return List<Map<String, dynamic>>.from(jsonDecode(response.body));
        } else {
          // Handle the case where the response body is an empty string or an empty array
          print("Response body is empty: $response.body");
          return [];
        }
      } else {
        // Handle the case where the response body is null
        print("Response body is null");
        return [];
      }
    } catch (error) {
      // Handle any errors that occurred during the request
      print("Error fetching users: $error");
      return [];
    }
  }
}
