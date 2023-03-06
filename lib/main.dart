import 'package:flutter/material.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Fire Hex Bloc',
      home: Center(
        child: Text('Fire Hex Bloc'),
      ),
    );
  }
}
