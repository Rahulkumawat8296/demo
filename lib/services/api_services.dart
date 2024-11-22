import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../screen/gender_screen.dart';

class userController extends GetxController {
  String selectedGender = "Female"; // Removed .obs() since String doesn't need reactive binding here.
  double weightValue = 95;
  String isKg = "kg";
  double heightValue = 170;
  String isCm = "cm";

  static const String apiUrl = 'http://157.15.202.189:7002/patient/patient_info?patientId=73';
  String token =
      'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJVbWVzaCIsInJvbGVJZCI6MiwiZXhwIjoxNzU0NDU1MDY5LCJpYXQiOjE3MjI5MTkwNjl9.WwBZtiNMQAeerkqkQL2MQjNVyfAEn7gE8CzzU0XpCIE';

  Future<void> postApiRequestWithBearerToken() async {
    Map<String, dynamic> data = {
      'gender': selectedGender,
      'height': heightValue,
      'heightType': isCm,
      'weight': weightValue,
      'weightType': isKg,
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String jsonData = jsonEncode(data);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonData,
      );

      // Print debug information
      print("Gender----: $selectedGender");
      print("Height--: $heightValue $isCm");
      print("Weight:--- $weightValue $isKg");

      if (response.statusCode == 200) {
        print("Response Body: ${response.body}");

        // Parse the response body
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        String message = responseBody['msg'] ?? 'Success';

        // Show toast message
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );

        // Navigate to the GenderScreen
        Get.to(GenderScreen());
      } else {
        print('Error: ${response.statusCode}');
        print('Message: ${response.body}');

        // Parse and display error message
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        String errorMessage = responseBody['error'] ?? 'An error occurred';

        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print('Error: $e');
      // Show network error toast
      Fluttertoast.showToast(
        msg: "An error occurred: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    }
  }
}
