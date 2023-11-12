import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_juntos_aprender/components/app_bar.dart';
import 'package:flutter_juntos_aprender/components/app_drawer.dart';
import 'package:flutter_juntos_aprender/controllers/control_classroom.dart';
import 'package:flutter_juntos_aprender/models/classroom_model.dart';
import 'package:flutter_juntos_aprender/screens/create_classroom_screen.dart';
import 'package:flutter_juntos_aprender/utils/colors.dart';

class ManageClassroom extends StatelessWidget {
  const ManageClassroom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Gerenciar Salas"),
      drawer: AppDrawer(),
      body: StreamBuilder(
        stream: ControlClassRoom().stream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.data?.docs.isEmpty ?? true) {
            return Center(
              child: Text('Você não possui salas cadastradas.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var classroomData =
                  snapshot.data?.docs[index].data() as Map<String, dynamic>;
              var classroomModel = ClassroomModel.fromMap(classroomData);

              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(
                    classroomModel.nomeSala,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('teste'),
                  onTap: () {},
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.roxo,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateClassroomScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
