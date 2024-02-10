import 'package:flutter/material.dart';
import 'package:to_do_list/layout/navigation.dart';
import 'package:flutter/services.dart';
import 'package:to_do_list/utils/colors.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: MainColors.primary_300,
      ),
    );

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
      ),
      home: const SafeArea(
        child: Navigation(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
