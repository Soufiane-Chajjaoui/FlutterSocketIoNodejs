import 'package:flutter/material.dart';

Widget showMessage(String? content, BuildContext context, String time , {bool isMe = true}) {
  return Align(
    alignment: isMe ? Alignment.bottomRight : Alignment.bottomLeft,
    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - 55,
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: isMe ? Colors.green[300] : Color.fromARGB(255, 217, 225, 218),
        child: Stack(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 4, bottom: 20, right: 30, left: 7),
              child: Text(
                '${content}',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Positioned(
              bottom: 4,
              right: 10,
              child: Row(
                children: [
                  Text(
                    time,
                    style: TextStyle(fontSize: 14),
                  ),
                  isMe
                      ? Icon(
                          Icons.done_all_outlined,
                          size: 15,
                        )
                      : Container()
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
