import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatssap/CustomUI/Card.dart';
import 'package:whatssap/Model/modalchat.dart';
import 'package:whatssap/Screens/CameraScreen.dart';
import 'package:whatssap/Screens/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: 'BarlowCondensed',
          primaryColor: Color(0xFF075E54),
          accentColor: Color.fromARGB(255, 152, 177, 174)),
      home: const LoginTest(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginTest extends StatefulWidget {
  const LoginTest({super.key});

  @override
  State<LoginTest> createState() => _LoginTestState();
}

class _LoginTestState extends State<LoginTest> {
  List<ModalChat> list = [
    ModalChat(
        id: 1,
        name: '7argous',
        currentMessage: 'Kayn match lyom ji tl3ab',
        time: '19:03',
        isGroup: false,
        profil: 'assets/Icons/person.svg'),
    ModalChat(
        id: 2,
        name: 'Basisa',
        currentMessage: 'chof chwya ldik jih',
        time: '20:12',
        isGroup: false,
        profil: 'assets/Icons/person.svg'),
    ModalChat(
        id: 3,
        name: 'Ahmed',
        currentMessage: 'Kayn match gheda ji tl3ab',
        time: '05:15',
        isGroup: false,
        profil: 'assets/Icons/person.svg'),
    ModalChat(
        id: 4,
        name: 'Mahdi',
        currentMessage: 'mbrouk l3wacher',
        time: '02:44',
        isGroup: false,
        profil: 'assets/Icons/person.svg'),
    ModalChat(
        id: 5,
        name: 'EST GI',
        currentMessage: 'ghadi ntwa7chokm kamlinn <3',
        time: '00:00',
        isGroup: true,
        profil: 'assets/Icons/group.svg'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Card_Custom(chat: list[index] , fromLogin: true,);
          }),
    );
  }
}
