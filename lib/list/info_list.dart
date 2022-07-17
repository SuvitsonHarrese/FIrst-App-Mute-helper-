// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:mute_help/ad/ad_service.dart';
import 'package:mute_help/data_for_menu/menu_items.dart';
// import 'package:mute_help/events/update_info.dart';
import 'package:mute_help/events/delete_info.dart';
import 'package:mute_help/bloc/info_bloc.dart';
import 'package:mute_help/model/info.dart';
import 'package:mute_help/events/set_info.dart';
import 'package:mute_help/db/database_provider.dart';
import 'package:mute_help/form/form_screen.dart';
import 'package:mute_help/model_menu/menu_item.dart';

// import 'package:google_mobile_ads/google_mobile_ads.dart';

class InfoList extends StatefulWidget {
  const InfoList({Key? key}) : super(key: key);

  @override
  State<InfoList> createState() => _InfoListState();
}

class _InfoListState extends State<InfoList> {
  List<String> lst = [
    "Name",
    "E-mail",
    "Dob",
    "PhoneNo",
    "Address",
    "Education"
  ];
  // int currentIndex = 0;
  Info? passInfo;
  bool itsLoading = false;

  // final banner_info = GetIt.instance.get<AdService>().getBannerAd();
  // InterstitialAd? _interstitialAd;
  // BannerAd? _bannerAd;
  @override
  void dispose() {
    // banner_info.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // print("I am in initState");
    super.initState();
    DatabaseProvider.db.getInfo().then(
      (infoList) {
        BlocProvider.of<InfoBloc>(context).add(SetInfos(infoList));
      },
    );
    // loadInterstitial();
    // loadBannerAd();
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
          // print("This is passIndex $passIndex and passInfo ${passInfo?.id}");
          DatabaseProvider.db.delete(passInfo?.id).then(
            (_) {
              BlocProvider.of<InfoBloc>(context).add(DeleteInfo(passIndex));
            },
          );
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FormScreen(),
            ),
          );
          // _interstitialAd?.show();
          break;
      }
    }

    return Scaffold(
      // backgroundColor: Colors.blue,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        title: Text("It's Me"),
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
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(0),
            child: BlocConsumer<InfoBloc, List<Info>>(
              builder: (context, infoList) {
                return infoList.isEmpty
                    ? Stack(children: [
                        Image.asset(
                          'images/sign_languages.jpg',
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
                                  builder: (context) => FormScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Fill Personal Information Form",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff69DADB),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ])
                    : ListView.builder(
                        itemCount: 6,
                        // itemCount:infoList.length,
                        itemBuilder: (context, index) {
                          Info info = infoList[0];
                          passInfo = info;
                          //print("This is passIndex ${passIndex} and passInfo ${passInfo}");
                          List<String> ptr = [
                            '${info.name}',
                            '${info.email}',
                            '${info.dob}',
                            '${info.phoneNo}',
                            '${info.address}',
                            '${info.qualification}'
                          ];

                          return Card(
                            child: ListTile(
                              leading: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  lst[index],
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              contentPadding: EdgeInsets.all(10),
                              title: Text(
                                ptr[index],
                                style: TextStyle(fontSize: 26),
                              ),
                            ),
                          );
                        },
                      );
              },
              listener: (BuildContext context, infoList) {},
            ),
          ),
          // const SizedBox(height: 32),
          //   Container(
          //     alignment: Alignment.center,
          //     width: _bannerAd?.size.width.toDouble(),
          //     height: _bannerAd?.size.height.toDouble(),
          //     child: AdWidget(ad: _bannerAd!),
          //   )
          // Container(
          //   alignment: Alignment.bottomCenter,
          //   width: double.infinity,
          //   height: banner.size.height.toDouble(),
          //   // padding: EdgeInsets.only(top: 650),
          //   child: AdWidget(ad: banner),
          // )
        ],
      ),
      // bottomNavigationBar: Container(
      //   margin: EdgeInsets.only(bottom: 100),
      //   alignment: Alignment.bottomCenter,
      //   width: double.infinity,
      //   height: banner_info.size.height.toDouble(),
      //   // padding: EdgeInsets.only(top: 650),
      //   child: AdWidget(ad: banner_info),
      // ),
    );
  }
}
