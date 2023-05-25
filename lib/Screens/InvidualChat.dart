// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:math';
import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:whatssap/CustomUI/Card.dart';
import 'package:whatssap/CustomUI/UImessage.dart';
import 'package:whatssap/Model/modalchat.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../CustomUI/bottomsheet.dart';

class InvidualSreen extends StatefulWidget {
  const InvidualSreen({super.key, required this.chat, required this.sourceID});
  final ModalChat chat;
  final int? sourceID;
  @override
  State<InvidualSreen> createState() => _InvidualSreenState();
}

class _InvidualSreenState extends State<InvidualSreen> {
  // Socket Client Side

  IO.Socket? socket;

  void connect() {
    socket = IO.io(
        "http://192.168.1.5:3000",
        IO.OptionBuilder().setTransports(['websocket']).setQuery(
            {'sourceID': widget.sourceID}).build());
    socket?.emit('/login', "${widget.sourceID}");
    socket?.onConnect((data) {
      print('Server is connected of successful');
      socket?.on("/receive", (msg) {
        setState(() {
          messages.add(Message(
              content: msg['message'], time: Jiffy.now().Hm, isMe: false));
          _contollerScroller.animateTo(
              _contollerScroller.position.maxScrollExtent,
              duration: Duration(milliseconds: 1),
              curve: Curves.linear);
        });
      });
    });
  }

  // _connectSocket() {
  //   socket?.onConnect((data) => print('Server is connected of successful'));
  //   socket?.onConnectError(
  //       (data) => print('Error connection with server socket $data'));
  //   socket?.onDisconnect((data) => print("disconnect ${data}"));
  // }

  bool emojiShowing = false;

  List<Message> messages = [];
  ScrollController _contollerScroller = ScrollController();

