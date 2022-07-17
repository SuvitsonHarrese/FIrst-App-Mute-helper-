// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:mute_help/ad/ad_service.dart';
import 'package:mute_help/data_for_menu/menu_items.dart';
import 'package:mute_help/events/delete_info.dart';
import 'package:mute_help/bloc/travel_bloc.dart';
import 'package:mute_help/model/travel_info.dart';
import 'package:mute_help/events/set_info.dart';
import 'package:mute_help/db/travel_db_provider.dart';
import 'package:mute_help/form/travel_form.dart';
import 'package:mute_help/model_menu/menu_item.dart';

class BusList extends StatefulWidget {
  const BusList({Key? key}) : super(key: key);

  @override
  State<BusList> createState() => _BusListState();
}

class _BusListState extends State<BusList> {
  List<String> tlst = [
    "Bus Start :",
    "Bus Stop  :",
    "Starting Station",
    "Destination Station"
  ];
  TravelInfo? passInfo;
  bool itsLoading = false;
  // final banner_bus = GetIt.instance.get<AdService>().getBannerAd();

  @override
  void initState() {
    // print("I am in travel list initState");
    super.initState();
    TravelDB.db.getInfo().then((travelinfoList) {
      BlocProvider.of<TravelInfoBloc>(context)
          .add(SettravelInfos(travelinfoList));
    });
  }

  @override
  Widget build(BuildContext context) {
    PopupMenuItem<Menu_Item> buildItem(Menu_Item item) => PopupMenuItem(
          //padding: EdgeInsets.all(5),
          value: item,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Icon(item.icon, color: Colors.blue, size: 30),
              ),
              // Icon(item.icon, color: Colors.blue, size: 20),
              Text(item.text),
            ],
          ),
        );
    void onSelected(BuildContext context, Menu_Item item) {
      switch (item) {
        case FormMenuItems.itemUpdate:
          int passIndex = 0;
          // print("Am deleting");
          //print("This is passIndex ${passIndex} and passInfo ${passInfo?.id}");
          TravelDB.db.delete(passInfo?.id).then(
            (_) {
              BlocProvider.of<TravelInfoBloc>(context)
                  .add(DeletetravelInfo(passIndex));
            },
          );
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TravelForm(),
            ),
          );
          break;
      }
    }

    return Scaffold(
      // backgroundColor: Colors.blue,
      extendBodyBehindAppBar: true,
      
      appBar: AppBar(
        title: Text("Travel Info"),
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
        actions: [
          PopupMenuButton<Menu_Item>(
            // padding: EdgeInsets.all(20),

            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              ...FormMenuItems.itemsFirst.map(buildItem).toList(),
            ],
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(0),
        child: BlocConsumer<TravelInfoBloc, List<TravelInfo>>(
          builder: (context, travelinfoList) {
            return travelinfoList.isEmpty
                ? Stack(children: [
                    Image.asset(
                      'images/buses.jpg',
                      width: 420,
                      height: 820,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(32),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 24),
                          minimumSize: Size.fromHeight(72),
                          shape: StadiumBorder(),
                          primary: Color.fromARGB(255, 23, 60, 147),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TravelForm(),
                            ),
                          );
                        },
                        child: Text(
                          "Fill Travel Information Form",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff69DADB),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(bottom: 100),
                    //   alignment: Alignment.bottomCenter,
                    //   width: double.infinity,
                    //   height: banner_bus.size.height.toDouble(),
                    //   // padding: EdgeInsets.only(top: 650),
                    //   child: AdWidget(ad: banner_bus),
                    // ),
                  ])
                : ListView.separated(
                    itemCount: 2,
                    // itemCount:infoList.length,
                    itemBuilder: (context, index) {
                      TravelInfo travelinfo = travelinfoList[0];
                      passInfo = travelinfo;
                      if (travelinfo.TrainArrival == '') {
                        // print("Yes its Empty");
                      }
                      //print("This is passIndex ${passIndex} and passInfo ${passInfo}");
                      List<String> ptr = [
                        '${travelinfo.BusArrival}',
                        '${travelinfo.BusDepart}',
                      ];
                      return Card(
                        child: ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              tlst[index],
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          contentPadding: EdgeInsets.all(10),
                          title: Text(
                            ptr[index],
                            style: TextStyle(
                                fontSize: 29, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Center(
                        // child: DottedLine(
                        //   direction: Axis.vertical,
                        //   lineLength: 180,
                        //   dashRadius: 10,
                        //   lineThickness: 8,
                        //   dashLength: 20,
                        // ),
                        child: Container(
                          color: Colors.white,
                          width: 400,
                          height: 300,
                          child: CustomPaint(
                            foregroundPainter: LinePainter(),
                          ),
                        ),
                      );
                    },
                  );
          },
          listener: (BuildContext context, infoList) {},
        ),
      ),
      // bottomNavigationBar: Container(
      //   margin: EdgeInsets.only(bottom: 100),
      //   alignment: Alignment.bottomCenter,
      //   width: double.infinity,
      //   height: banner_bus.size.height.toDouble(),
      //   // padding: EdgeInsets.only(top: 650),
      //   child: AdWidget(ad: banner_bus),
      // ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 07;
    canvas.drawLine(Offset(200, 0), Offset(200, 20), paint);
    canvas.drawLine(Offset(200, 40), Offset(200, 60), paint);
    canvas.drawLine(Offset(200, 80), Offset(200, 100), paint);
    canvas.drawLine(Offset(200, 120), Offset(200, 140), paint);
    canvas.drawLine(Offset(200, 160), Offset(200, 180), paint);
    canvas.drawLine(Offset(200, 200), Offset(200, 220), paint);
    canvas.drawLine(Offset(200, 240), Offset(200, 260), paint);
    canvas.drawLine(Offset(200, 280), Offset(200, 300), paint);

    //arrow part
    //arrow down
    canvas.drawLine(Offset(200, 300), Offset(190, 290), paint);
    canvas.drawLine(Offset(200, 300), Offset(210, 290), paint);

    //circle part
    canvas.drawCircle(Offset(200, 6), 12, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
