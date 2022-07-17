// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:mute_help/model/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageUI extends StatefulWidget {
  const MessageUI({Key? key}) : super(key: key);

  @override
  State<MessageUI> createState() => _MessageUIState();
}

class _MessageUIState extends State<MessageUI> {
  final messageController = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(0.7);
    await flutterTts.speak(text);
  }

  Message? msg;

  List<Message> messages_List = [];
  // Message(
  //     'Sometimes it is better to type',
  //     DateTime.now().subtract(
  //       Duration(minutes: 1),
  //     ),
  //     true),
  // Message(
  //     'Here you go !!',
  //     DateTime.now().subtract(
  //       Duration(minutes: 1),
  //     ),
  //     true)
  // ];
  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    loadSharedPreferencesAndData();
    super.initState();
  }

  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  showInfodialog(BuildContext context, Message msg) {
    // print("This is ${msg.text}");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Action on this message"),
        content: Text("You : ${msg.text}"),
        actions: <Widget>[
          TextButton(
            onPressed: () => setState(
              () {
                messages_List.remove(msg);
                saveData();
                Navigator.pop(context);
              },
            ),
            child: Text("Delete"),
          ),
          TextButton(
            onPressed: () => {speak(msg.text)},
            child: Text("Speak"),
          ),
          TextButton(
            onPressed: () => {
              Navigator.pop(context),
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversation '),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 50,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            gradient: LinearGradient(colors: const [
              Color.fromARGB(255, 30, 53, 108),
              Color.fromARGB(255, 65, 130, 131),
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GroupedListView<Message, DateTime>(
              padding: EdgeInsets.all(8),
              reverse: true,
              order: GroupedListOrder.DESC,
              useStickyGroupSeparators: true,
              floatingHeader: true,
              elements: messages_List,
              groupBy: (message) => DateTime(
                message.date.year,
                message.date.month,
                message.date.day,
              ),
              groupHeaderBuilder: (Message message) => SizedBox(
                height: 40,
                child: Center(
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        DateFormat.yMMMd().format(message.date),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),

              //message chat part
              itemBuilder: (context, Message message) {
                debugPrint('through builder');
                return Align(
                  alignment: message.isSentByMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(2),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.6),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.shade100,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          message.text,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    onTap: () => {
                      //  intindex = messages.where(message),
                      showInfodialog(context, message),
                    },
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 0, 0, 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: SafeArea(
              bottom: true,
              top: false,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            width: 2,
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Icon(
                          Icons.message,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, bottom: 5, top: 5),
                      child: TextField(
                        controller: messageController,
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
                          hintText: 'Type something...',
                          border: InputBorder.none,
                        ),
                        onSubmitted: (text) {
                          final message = Message(text, DateTime.now(), true);
                          setState(
                            () {
                              messages_List.add(message);
                              messageController.clear();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 5.0,
                      bottom: 5,
                      top: 5,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.3),
                            spreadRadius: 8,
                            blurRadius: 24,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Material(
                          color: Colors.orange,
                          child: InkWell(
                            splashColor: Colors.white,
                            onTap: () {
                              final message_tile = Message(
                                  messageController.text, DateTime.now(), true);
                              debugPrint('this is $message_tile');
                              // final json = message.toJson();
                              // messages_List.add(message_tile);

                              // List<String> stringList = messages_List
                              //     .map((message_til) =>
                              //         json.encode(message_til.toMap()))
                              //     .toList();
                              // debugPrint('this is json = $stringList');
                              // sharedPreferences!
                              //     .setStringList('message', stringList);
                              messages_List.add(message_tile);
                              saveData();
                              setState(
                                () {
                                  // messages_List.add(message_tile);

                                  messageController.clear();
                                },
                              );
                            },
                            child: SizedBox(
                              width: 54,
                              height: 54,
                              child: Icon(
                                Icons.send_rounded,
                                size: 26,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void loadData() {
    List<String>? listString = sharedPreferences!.getStringList('message');
    if (listString != null) {
      debugPrint('this is load data');
      messages_List = listString
          .map(
            (item) => Message.fromMap(
              json.decode(item),
            ),
          )
          .toList();
      if (messages_List.isEmpty ) {
          messages_List = [Message(
      'Sometimes it is better to type',
      DateTime.now().subtract(
        Duration(minutes: 1),
      ),
      true),
  Message(
      'Here you go !!',
      DateTime.now().subtract(
        Duration(minutes: 1),
      ),
      true)
  ];
        debugPrint("What a Simp bro!!S");
      }
      debugPrint('$messages_List');
      setState(() {});
    }
  }

  void saveData() {
    List<String> stringList = messages_List
        .map((message_til) => json.encode(message_til.toMap()))
        .toList();
    debugPrint('this is json = $stringList');
    sharedPreferences!.setStringList('message', stringList);
  }
}
