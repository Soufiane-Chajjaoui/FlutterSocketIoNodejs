class ModalChat {
  int? id;
  String? currentMessage;
  String? time;
  bool? isGroup;
  String? profil;
  String? name;

  ModalChat(
      {required this.id,
      this.name,
      this.currentMessage,
      this.isGroup,
      this.profil,
      this.time});
}

class Message {
  String? content;
  String? time;
  bool isMe;

  Message({this.content, required this.time , required this.isMe});
}
