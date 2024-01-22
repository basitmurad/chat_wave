class ChatRoomModel{
  String? chatRoomID;
  List<String> ?participants;

  ChatRoomModel(this.chatRoomID, this.participants);

  ChatRoomModel.fromMap(Map<String , dynamic> map)
  {
    chatRoomID= map["CHATROOMID"];
    participants= map["PARTICIPANTS"];

  }
  Map<String , dynamic> toMap()
  {
return {
  "CHATROOMID": chatRoomID,
  "PARTICIPANTS": participants,

};
  }
}