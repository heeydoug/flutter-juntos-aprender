import 'package:flutter/material.dart';
import 'package:flutter_juntos_aprender/components/app_bar.dart';
import 'package:flutter_juntos_aprender/components/decoration_inputs.dart';
import 'package:flutter_juntos_aprender/controllers/control_student.dart';
import 'package:flutter_juntos_aprender/models/student.model.dart';
import 'package:flutter_juntos_aprender/utils/colors.dart';
import 'package:flutter_juntos_aprender/utils/snackbar.dart';
import 'package:intl/intl.dart';

class EditStudentScreen extends StatefulWidget {
  final StudentModel student;

  EditStudentScreen({required this.student});

  @override
  _EditStudentScreenState createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  late TextEditingController _nomeController;
  late DateTime _dataNascimento;
  late ControllStudent _controllStudent;

  @override
  void initState() {
    super.initState();
    _controllStudent = ControllStudent();
    _nomeController = TextEditingController(text: widget.student.nome);
    _dataNascimento = widget.student.data;
  }

  _editStudent() {
    if (_nomeController.text.isEmpty) {
      showSnackBar(
        context: context,
        texto: 'Por favor, insira o nome do aluno!',
        isErro: true,
      );
    } else {
      final editedStudent = StudentModel(
        id: widget.student.id,
        nome: _nomeController.text,
        data: _dataNascimento,
        urlImg: widget.student.urlImg,
      );

      _controllStudent.update(editedStudent);
      showSnackBar(
        context: context,
        texto: 'Alterações salvas com sucesso!',
        isErro: false,
      );
      Navigator.of(context).pop();
    }
  }

  Future<void> _selectDataNascimento(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataNascimento,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dataNascimento) {
      setState(() {
        _dataNascimento = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Editar Aluno'),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/student.png', height: 180),
              SizedBox(height: 16.0),
              TextField(
                controller: _nomeController,
                decoration: getInputDecoration('Nome'),
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () => _selectDataNascimento(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: _dataNascimento == null
                          ? 'Nenhuma data selecionada!'
                          : 'Data de Nascimento: ${DateFormat('dd/MM/yyyy').format(_dataNascimento)}',
                    ),
                    decoration: getInputDecoration('Data de Nascimento'),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _editStudent,
                child: Text('Salvar Alterações'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.roxo,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
