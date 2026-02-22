import 'package:flutter/material.dart';

final colorService = ColorService();

void main() {

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType { 
  red,
  green,
  yellow, 
  blue 
  }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _currentIndex == 0
              ? ColorTapsScreen()
              : StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorService extends ChangeNotifier{

  final Map<CardType, int> _counts = {
    CardType.red: 0,
    CardType.green: 0,
    CardType.yellow: 0,
    CardType.blue: 0,
  };

  int? getCount(CardType type) => _counts[type];

  void increment(CardType type) {
    _counts[type] = _counts[type]! + 1;
    notifyListeners();
  }

}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Color Taps')),
      body: ListenableBuilder(
        listenable: colorService, // Listen to changes in ColorService
        builder: (_, _) {
          return Column(
            children: [
              ColorTap(
                type: CardType.red,
                tapCount: colorService.getCount(CardType.red)!,
                onTap: () => colorService.increment(CardType.red),
              ),
              ColorTap(
                type: CardType.green,
                tapCount: colorService.getCount(CardType.green)!,
                onTap: () => colorService.increment(CardType.green),
              ),
              ColorTap(
                type: CardType.yellow,
                tapCount: colorService.getCount(CardType.yellow)!,
                onTap: () => colorService.increment(CardType.yellow),
              ),
              ColorTap(
                type: CardType.blue,
                tapCount: colorService.getCount(CardType.blue)!,
                onTap: () => colorService.increment(CardType.blue),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;
  final int tapCount;
  final VoidCallback onTap;

  const ColorTap({
    super.key,
    required this.type,
    required this.tapCount,
    required this.onTap,
  });

  Color get backgroundColor {
    switch (type) {
      case CardType.red:
        return Colors.red;
      case CardType.green:
        return Colors.green;
      case CardType.yellow:
        return Colors.yellow;
      case CardType.blue:
        return Colors.blue;
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $tapCount',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {

  const StatisticsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: Center(
        child: ListenableBuilder(
          listenable: colorService,
          builder: (_, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Red Taps: ${colorService.getCount(CardType.red)}',
                  style: const TextStyle(fontSize: 24),
                ),
                Text(
                  'Green Taps: ${colorService.getCount(CardType.green)}',
                  style: const TextStyle(fontSize: 24),
                ),
                Text(
                  'Yellow Taps: ${colorService.getCount(CardType.yellow)}',
                  style: const TextStyle(fontSize: 24),
                ),
                Text(
                  'Blue Taps: ${colorService.getCount(CardType.blue)}',
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
