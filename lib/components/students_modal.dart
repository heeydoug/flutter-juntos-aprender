import 'package:flutter/material.dart';
import 'package:flutter_juntos_aprender/models/student.model.dart';
import 'package:flutter_juntos_aprender/utils/colors.dart';
import 'package:intl/intl.dart';

class StudentsModal extends StatelessWidget {
  final List<StudentModel> students;

  StudentsModal({required this.students});

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.height * 0.7;

    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16.0),
        constraints: BoxConstraints(
          maxHeight: students.isEmpty ? containerHeight * 0.6 : containerHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lista de Alunos da Sala',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            if (students.isEmpty)
              Column(
                children: [
                  Image.asset('assets/list-student.png', height: 180),
                  SizedBox(height: 16.0),
                  Text(
                    'Esta sala não possui alunos cadastrados!',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              )
            else
              Expanded(
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      StudentModel student = students[index];
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(student.data);

                      return Card(
                        elevation: 2.0,
                        color: Color.fromARGB(255, 231, 159, 242),
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Aluno: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: '${student.nome}',
                                ),
                              ],
                            ),
                          ),
                          subtitle: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Data de Nascimento: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: formattedDate,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Fechar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.roxo,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
