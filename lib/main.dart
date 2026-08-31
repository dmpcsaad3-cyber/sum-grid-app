import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sum Grid',
      home: SumGridPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SumGridPage extends StatefulWidget {
  @override
  _SumGridPageState createState() => _SumGridPageState();
}

class _SumGridPageState extends State<SumGridPage> {
  List<int> grid = List.generate(9, (_) => Random().nextInt(9) + 1);
  int score = 0;
  int? firstIndex;

  void tapCell(int index) {
    setState(() {
      if (firstIndex == null) {
        firstIndex = index;
      } else {
        int sum = grid[firstIndex!] + grid[index];
        if (sum == 10) {
          score += 10;
          grid[firstIndex!] = Random().nextInt(9) + 1;
          grid[index] = Random().nextInt(9) + 1;
        }
        firstIndex = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Score: $score')),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: 9,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () => tapCell(i),
            child: Card(
              color: firstIndex == i? Colors.orange : Colors.blue,
              child: Center(child: Text('${grid[i]}', style: TextStyle(fontSize: 32, color: Colors.white))),
            ),
          );
        },
      ),
    );
  }
}