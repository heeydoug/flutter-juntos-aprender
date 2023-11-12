import 'package:flutter/material.dart';
import 'package:flutter_juntos_aprender/components/delete_dialog.dart';
import 'package:flutter_juntos_aprender/models/classroom_model.dart';
import 'package:flutter_juntos_aprender/utils/colors.dart';
import 'package:intl/intl.dart';

class ClassroomList extends StatelessWidget {
  final List<ClassroomModel> _classrooms;
  final Function(int id) onRemove;

  ClassroomList(this._classrooms, this.onRemove);

  @override
  Widget build(BuildContext context) {
    //Componente pai para delimitar a area do ListView
    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
      child: _classrooms.isEmpty
          ? Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Nenhuma Sala Cadastrada!',
                  style: TextStyle(color: MyColors.roxo),
                ),
                const SizedBox(height: 20),
                // SizedBox(
                //   height: 200,
                //   child: Image.asset(
                //     'assets/images/waiting.png',
                //     fit: BoxFit.cover,
                //   ),
                // ),
              ],
            )
          : ListView.builder(
              //Quantidade de itens totais
              itemCount: _classrooms.length,

              //Metodo de criação de cada item
              itemBuilder: (ctx, index) {
                final cl = _classrooms[index];
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
                          child: Text(
                            '${cl.quantidadeAlunos} \n Alunos',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      cl.nomeSala!,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(cl.data),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: (() => _showDeleteConfirmationDialog(
                          context, cl.nomeSala, index)),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, String nomeSala, int index) {
    showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        title: 'Confirmar Exclusão',
        content: 'Deseja realmente excluir a sala ' + nomeSala + ' ?',
        onCancel: () => Navigator.of(context).pop(),
        onConfirm: () {
          onRemove(index);
          Navigator.of(context).pop(); // Fecha o diálogo
        },
      ),
    );
  }
}
