import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_juntos_aprender/components/app_drawer.dart';
import 'package:flutter_juntos_aprender/controllers/control_classroom.dart';
import 'package:flutter_juntos_aprender/models/classroom_model.dart'; // Import your classroom model
import 'package:flutter_juntos_aprender/screens/create_classroom_screen.dart';

class ManageClassroom extends StatelessWidget {
  const ManageClassroom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Salas'),
      ),
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

          // Check if there are no documents
          if (snapshot.data?.docs.isEmpty ?? true) {
            return Center(
              child: Text('No classrooms available.'),
            );
          }

          // If there are documents, display the list
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var classroomData =
                  snapshot.data?.docs[index].data() as Map<String, dynamic>;
              var classroomModel = ClassroomModel.fromMap(classroomData);

              return ListTile(
                title: Text(classroomModel
                    .nomeSala), // Assuming you have a 'name' property in your ClassroomModel
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
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
