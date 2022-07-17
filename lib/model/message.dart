// import 'package:json_annotation/json_annotation.dart';

// part 'message.g.dart';
// @JsonSerializable()
class Message {
  final String text;
  final DateTime date;
  final bool isSentByMe;

  Message(this.text, this.date, this.isSentByMe);

  // factory Message.fromJson(Map<String, dynamic>? json) => _$MessageFromJson(
  //       json!,
  //     );
  // Map<String,dynamic> toJson()=>_$MessageToJson(this);

  Message.fromMap(Map map)
      : text = map['text'],
        date = DateTime.parse(map['date'] as String),
        isSentByMe =true;
  Map toMap(){
    return{
        'text':text,
        'date':date.toIso8601String(),
        'isSentByMe':isSentByMe
    };
  }
  @override
  String toString() => 'Message{text:$text,date:$date,isSentByMe:$isSentByMe}';
}
