import 'package:assigment/screen/weight_screen.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:get/get.dart';

import '../services/api_services.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
final profileController = Get.put(userController());
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
   _tabController.addListener(() {
      setState(() {
        if (_tabController.index == 0) {
          profileController.selectedGender = "Female";
        } else if (_tabController.index == 1) {
          profileController. selectedGender = "Male";
        } else {
          profileController.selectedGender = "Other";
        }
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF522ED2),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Text(
              "Skip",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Color(0xFF522ED2),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  DottedLine(
                    lineThickness: 4,
                    dashColor: Color(0xFF522ED2),
                    dashLength: 90,
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: Text(
                      "Select your Gender",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Help us to create your personalized plan",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),

                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 330),
                    child: Icon(Icons.radio_button_checked,
                      color: Color(0xFF522ED2),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/Group 1.png",
                        width: 114,
                        height: 164,
                      ),
                      Image.asset(
                        "assets/images/Group 2.png",
                        width: 114,
                        height: 164,
                      ),

                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                      height: 59,
                      width: 159,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Center(
                        child: Text(
                          "Other",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:Get.height*0.01,),
                  Container(
                      height: 45,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade300,
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: Colors.transparent,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          color: Color(0xFF522ED2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                       // labelPadding: EdgeInsets.all(8.0),
                        labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        tabs: [
                          Tab(text: "Female"),
                          Tab(text: "Male"),
                          Tab(text: "Others"),
                        ],
                      ),
                    ),

                  SizedBox(height:Get.height*0.01,),

                  GestureDetector(
                    onTap: () {
                      Get.to(WeightScreen());
                    },
                    child: Center(
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF522ED2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),


    );
  }
}
