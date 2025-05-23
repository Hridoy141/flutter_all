import 'package:flutter/material.dart';

import 'lifecyTest.dart';


class lifeCycle extends StatefulWidget {
  const lifeCycle({super.key});

  @override
  State<lifeCycle> createState() => _lifeCycleState();
}

class _lifeCycleState extends State<lifeCycle> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('From initState');
  }
  
  @override
  void dispose() {
    print('Dispose called');
    super.dispose();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('this is app bar'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=> LifeCycleTest())) ;
            },
            child: Text('Next page',style: TextStyle(color: Colors.blue),)),
      ),
    );
  }
}
