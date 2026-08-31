import 'package:flutter/material.dart';

void main() {
  runApp(const SumGridApp());
}

class SumGridApp extends StatelessWidget {
  const SumGridApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sum Grid App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const GridPage(),
    );
  }
}

class GridPage extends StatefulWidget {
  const GridPage({super.key});

  @override
  State<GridPage> createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  List<List<int>> grid = List.generate(3, (_) => List.generate(3, (_) => 0));
  int totalSum = 0;

  void updateSum() {
    int sum = 0;
    for (var row in grid) {
      for (var cell in row) {
        sum += cell;
      }
    }
    setState(() {
      totalSum = sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sum Grid App'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // GRID
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                int row = index ~/ 3;
                int col = index % 3;
                return TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.indigo.shade50,
                  ),
                  onChanged: (value) {
                    grid[row][col] = int.tryParse(value)?? 0;
                    updateSum();
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          // SUM DISPLAY
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'Total Sum: $totalSum',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // RESET BUTTON
          ElevatedButton(
            onPressed: () {
              setState(() {
                grid = List.generate(3, (_) => List.generate(3, (_) => 0));
                totalSum = 0;
              });
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: const Text('Reset', style: TextStyle(fontSize: 18)),
          )
        ],
      ),
    );
  }
}