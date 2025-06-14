import 'package:flutter/material.dart';
import 'package:flutter_10_batch/statefull_class.dart';
import 'Module_11/class_1/alert/alert.dart';
import 'Module_11/class_1/lifeCycle.dart';
import 'Module_11/class_1/lifecyTest.dart';
import 'Module_11/class_2/CalculatorApp.dart';
import 'Module_11/class_3/waterTracker.dart';
import 'flutter_class_1.dart';
import 'flutter_class_2.dart';
import 'package:flutter_10_batch/from_login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'module 9 class 3.dart';
import 'module_12/class_1.dart';
import 'module_12/class_2.dart';
import 'module_12/class_3.dart';
import 'module_9_class_2.dart';
import 'module_9_mediaQuery.dart';
import 'module_9_todo.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          home: child,
        );
      },
      child: const Module12Class3 (),
    );
  }

}