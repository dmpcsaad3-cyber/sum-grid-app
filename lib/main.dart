import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _adTimer;

  @override
  void initState() {
    super.initState();
    // 15 sec baad pehla ad, phir HAR 1 MINUTE BAAD
    Future.delayed(Duration(seconds: 15), () {
      _openLink();
      _adTimer = Timer.periodic(Duration(seconds: 60), (timer) { // YEH 1 MINUTE HAI
        _openLink();
      });
    });
  }

  Future<void> _openLink() async {
    final Uri link = Uri.parse('https://mahadplanner192.my.canva.site/');
    if (await canLaunchUrl(link)) {
      await launchUrl(link, mode: LaunchMode.externalApplication);
    }
  }

  @override
  void dispose() {
    _adTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sum Grid")),
      body: Center(child: Text("Har 1 min baad auto site khulegi")),
    );
  }
}