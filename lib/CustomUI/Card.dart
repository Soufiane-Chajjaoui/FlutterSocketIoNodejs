// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatssap/Screens/HomePage.dart';
import 'package:whatssap/Screens/InvidualChat.dart';

import '../Model/modalchat.dart';

class Card_Custom extends StatefulWidget {
  const Card_Custom(
      {super.key, required this.chat, required this.fromLogin, this.sourceID});
  final ModalChat chat;
  final int? sourceID;
  final bool fromLogin;
  @override
  State<Card_Custom> createState() => _Card_CustomState();
}

class _Card_CustomState extends State<Card_Custom> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => !widget.fromLogin
                  ? InvidualSreen(
                      chat: widget.chat,
                      sourceID: widget.sourceID,
                    )
                  : HomePage(
                      sourceID: widget.chat.id,
                    ))),
      leading: CircleAvatar(
        radius: 25,
        child: SvgPicture.asset(
          widget.chat.isGroup == false
              ? 'assets/Icons/person.svg'
              : "${widget.chat.profil}",
          height: 30,
          width: 30,
          color: Colors.white,
        ),
        backgroundColor: Colors.blueGrey,
      ),
      title: Text(
        "${widget.chat.name}",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Row(
        children: [
          Icon(
            Icons.done_all_outlined,
            size: 17,
          ),
          SizedBox(
            width: 7,
          ),
          Text(
            widget.chat.currentMessage!.length > 16
                ? "${widget.chat.currentMessage!.trim()[1]}..."
                : "${widget.chat.currentMessage}",
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${widget.chat.time}',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w100,
            ),
          ),
          Icon(
            Icons.circle_notifications,
            size: 20,
            color: Color.fromARGB(255, 223, 204, 30),
          )
        ],
      ),
    );
  }
}
