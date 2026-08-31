import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const SumGridApp());
}

class SumGridApp extends StatelessWidget {
  const SumGridApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sum Grid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAF5FF),
      ),
      home: const SumGridPage(),
    );
  }
}

class SumGridPage extends StatefulWidget {
  const SumGridPage({super.key});

  @override
  State<SumGridPage> createState() => _SumGridPageState();
}

class _SumGridPageState extends State<SumGridPage> {
  final List<List<TextEditingController>> _controllers =
      List.generate(3, (_) => List.generate(3, (_) => TextEditingController()));

  List<List<int>> grid = List.generate(3, (_) => List.filled(3, 0));
  int total = 0;

  void _calculateSum() {
    int sum = 0;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        sum += grid[i][j];
      }
    }
    setState(() => total = sum);
  }

  void _resetGrid() {
    setState(() {
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          grid[i][j] = 0;
          _controllers[i][j].clear();
        }
      }
      total = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sum Grid App'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors