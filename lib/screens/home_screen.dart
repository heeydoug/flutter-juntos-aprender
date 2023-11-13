import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_juntos_aprender/components/app_bar.dart';
import 'package:flutter_juntos_aprender/components/app_drawer.dart';
import 'package:flutter_juntos_aprender/screens/create_classroom_screen.dart';
import 'package:flutter_juntos_aprender/screens/create_student_screen.dart';
import 'package:flutter_juntos_aprender/utils/colors.dart';
import 'package:flutter_juntos_aprender/utils/nav.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Botão animado
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Juntos Aprender"),
      drawer: AppDrawer(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/home-img.png', height: 180),
              SizedBox(height: 16.0),
              Text(
                'Bem-vindo ao Juntos Aprender!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Explore e aprenda juntos.',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionBubble(
        items: <Bubble>[
          Bubble(
            icon: Icons.add_home,
            iconColor: Colors.white,
            title: "Cadastrar sala",
            titleStyle: TextStyle(color: Colors.white),
            bubbleColor: MyColors.roxo,
            onPress: () =>
                push(context, CreateClassroomScreen(), replace: false),
          ),
          Bubble(
            icon: Icons.person_add,
            iconColor: Colors.white,
            title: "Cadastrar alunos",
            titleStyle: TextStyle(color: Colors.white),
            bubbleColor: MyColors.roxo,
            onPress: () => push(context, CreateStudentScreen(), replace: false),
          ),
        ],
        onPress: () => _animationController.isCompleted
            ? _animationController.reverse()
            : _animationController.forward(),
        iconData: Icons.add,
        iconColor: Colors.white,
        backGroundColor: MyColors.roxo,
        animation: _animation,
      ),
    );
  }
}
