class MessageModel{
  String? sender;
  String? textMessage;
  bool? seenBy;
  String? sendOn;

  MessageModel(this.sender, this.textMessage, this.seenBy, this.sendOn);


  MessageModel.fromMap(Map<String , dynamic> map)
  {
    sender = map["SENDER"];
    textMessage = map["TEXTMESSAGE"];
    seenBy = map["SEENBY"];
    sendOn = map["SENDON"];
  }

  Map<String , dynamic> toMap()
  {
    return {
      "SENDER":sender,
      "TEXTMESSAGE":textMessage,
      "SEENBY":seenBy,
      "SENDON":sendOn,
  };
}
}