import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Home()));
class Home extends StatefulWidget{@override State<Home> createState()=>_Home();}
class _Home extends State<Home>{
  Timer? t;
  @override void initState(){super.initState();Future.delayed(Duration(seconds:15),(){_open();t=Timer.periodic(Duration(seconds:60),(_)=>_open());});}
  _open() async{await launchUrl(Uri.parse('https://mahadplanner192.my.canva.site/'),mode:LaunchMode.externalApplication);}
  @override void dispose(){t?.cancel();super.dispose();}
  @override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:Text("Sum Grid")),body:Center(child:Text("Har 1 min baad link khulega")));}
}