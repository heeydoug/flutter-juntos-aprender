import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_juntos_aprender/components/decoration_inputs.dart';
import 'package:flutter_juntos_aprender/controllers/control_classroom.dart';
import 'package:flutter_juntos_aprender/models/classroom_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateClassroomScreen extends StatefulWidget {
  @override
  _CreateClassroomScreenState createState() => _CreateClassroomScreenState();
}

class _CreateClassroomScreenState extends State<CreateClassroomScreen> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _quantidadeAlunosController = TextEditingController();
  late DateTime _data = DateTime.now();
  late String _fotoPath = '';
  String _selectedTipoEnsino = 'Ensino Fundamental';

  late ControlClassRoom _controlClassRoom;

  @override
  void initState() {
    super.initState();
    _controlClassRoom = ControlClassRoom();
  }

  _addClassroom(String nome, DateTime date, String urlImg,
      String quantidadeAlunos, String selectedTipoEnsino) {
    final newClassroom = ClassroomModel(
      nomeSala: nome,
      data: date,
      urlImg: urlImg,
      quantidadeAlunos: int.parse(quantidadeAlunos),
      tipoEnsino: selectedTipoEnsino,
    );
    _controlClassRoom.insert(newClassroom);
    Navigator.of(context).pop();
  }

  Future<void> _selectData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: Locale('pt', 'BR'),
    );
    if (picked != null) {
      setState(() {
        _data = picked.add(Duration(hours: 3));
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Salas'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.0),
              TextField(
                controller: _nomeController,
                decoration: getInputDecoration('Nome'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _quantidadeAlunosController,
                decoration: getInputDecoration('Quantidade de Alunos'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                        text: _data == null
                            ? 'Nenhuma data selecionada!'
                            : 'Data Selecionada: ${DateFormat('dd/MM/yyyy').format(_data)}',
                      ),
                      onTap: () => _selectData(context),
                      decoration: getInputDecoration('Data de criação'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Selecione a data de criação';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              InputDecorator(
                decoration: getInputDecoration('Tipo de Ensino'),
                child: DropdownButton<String>(
                  value: _selectedTipoEnsino,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTipoEnsino = newValue!;
                    });
                  },
                  items: <String>['Ensino Fundamental', 'Ensino Médio']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  print('Nome: ${_nomeController.text}');
                  print(
                      'Quantidade de Alunos: ${_quantidadeAlunosController.text}');
                  print('Data de criação: $_data');
                  print('Foto Path: $_fotoPath');
                  print('Tipo de Ensino: $_selectedTipoEnsino');
                  _addClassroom(
                    _nomeController.text,
                    _data,
                    _fotoPath,
                    _quantidadeAlunosController.text,
                    _selectedTipoEnsino,
                  );
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
