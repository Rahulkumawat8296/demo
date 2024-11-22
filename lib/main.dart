import 'package:assigment/screen/gender_screen.dart';
import 'package:assigment/screen/height_screen.dart';
import 'package:assigment/screen/weight_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
void main(){
  runApp(Home());

}
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:GenderScreen(),
    );
  }
}
