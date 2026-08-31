import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const SumGridApp());

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
      home: const SumGridHome(),
    );
  }
}

class SumGridHome extends StatefulWidget {
  const SumGridHome({super.key});

  @override
  State<SumGridHome> createState() => _SumGridHomeState();
}

class _SumGridHomeState extends State<SumGridHome> {
  final List<List<TextEditingController>> _controllers =
      List.generate(3, (_) => List.generate(3, (_) => TextEditingController()));

  List<List<int>> grid = List.generate(3, (_) => List.filled(3, 0));
  int total = 0;

  void _calculate() {
    int sum = 0;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        sum += grid[i][j];
      }
    }
    setState(() => total = sum);
  }

  void _reset() {
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
        title: const Text('Sum Grid'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Fill the Grid',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),

            // GRID
            Expanded(
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  int i = index ~/ 3;
                  int j = index % 3;
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withOpacity(0.1),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: TextField(
                      controller: _controllers[i][j],
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '0',
                      ),
                      onChanged: (val) {
                        grid[i][j] = int.tryParse(val)?? 0;
                        _calculate();
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // TOTAL
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.deepPurple, Colors.purpleAccent],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text('TOTAL SUM',
                      style: TextStyle(color: Colors.white70, fontSize: 16)),
                  Text('$total',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // BUTTONS
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _reset,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Reset', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}