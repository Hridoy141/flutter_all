import 'package:flutter/material.dart';

import '../../widget/add_water_button.dart';

class Watertracker extends StatefulWidget {
  const Watertracker({super.key});

  @override
  State<Watertracker> createState() => _WatertrackerState();
}

class _WatertrackerState extends State<Watertracker> {
  int currentInTake = 0;
  final int goal = 2000;

  void waterAdd(int amount){
    setState(() {
      currentInTake = (currentInTake+amount).clamp(0, goal);
    });
  }
  void resetWater(){
    setState(() {
      currentInTake=0;
    });
  }



  @override
  Widget build(BuildContext context) {
    double progress = (currentInTake/goal).clamp(0.0, 1.0);
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Water Tracker',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Todays InTank',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),

                  SizedBox(height: 10),
                  Text(
                    '$currentInTake LTR',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  child: CircularProgressIndicator(
                    value: progress,
                    color: Colors.blue,
                    backgroundColor: Colors.grey,
                    strokeWidth: 10,
                  ),
                ),
                Text(
                  '${(progress*100).toInt()} %',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 40),

            Wrap(
              spacing: 20,
              children: [
                addWaterbutton(
                  amount: 200,
                  icon: Icons.local_drink,
                  onClitck: ()=> waterAdd(200),
                ),
                addWaterbutton(
                  color: Colors.green,
                  amount: 500,
                  icon: Icons.local_drink,
                  onClitck: ()=> waterAdd(500),
                ),
                addWaterbutton(
                  amount: 1000,
                  color: Colors.green,
                  icon: Icons.local_drink,
                  onClitck: ()=> waterAdd(1000),
                ),
              ],
            ),
            SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
             child:   ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: ()=> resetWater(),
              child: Text(
                'Reset',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ),],
        ),
      ),
    );
  }
}
