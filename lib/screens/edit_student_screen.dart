import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_juntos_aprender/components/app_bar.dart';
import 'package:flutter_juntos_aprender/components/decoration_inputs.dart';
import 'package:flutter_juntos_aprender/controllers/control_classroom.dart';
import 'package:flutter_juntos_aprender/controllers/control_student.dart';
import 'package:flutter_juntos_aprender/models/classroom_model.dart'; // Importe o modelo de sala
import 'package:flutter_juntos_aprender/models/student.model.dart';
import 'package:flutter_juntos_aprender/utils/colors.dart';
import 'package:flutter_juntos_aprender/utils/snackbar.dart';
import 'package:intl/intl.dart';

class EditStudentScreen extends StatefulWidget {
  final StudentModel student;
  final int index;
  final Function(StudentModel studentModel, int id) onUpdate;

  EditStudentScreen(
      {required this.student, required this.index, required this.onUpdate});

  @override
  _EditStudentScreenState createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  late TextEditingController _nomeController;
  late DateTime _dataNascimento;
  late ControllStudent _controllStudent;
  List<ClassroomModel>? _classrooms;
  ClassroomModel? selectedValue;

  @override
  void initState() {
    super.initState();
    _controllStudent = ControllStudent();
    _nomeController = TextEditingController(text: widget.student.nome);
    _dataNascimento = widget.student.data;

    // Carregar a lista de salas ao iniciar a tela
    _loadClassrooms();
    //
    _findByIdClassrom();
  }

  Future<void> _loadClassrooms() async {
    ControlClassRoom controlClassRoom = ControlClassRoom();
    List<ClassroomModel> classrooms = await controlClassRoom.getAllClassroom();
    setState(() {
      _classrooms = classrooms;
    });
  }

  Future<void> _findByIdClassrom() async {
    if (widget.student.id_class != null) {
      ControlClassRoom controlClassRoom = ControlClassRoom();
      int index = await controlClassRoom
          .getIndexClassroom(widget.student.id_class) as int;
      selectedValue = _classrooms![index];
    }
    return;
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
        id_class: selectedValue?.id,
      );

      widget.onUpdate(editedStudent, widget.index);
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
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(64),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<ClassroomModel>(
                    isExpanded: true,
                    hint: Text(
                      'Selecione a sala do estudante: ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: _classrooms
                        ?.map((ClassroomModel item) =>
                            DropdownMenuItem<ClassroomModel>(
                              value: item,
                              child: Text(
                                item.nomeSala,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (ClassroomModel? item) {
                      setState(() {
                        selectedValue = item;
                      });
                      print(selectedValue?.id);
                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 50,
                      width: 375,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
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
