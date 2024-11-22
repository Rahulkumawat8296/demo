import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../services/api_services.dart';
import 'height_screen.dart';

class WeightScreen extends StatefulWidget {
  @override
  _WeightScreenState createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final profileController = Get.put(userController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        profileController.isKg = _tabController.index == 0 ? "kg" : "lbs";
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
      body: SingleChildScrollView(
        child: Column(
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
                "What's your Weight?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Center(
              child: Text(
                "Help us to create your personalized plan",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade300,
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Color(0xFF522ED2),
                  borderRadius: BorderRadius.circular(15),

                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(text: "Kg"),
                  Tab(text: "LBS"),
                ],
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: profileController.isKg == "kg" ? 80 : 175,
                    maximum: profileController.isKg == "kg" ? 120 : 265,
                    interval: profileController.isKg == "kg" ? 5 : 10,
                    axisLabelStyle: GaugeTextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                    axisLineStyle: AxisLineStyle(
                      thickness: 15,
                      color: Colors.transparent,
                    ),
                    majorTickStyle: MajorTickStyle(
                      thickness: 2,
                      length: 10,
                      color: Colors.transparent,
                    ),
                    minorTickStyle: MinorTickStyle(
                      thickness: 1,
                      length: 5,
                      color: Colors.grey,
                    ),
                    ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: profileController.isKg == "kg" ? 80 : 175,
                        endValue: profileController.isKg == "kg" ? 120 : 265,
                        color: Colors.transparent,
                        startWidth: 15,
                        endWidth: 15,
                      ),
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(
                        value: profileController.weightValue,
                        enableDragging: true,
                        needleColor: Color(0xFF522ED2),
                        needleStartWidth: 1,
                        needleEndWidth: 4,
                        lengthUnit: GaugeSizeUnit.factor,
                        knobStyle: KnobStyle(
                          color: Color(0xFF522ED2),
                          sizeUnit: GaugeSizeUnit.logicalPixel,
                          knobRadius: 0.08,
                        ),
                        onValueChanged: (value) {
                          setState(() {
                            profileController.weightValue = value;
                          });
                        },
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${profileController.weightValue.toInt()}',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF522ED2),
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              profileController.isKg == "kg" ? 'Kg' : 'LBS',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        positionFactor: 0.8,
                        angle: 90,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                // Pass selected weight unit (Kg or Lbs) to the next screen
                Get.to(HeightSelectionScreen(), arguments: profileController.isKg);
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
