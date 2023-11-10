import 'package:flutter/material.dart';

class RegisterClassroom extends StatelessWidget {
  const RegisterClassroom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.purple, title: Text("Cadastrar Sala")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
