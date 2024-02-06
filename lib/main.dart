import 'package:flutter/material.dart';
import 'package:to_do_list/layout/navigation.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const SafeArea(child: Navigation()),
      debugShowCheckedModeBanner: false,
    );
  }
}
