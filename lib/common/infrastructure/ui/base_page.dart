import 'package:flutter/material.dart';

abstract class BasePage extends StatelessWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: body(context),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text('Fire Hex Bloc'),
    );
  }

  Widget body(BuildContext context);
}
