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
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF5F3FF),
        useMaterial3: true,
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
  List<List<int>> grid = List.generate(3, (_) => List.generate(3, (_) => 0));
  List<List<TextEditingController>> controllers = List.generate(
    3, (_) => List.generate(3, (_) => TextEditingController())
  );
  int totalSum = 0;
  int rowSum = 0;
  int colSum = 0;

  void calculateSum() {
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

  void resetGrid() {
    setState(() {
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          grid[i][j] = 0;
          controllers[i][j].clear();
        }
      }
      totalSum = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sum Grid App'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter Numbers',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // 3x3 GRID
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    int row = index ~/ 3;
                    int col = index % 3;
                    return TextField(
                      controller: controllers[row][col],
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF5F3FF),
                      ),
                      onChanged: (value) {
                        grid[row][col] = int.tryParse(value)?? 0;
                        calculateSum();
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              // TOTAL SUM CARD
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.deepPurple.shade300],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Total Sum',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    Text(
                      '$totalSum',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // RESET BUTTON
              ElevatedButton.icon(
                onPressed: resetGrid,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset Grid'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}