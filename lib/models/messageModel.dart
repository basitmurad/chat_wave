import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{
  String? messageId;
  String? sender;
  String? textMessage;
  bool? seenBy;
  Timestamp? sendOn;

  MessageModel(  this.messageId ,this.sender, this.textMessage, this.seenBy, this.sendOn);


  MessageModel.fromMap(Map<String , dynamic> map)
  {

    messageId = map["MESSAGEID"];
    sender = map["SENDER"];
    textMessage = map["TEXTMESSAGE"];
    seenBy = map["SEENBY"];
    sendOn = map["SENDON"];
  }

  Map<String , dynamic> toMap()
  {
    return {
      "MESSAGEID":messageId,
      "SENDER":sender,
      "TEXTMESSAGE":textMessage,
      "SEENBY":seenBy,
      "SENDON":sendOn,
  };
}
}