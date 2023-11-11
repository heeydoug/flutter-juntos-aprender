import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_juntos_aprender/components/decoration_inputs.dart';
import 'package:flutter_juntos_aprender/controllers/control_student.dart';
import 'package:flutter_juntos_aprender/models/student.model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateStudentScreen extends StatefulWidget {
  @override
  _CreateStudentScreenState createState() => _CreateStudentScreenState();
}

class _CreateStudentScreenState extends State<CreateStudentScreen> {
  TextEditingController _nomeController = TextEditingController();
  late DateTime _dataNascimento = DateTime.now();
  late String _fotoPath = '';

  late ControllStudent _controllStudent;

  @override
  void initState() {
    super.initState();
    _controllStudent = ControllStudent();
  }

  _addStudents(String nome, DateTime date, String urlImg) {
    final newStudent = StudentModel(nome: nome, data: date, urlImg: urlImg);

    _controllStudent.insert(newStudent);
    Navigator.of(context).pop();
  }

  Future<void> _selectDataNascimento(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dataNascimento) {
      setState(() {
        _dataNascimento = picked;
      });
    }
  }

  Future<void> _selectFoto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _fotoPath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Alunos'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: _fotoPath.isNotEmpty
                        ? FileImage(File(_fotoPath))
                        : null,
                    child: _fotoPath.isEmpty
                        ? Icon(Icons.person, size: 50, color: Colors.white)
                        : null,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue, // Substitua pela cor desejada
                    ),
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.camera_alt),
                      onPressed: _selectFoto,
                      tooltip: 'Selecionar Foto',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              TextField(
                  controller: _nomeController,
                  decoration: getInputDecoration('Nome')),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                        text: _dataNascimento != null
                            ? DateFormat('dd/MM/yyyy').format(_dataNascimento)
                            : '',
                      ),
                      onTap: () => _selectDataNascimento(context),
                      decoration: getInputDecoration('Data de Nascimento'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Selecione a data de nascimento';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  print('Nome: ${_nomeController.text}');
                  print('Data de Nascimento: $_dataNascimento');
                  print('Foto Path: $_fotoPath');
                  _addStudents(
                      _nomeController.text, _dataNascimento, _fotoPath);
                },
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
