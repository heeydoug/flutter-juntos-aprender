import 'package:flutter/material.dart';
import 'package:flutter_juntos_aprender/components/app_drawer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Juntos Aprender - Home")),
        drawer: AppDrawer());
  }
}
