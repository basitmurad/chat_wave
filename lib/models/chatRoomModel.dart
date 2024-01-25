class ChatRoomModel {
  String? chatRoomID;
  Map<String, dynamic>? participants;
  String? lastMessage;

  ChatRoomModel(this.chatRoomID, this.participants, this.lastMessage);

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    chatRoomID = map["CHATROOMID"];
    participants = map["PARTICIPANTS"];
    lastMessage = map["LASTMESSAGE"];
  }

  Map<String, dynamic> toMap() {
    return {
      "CHATROOMID": chatRoomID,
      "PARTICIPANTS": participants,
      "LASTMESSAGE": lastMessage,
    };
  }
}
