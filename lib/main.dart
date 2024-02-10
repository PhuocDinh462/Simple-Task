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
        statusBarColor: Colors.transparent,
      ),
    );

    return MaterialApp(
      theme: ThemeData(
        primaryColor: MainColors.primary_300,
      ),
      home: const Navigation(),
      debugShowCheckedModeBanner: false,
    );
  }
}
