import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mute_help/model/info.dart';
import 'package:mute_help/bloc/info_bloc.dart';
import 'package:mute_help/list/info_list.dart';
import 'package:mute_help/events/add_info.dart';
import 'package:mute_help/events/update_info.dart';
import 'package:mute_help/db/database_provider.dart';

// ignore: must_be_immutable
class FormScreen extends StatefulWidget {
  //FormScreen({Key? key, this.info, this.infoIndex}) : super(key: key);
  Info? info;
  int? infoIndex;

  FormScreen({this.info, this.infoIndex});
  @override
  State<FormScreen> createState() {
    return _FormScreenState();
  }
}

class _FormScreenState extends State<FormScreen> {
  String? _name;
  String? _email;
  String? _dob;
  String? _phoneNo;
  String? _address;
  String? _qualification;

  bool isLoadingring = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final dobController = TextEditingController();
  final qualificationController = TextEditingController();
  final busArrivalController = TextEditingController();
  final busDepartController = TextEditingController();
  final trainArrivalController = TextEditingController();
  final trainDepartController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      maxLength: 30,
      controller: nameController,
      decoration: InputDecoration(
        labelText: 'Name',
        prefixIcon: Icon(Icons.person),
        suffixIcon: nameController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                onPressed: () {
                  nameController.clear();
                },
                icon: Icon(Icons.close),
              ),
        border: OutlineInputBorder(),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Name is required';
        }
        return null; //
      },
      onSaved: (String? value) {
        _name = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        labelText: 'E-mail',
        hintText: 'abc@gmail.com',
        prefixIcon: Icon(Icons.mail),
        suffixIcon: emailController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                onPressed: () {
                  emailController.clear();
                },
                icon: Icon(Icons.close),
              ),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Name is required';
        }
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      onSaved: (String? value) {
        _email = value;
      },
    );
  }

  Widget _buildDob() {
    return TextFormField(
      controller: dobController,
      decoration: InputDecoration(
        hintText: 'DD-MM-YYYY or DD/MM/YYYY',
        labelText: 'DOB',
        prefixIcon: Icon(Icons.cake),
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () {
            final initialDate = DateTime.now();
            showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: DateTime(1900),
              lastDate: DateTime(DateTime.now().year + 1),
            ).then(
              (date) => {
                setState(() {
                  if (date == null) {
                    dobController.text =
                        '${date!.day}/${date.month}/${date.year}';
                  } else {
                    dobController.text =
                        '${date.day}/${date.month}/${date.year}';
                  }
                })
              },
            );
          }, //=> pickDate(context),
        ),
        border: OutlineInputBorder(),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'DOB is required';
        }
        return null;
      },
      onSaved: (String? value) {
        _dob = value;
      },
    );
  }

  Widget _buildphoneNo() {
    return TextFormField(
      controller: phoneController,
      decoration: InputDecoration(
        labelText: 'Phone No.',
        prefixIcon: Icon(Icons.phone),
        suffixIcon: phoneController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                onPressed: () {
                  phoneController.clear();
                },
                icon: Icon(Icons.close),
              ),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      maxLength: 10,
      validator: (String? value) {
        if (value!.isEmpty ) {
          debugPrint('this is len ${value.length}');
          return 'Phone Number is required';
        }
        if(value.length != 10){
          return 'Invalid Phone Number';
        }
        return null;
      },
      onSaved: (String? value) {
        _phoneNo = value;
      },
    );
  }

  Widget _buildAddress() {
    return TextFormField(
      // scrollController: ,
      maxLines: 4,
      keyboardType: TextInputType.streetAddress,
      controller: addressController,
      decoration: InputDecoration(
        labelText: 'Address',
        prefixIcon: Icon(
          Icons.location_on,
        ),
        suffixIcon: addressController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                onPressed: () {
                  addressController.clear();
                },
                icon: Icon(Icons.close),
              ),
        border: OutlineInputBorder(),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Address is required';
        }
        return null;
      },
      onSaved: (String? value) {
        _address = value;
      },
    );
  }

  Widget _buildqualification() {
    return TextFormField(
      controller: qualificationController,
      decoration: InputDecoration(
        labelText: 'Education',
        prefixIcon: Icon(Icons.school),
        suffixIcon: qualificationController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                onPressed: () {
                  qualificationController.clear();
                },
                icon: Icon(Icons.close),
              ),
        border: OutlineInputBorder(),
      ),
      onSaved: (String? value) {
        _qualification = value;
      },
    );
  }

  @override
  void initState() {
    super.initState();

    if (widget.info != null) {
      _name = widget.info?.name;
      _email = widget.info?.email;
      _dob = widget.info?.dob;
      _phoneNo = widget.info?.phoneNo;
      _address = widget.info?.address;
    }
    nameController.addListener(() {
      setState(() {});
    });
    emailController.addListener(() {
      setState(() {});
    });
    phoneController.addListener(() {
      setState(() {});
    });
    addressController.addListener(() {
      setState(() {});
    });
    dobController.addListener(() {
      setState(() {});
    });
    qualificationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Demo"),
      ),
      body: KeyboardDismisser(
        gestures: const [
          GestureType.onVerticalDragDown,
        ],
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24, 10, 24, 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 0),
                  child: Text(
                    "Personal Information:",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    textAlign: TextAlign.right,
                  ),
                ),
                _buildName(),
                _buildDob(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 0),
                  child: Text(
                    "Contact Information:",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(height: 16),
                _buildEmail(),
                SizedBox(height: 16),
                _buildphoneNo(),
                //SizedBox(height: 16),
                _buildAddress(),
                SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 0),
                  child: Text(
                    "Education:",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    textAlign: TextAlign.right,
                  ),
                ),
                _buildqualification(),
                SizedBox(height: 100),
                widget.info == null
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 22),
                          minimumSize: Size.fromHeight(60),
                          shape: StadiumBorder(),
                        ),
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          _formKey.currentState!.save();
                          Info info = Info(
                            name: _name,
                            email: _email,
                            dob: _dob,
                            phoneNo: _phoneNo,
                            address: _address,
                            qualification: _qualification,
                          );

                          if (isLoadingring) return;
                          setState(
                            () {
                              isLoadingring = true;
                            },
                          );
                          await Future.delayed(Duration(seconds: 1));
                          setState(
                            () {
                              isLoadingring = false;
                            },
                          );

                          DatabaseProvider.db.insert(info).then(
                                (storedInfo) =>
                                    BlocProvider.of<InfoBloc>(context).add(
                                  AddInfo(info),
                                ),
                              );
                              //
                          if (!mounted) return;
                          // print("I am in formState");
                          Navigator.pop(context);
                        },
                        child: isLoadingring
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Submit',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              _formKey.currentState!.save();
                              Info info = Info(
                                  name: _name,
                                  email: _email,
                                  dob: _dob,
                                  phoneNo: _phoneNo,
                                  address: _address);
                              DatabaseProvider.db.update(widget.info).then(
                                    (storedInfo) =>
                                        BlocProvider.of<InfoBloc>(context).add(
                                      UpdateInfo(widget.infoIndex, info),
                                    ),
                                  );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InfoList(),
                                ),
                              );
                            },
                            child: Text(
                              "Update",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          ElevatedButton(
                            child: Text(
                              "Cancel",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => InfoList(),
                              ),
                            ),
                            // onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
