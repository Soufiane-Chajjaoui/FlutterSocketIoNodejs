// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:whatssap/CustomUI/Card.dart';
import 'package:whatssap/Model/modalchat.dart';
import 'package:whatssap/Screens/CameraScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.sourceID});
  final int? sourceID;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;
  @override
  void initState() {
    print(widget.sourceID);
    // TODO: implement initState
    super.initState();
    _tabcontroller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  List<ModalChat> list = [
    ModalChat(
        id: 1,
        name: 'Soufiane',
        currentMessage: 'Kayn match lyom ji tl3ab',
        time: '19:03',
        isGroup: false,
        profil: 'assets/Icons/person.svg'),
    ModalChat(
        id: 2,
        name: 'Reda',
        currentMessage: 'chof chwya ldik jih',
        time: '20:12',
        isGroup: false,
        profil: 'assets/Icons/person.svg'),
    ModalChat(
        id: 3,
        name: 'Brahim',
        currentMessage: 'Kayn match gheda ji tl3ab',
        time: '05:15',
        isGroup: false,
        profil: 'assets/Icons/person.svg'),
    ModalChat(
        id: 4,
        name: 'Abdollah',
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
      appBar: AppBar(
        backgroundColor: Color(0xFF075E54),
        title: Text('Whatssap'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
          PopupMenuButton(
              splashRadius: 25,
              onSelected: (value) => print(value),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text('Nouvelle group'),
                    value: 'Nouvelle group',
                  ),
                  PopupMenuItem(
                    child: Text('Nouvelle Broadcast'),
                    value: 'Nouvelle Broadcast',
                  ),
                  PopupMenuItem(
                    child: Text('Devices connected'),
                    value: 'Devices connected',
                  ),
                  PopupMenuItem(
                    child: Text('Message require'),
                    value: 'Message require',
                  ),
                  PopupMenuItem(
                    child: Text('Setteings'),
                    value: 'Settings',
                  ),
                ];
              })
        ],
        bottom: TabBar(
          controller: _tabcontroller,
          tabs: [
            Tab(
              icon: Icon(Icons.camera_enhance),
            ),
            Tab(
              text: 'Disc',
            ),
            Tab(
              text: 'Status',
            ),
            Tab(
              text: 'Appels',
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.discount_rounded),
      ),
      body: TabBarView(controller: _tabcontroller, children: [
       // CameraScreen(),
       Center(child: Text("Camera is hard"),),
        ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Card_Custom(
              chat: list[index],
              sourceID: widget.sourceID,
              fromLogin: false,
            );
          },
        ),
        Center(
          child: Text('Camera'),
        ),
        Center(
          child: Text('Camera'),
        ),
      ]),
    );
  }
}
