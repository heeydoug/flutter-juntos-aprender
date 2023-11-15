import 'package:flutter/material.dart';
import 'package:flutter_juntos_aprender/components/delete_dialog.dart';
import 'package:flutter_juntos_aprender/models/student.model.dart';
import 'package:flutter_juntos_aprender/screens/edit_student_screen.dart';
import 'package:flutter_juntos_aprender/utils/colors.dart';
import 'package:flutter_juntos_aprender/utils/snackbar.dart';
import 'package:intl/intl.dart';

class StudentList extends StatelessWidget {
  final List<StudentModel> _students;
  final Function(int id) onRemove;
  final Function(StudentModel studentModel, int id) onUpdate;

  StudentList(this._students, this.onRemove, this.onUpdate);

  @override
  Widget build(BuildContext context) {
    //Componente pai para delimitar a area do ListView
    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
      child: _students.isEmpty
          ? Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Nenhum aluno cadastrada!',
                  style: TextStyle(color: MyColors.roxo),
                ),
                const SizedBox(height: 20),
              ],
            )
          : ListView.builder(
              //Quantidade de itens totais
              itemCount: _students.length,

              //Metodo de criação de cada item
              itemBuilder: (ctx, index) {
                final st = _students[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: MyColors.roxo,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                            // child: Text(
                            //   '${st.quantidadeAlunos} \n Alunos',
                            //   style: TextStyle(color: Colors.white),
                            //   textAlign: TextAlign.center,
                            // ),
                            ),
                      ),
                    ),
                    title: Text(
                      st.nome!,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Data de Nascimento: ' +
                          DateFormat('d MMM y').format(st.data),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditStudentScreen(
                              student: st, index: index, onUpdate: onUpdate),
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: (() => _showDeleteConfirmationDialog(
                          context, st.nome, index)),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, String nome, int index) {
    showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        title: 'Confirmar Exclusão',
        content: 'Deseja realmente excluir o(a) aluno(a) ' + nome + ' ?',
        onCancel: () => Navigator.of(context).pop(),
        onConfirm: () {
          onRemove(index);
          showSnackBar(
              context: context,
              texto: 'Aluno excluído com sucesso!',
              isErro: false);
          Navigator.of(context).pop(); // Fecha a dialog
        },
      ),
    );
  }
}