  TextEditingController _controller = TextEditingController();
  IconData? Icondata = Icons.mic_rounded;
  FocusNode focusNode_controll = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print(widget.sourceID);
    // TODO: implement initState
    connect();
    focusNode_controll.addListener(() {
      if (focusNode_controll.hasFocus) {
        setState(() {
          emojiShowing = false;
        });
        print('focuss');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double? height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width / 5,
        leading: InkWell(
          borderRadius: BorderRadius.circular(60),
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              const Icon(Icons.arrow_back_rounded),
              CircleAvatar(
                radius: 20,
                child: SvgPicture.asset(
                  widget.chat.isGroup == false
                      ? 'assets/Icons/person.svg'
                      : "${widget.chat.profil}",
                  height: 30,
                  width: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        title: InkWell(
          onTap: () {},
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.chat.name}",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const Text(
                  "last see today at 12:33",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam),
            splashRadius: 25,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
            splashRadius: 25,
          ),
          PopupMenuButton(
              splashRadius: 25,
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    child: Text('View Contact'),
                    value: {'name': 'soufian'},
                  ),
                  const PopupMenuItem(
                      child: Text('Media , links and documents')),
                  const PopupMenuItem(child: Text('Search')),
                  const PopupMenuItem(child: Text('Notifications')),
                  const PopupMenuItem(child: Text('Fonds screen')),
                  PopupMenuItem(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('More'),
                      const Icon(
                        Icons.arrow_right_sharp,
                        size: 20,
                        color: Colors.black26,
                      )
                    ],
                  )),
                ];
              }),
        ],
        backgroundColor: const Color(0xFF075E54),
      ),
      body: WillPopScope(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/whatsapp_Back.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: height,
              filterQuality: FilterQuality.low,
              colorBlendMode: BlendMode.dstOver,
              color: const Color.fromARGB(120, 0, 0, 0),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 60),
              width: width,
              height: height - 25,
              child: ListView.builder(
                padding: EdgeInsetsDirectional.only(top: 7, bottom: 40),
                controller: _contollerScroller,
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return showMessage(messages[index].content, context,
                      "${messages[index].time}",
                      isMe: messages[index].isMe);
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(children: [
                      Container(
                        width: width - 55,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: TextFormField(
                              controller: _controller,
                              onChanged: (value) {
                                if (value.length > 0) {
                                  setState(() {
                                    Icondata = Icons.send;
                                  });
                                  print(value);
                                } else
                                  setState(() {
                                    Icondata = Icons.mic_rounded;
                                  });
                              },
                              focusNode: focusNode_controll,
                              textAlignVertical: TextAlignVertical.center,
                              cursorHeight: 20,
                              keyboardType: TextInputType.multiline,
                              maxLines: 6,
                              minLines: 1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Message',
                                prefixIcon: IconButton(
                                  icon: const Icon(Icons.emoji_emotions),
                                  splashRadius: 22,
                                  onPressed: () {
                                    focusNode_controll.unfocus();
                                    // focusNode_controll.canRequestFocus = false;
                                    setState(() {
                                      emojiShowing = !emojiShowing;
                                    });
                                  },
                                ),
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (builder) {
                                                return bottomSheet(context);
                                              });
                                        },
                                        splashRadius: 22,
                                        icon: const Icon(Icons.attach_file)),
                                    IconButton(
                                        onPressed: () {},
                                        splashRadius: 22,
                                        icon: const Icon(Icons.camera_alt)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 23,
                        child: IconButton(
                          onPressed: () {
                            if (_controller.text.length > 0) {
                              socket?.emit('/message', {
                                "message": _controller.text,
                                "time": Jiffy.now().Hm,
                                "sourceID": widget.sourceID,
                                "targetID": widget.chat.id
                              });

                              setState(() {
                                messages.add(Message(
                                    content: _controller.text,
                                    isMe: true,
                                    time: Jiffy.now().Hm));
                                _controller.text = '';
                              });
                            }

                            _contollerScroller.animateTo(
                                _contollerScroller.position.maxScrollExtent,
                                duration: Duration(milliseconds: 1),
                                curve: Curves.linear);
                          },
                          icon: Icon(Icondata),
                        ),
                      )
                    ]),
                    Offstage(
                      offstage: !emojiShowing,
                      child: SizedBox(
                          height: height / 2,
                          child: EmojiPicker(
                            textEditingController: _controller,
                            config: Config(
                              columns: 9,
                              // Issue: https://github.com/flutter/flutter/issues/28894
                              emojiSizeMax: 25 *
                                  (foundation.defaultTargetPlatform ==
                                          TargetPlatform.iOS
                                      ? 1.30
                                      : 1.0),
                              verticalSpacing: 0,
                              horizontalSpacing: 0,
                              gridPadding: EdgeInsets.zero,
                              initCategory: Category.RECENT,
                              bgColor: const Color(0xFFF2F2F2),
                              indicatorColor: Colors.blue,
                              iconColor: Colors.grey,
                              iconColorSelected: Colors.blue,
                              backspaceColor: Colors.blue,
                              skinToneDialogBgColor: Colors.white,
                              skinToneIndicatorColor: Colors.grey,
                              enableSkinTones: true,
                              showRecentsTab: true,
                              recentsLimit: 28,
                              replaceEmojiOnLimitExceed: false,
                              noRecents: const Text(
                                'No Recents',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black26),
                                textAlign: TextAlign.center,
                              ),
                              loadingIndicator: const SizedBox.shrink(),
                              tabIndicatorAnimDuration: kTabScrollDuration,
                              categoryIcons: const CategoryIcons(),
                              buttonMode: ButtonMode.MATERIAL,
                              checkPlatformCompatibility: true,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        onWillPop: () {
          if (emojiShowing) {
            setState(() {
              emojiShowing = false;
            });
          } else {
            Navigator.pop(context);
          }
          return Future.value(false);
        },
      ),
    );
  }

  Widget emoji_picker() {
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {},
      config: Config(
        columns: 7,
        emojiSizeMax: 32 *
            (foundation.defaultTargetPlatform == TargetPlatform.iOS
                ? 1.30
                : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
        verticalSpacing: 0,
        horizontalSpacing: 0,
        gridPadding: EdgeInsets.zero,
        initCategory: Category.RECENT,
        bgColor: const Color(0xFFF2F2F2),
        indicatorColor: Colors.blue,
        iconColor: Colors.grey,
        iconColorSelected: Colors.blue,
        backspaceColor: Colors.blue,
        skinToneDialogBgColor: Colors.white,
        skinToneIndicatorColor: Colors.grey,
        enableSkinTones: true,
        showRecentsTab: true,
        recentsLimit: 28,
        noRecents: const Text(
          'No Recents',
          style: TextStyle(fontSize: 20, color: Colors.black26),
          textAlign: TextAlign.center,
        ), // Needs to be const Widget
        loadingIndicator: const SizedBox.shrink(), // Needs to be const Widget
        tabIndicatorAnimDuration: kTabScrollDuration,
        categoryIcons: const CategoryIcons(),
        buttonMode: ButtonMode.MATERIAL,
      ),
    );
  }
}
