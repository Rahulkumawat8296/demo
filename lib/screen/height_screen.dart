import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../services/api_services.dart';

class HeightSelectionScreen extends StatefulWidget {
  @override
  _HeightSelectionScreenState createState() => _HeightSelectionScreenState();
}

class _HeightSelectionScreenState extends State<HeightSelectionScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final profileController = Get.put(userController());
  String isCm = "cm"; // Toggle between Cm and Ft/In

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        isCm = _tabController.index == 0 ? "cm" : "ft"; // Update height unit
        if (isCm == "cm") {
          profileController.heightValue = (profileController.heightValue * 30.48).clamp(140, 200); // Convert Ft to Cm
        } else {
          profileController.heightValue = (profileController.heightValue / 30.48).clamp(4.6, 6.6); // Convert Cm to Ft
        }
      });
    });
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child:SingleChildScrollView(
          child: Column(
            children: [
              // Title Section
              Text(
                "What's your height?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Help us to create your personalized plan",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              // Unit Toggle (Cm / Ft)
              SizedBox(height: 20),
              Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Color(0xFF522ED2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(child: Text("Cm",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),)),
              ),
             SizedBox(height: 30,),
               Row(
                 children: [
                   Image.asset("assets/images/persion.png",height: 275,width: 200,),
                   SfLinearGauge(
                     minimum: isCm == "cm" ? 140.0 : 4.6,
                     maximum: isCm == "cm" ? 200.0 : 6.6,
                     interval: isCm == "cm" ? 10 : 0.5,
                     orientation: LinearGaugeOrientation.vertical,
                     axisTrackStyle: LinearAxisTrackStyle(
                       thickness: 5,
                       edgeStyle: LinearEdgeStyle.bothCurve,
                       color: Colors.grey.shade50,
                     ),
                     markerPointers: [
                       LinearShapePointer(
                         onChanged: (newValue) {
                           setState(() {
                             profileController.heightValue = newValue;
                           });
                         },
                         value: profileController.heightValue,
                         height: 30,
                         width: 30,
                         color: Color(0xFF522ED2),
                         shapeType: LinearShapePointerType.triangle,
                         position: LinearElementPosition.cross,
                       ),
                     ],
                     barPointers: [],
                     showLabels: true,
                     labelFormatterCallback: (value) {
                       final numericValue = double.tryParse(value) ?? 0; // Convert to double
                       return numericValue.toStringAsFixed(0); // Integer for Cm and Ft
                     },
                     showTicks: true,
                   ),

                 ],
               ),
              // Display Height

              // Next Button
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  profileController.postApiRequestWithBearerToken();

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
      ),
    );
  }
}
