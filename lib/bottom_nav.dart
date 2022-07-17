import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mute_help/list/info_list.dart';
import 'package:mute_help/list/bus_list.dart';
import 'package:mute_help/list/train_list.dart';
import 'package:mute_help/message_ui.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;
  final screens = [InfoList(), BusList(), TrainList(), MessageUI()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(
            color:Color(0xff69DADB),
          ),
        ),
        child: CurvedNavigationBar(
          index: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          height: 60,
          color: Color.fromARGB(255, 30, 53, 108),
          buttonBackgroundColor: Color.fromARGB(255, 30, 53, 108),
          backgroundColor: Color.fromARGB(255, 106, 127, 177),
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          items: const <Widget>[
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.person),
            //   label: 'Personal',
            //   backgroundColor: Colors.blue,
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.travel_explore),
            //   label: 'Bus',
            //   backgroundColor: Colors.blue,
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.train),
            //   label: 'Train',
            //   backgroundColor: Colors.blue,
            // ),
            Icon(Icons.person, size: 30),
            Icon(Icons.travel_explore, size: 30),
            Icon(Icons.train, size: 30),
            Icon(Icons.message, size: 30),
          ],
        ),
      ),
    );
  }
}
