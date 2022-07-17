// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mute_help/bloc/travel_bloc.dart';
import 'package:mute_help/model/travel_info.dart';
import 'package:mute_help/events/add_info.dart';
import 'package:mute_help/db/travel_db_provider.dart';

class TravelForm extends StatefulWidget {
  // const TravelForm({Key? key}) : super(key: key);

  @override
  State<TravelForm> createState() => _TravelFormState();
}

class _TravelFormState extends State<TravelForm> {
  String? _busarrival;
  String? _busdepart;
  String? _trainarrival;
  String? _traindepart;
  final tripType = ['Single', 'Return'];
  String? value;
  bool isLoading = false;
  final busArrivalController = TextEditingController();
  final busDepartController = TextEditingController();
  final trainArrivalController = TextEditingController();
  final trainDepartController = TextEditingController();

  final GlobalKey<FormState> _TravelFormKey = GlobalKey<FormState>();
  Widget _busArrival() {
    return TextFormField(
      controller: busArrivalController,
      decoration: InputDecoration(
        labelText: 'Bus Arrival',
        prefixIcon: Icon(Icons.start),
        suffixIcon: busArrivalController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                onPressed: () {
                  busArrivalController.clear();
                },
                icon: Icon(Icons.close),
              ),
        border: OutlineInputBorder(),
      ),
      onSaved: (String? value) {
        _busarrival = value;
      },
    );
  }

  Widget _busDepart() {
    return TextFormField(
      controller: busDepartController,
      decoration: InputDecoration(
        labelText: 'Bus Depart',
        prefixIcon: Icon(Icons.stop_rounded),
        suffixIcon: busDepartController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                onPressed: () {
                  busDepartController.clear();
                },
                icon: Icon(Icons.close),
              ),
        border: OutlineInputBorder(),
      ),
      onSaved: (String? value) {
        _busdepart = value;
      },
    );
  }

  Widget _trainArrival() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: trainArrivalController,
      decoration: InputDecoration(
        labelText: 'Train Arrival',
        prefixIcon: Icon(Icons.train),
        suffixIcon: trainArrivalController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                onPressed: () {
                  trainArrivalController.clear();
                },
                icon: Icon(Icons.close),
              ),
        border: OutlineInputBorder(),
      ),
      onSaved: (String? value) {
        _trainarrival = value;
      },
    );
  }

  Widget _trainDepart() {
    return TextFormField(
      controller: trainDepartController,
      decoration: InputDecoration(
        labelText: 'Train Depart',
        prefixIcon: Icon(Icons.train),
        suffixIcon: trainDepartController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                onPressed: () {
                  trainDepartController.clear();
                },
                icon: Icon(Icons.close),
              ),
        border: OutlineInputBorder(),
      ),
      onSaved: (String? value) {
        _traindepart = value;
      },
    );
  }

  DropdownMenuItem<String> buildMenuItem(String type) => DropdownMenuItem(
        value: type,
        child: Text(
          type,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
  Widget _buildtripType(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: tripType.map(buildMenuItem).toList(),
          onChanged: (value) => setState(
            () => {
              this.value = value,
              // print('This is the value $value'),
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // if (widget.info != null) {
    //   _name = widget.info?.name;
    //   _email = widget.info?.email;
    //   _dob = widget.info?.dob;
    //   _phoneNo = widget.info?.phoneNo;
    //   _address = widget.info?.address;
    // }
    busArrivalController.addListener(() {
      setState(() {});
    });
    busDepartController.addListener(() {
      setState(() {});
    });
    trainArrivalController.addListener(() {
      setState(() {});
    });
    trainDepartController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // PopupMenuItem<Menu_Item> buildItem(Menu_Item item) => PopupMenuItem(
    //       //padding: EdgeInsets.all(5),
    //       value: item,
    //       child: Row(
    //         children: [
    //           Padding(
    //             padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
    //             child: Icon(item.icon, color: Colors.blue, size: 30),
    //           ),
    //           // Icon(item.icon, color: Colors.blue, size: 20),
    //           Text(item.text),
    //         ],
    //       ),
    //     );
    // void onSelected(BuildContext context, Menu_Item item) {
    //   switch (item) {
    //     case MenuItems.itemShare:
    //       Navigator.pop(context);
    //       break;
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Form"),
        centerTitle: true,
      ),
      body: KeyboardDismisser(
        gestures: const [GestureType.onVerticalDragDown, GestureType.onTap],
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24, 10, 24, 24),
          child: Form(
            key: _TravelFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 0),
                  child: Text(
                    "Bus Travel Information",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    textAlign: TextAlign.right,
                  ),
                ),
                _busArrival(),
                SizedBox(height: 16),
                _busDepart(),
                SizedBox(height: 16),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 0),
                  child: Text(
                    "Train Travel Information",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                _trainArrival(),
                SizedBox(height: 16),
                _trainDepart(),
                SizedBox(height: 16),
                _buildtripType(context),
                SizedBox(height: 100),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 22),
                    minimumSize: Size.fromHeight(60),
                    shape: StadiumBorder(),
                  ),
                  onPressed: () async {
                    if (!_TravelFormKey.currentState!.validate()) {
                      return;
                    }
                    _TravelFormKey.currentState!.save();
                    // BlocProvider.of<InfoBloc>(context).add(InfoEvent.add(Info(_name)));
                    TravelInfo info = TravelInfo(
                      BusArrival: _busarrival,
                      BusDepart: _busdepart,
                      TrainArrival: _trainarrival,
                      TrainDepart: _traindepart,
                      TripType: value,
                    );
                    if (isLoading) return;
                    setState(
                      () {
                        isLoading = true;
                      },
                    );
                    await Future.delayed(Duration(seconds: 1));
                    setState(
                      () {
                        isLoading = false;
                      },
                    );
                    TravelDB.db.insert(info).then(
                          (storedInfo) =>
                              BlocProvider.of<TravelInfoBloc>(context).add(
                            AddtravelInfo(info),
                          ),
                        );
                    //
                    if (!mounted) return;
                    // print("I am in travel formState");
                    Navigator.pop(context);
                  },
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
