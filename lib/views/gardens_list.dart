import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartgarden_app/components/custom_app_bar.dart';
import 'package:smartgarden_app/widget/locations_widget.dart';

import '../components/background_image.dart';
import '../controllers/api/my_api.dart';
import '../models/thing.dart';

class GardensList extends StatefulWidget {
  @override
  State<GardensList> createState() => _GardensListState();
}

class _GardensListState extends State<GardensList> {
  String token = '';
  late Map<String, String> header;

  List<Thing> data = [];
  late Timer timer;
  String selectedImagePath = '';
  String? user;

  @override
  void initState() {
    // TODO: implement initState
    data.clear();
    getData().then((value) {
      setState(() {
        data.addAll(value!);
      });
    });
    _getUser();
    // timer = Timer.periodic(const Duration(seconds: 10), (Timer t) => print('object'));
    super.initState();
  }

  refresh() {
    setState(() {});
  }

  _getUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      user = localStorage.getString("user");
    });
  }

  Future<List<Thing>?> getData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token')!;
    header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Charset': 'utf-8',
      'token': token,
    };
    var res = await CallApi().getDataHeader('getThings', header);
    var body = json.decode(res.body);
    // print(body);
    if (body['success']) {
      var thing = body['data'] as List<dynamic>;

      var data = thing.map((e) => Thing.fromJson(e)).toList();
      return data;
    } else {
      return null;
      print(body['message']);
    }
  }

  void _showDialog() async {
    user ??= '{"id":0,"username":"N/A","displayname":"N/A","phone":"N/A","avatar":null,"updated_at":"N/A"}';
    final userData = jsonDecode(user!);
    int idUser = userData['id'];
    TextEditingController _changeNameTextController = TextEditingController();
    TextEditingController _changeDescTextController = TextEditingController();
    await showDialog(
        // useSafeArea: false,
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          String selectedImg = selectedImagePath;

          return StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
              child: AlertDialog(
                title: const Text("Add a garden",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        fontFamily: "Muli-BoldItalic")),
                contentPadding: const EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                content: Builder(builder: (context) {
                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  var height = MediaQuery.of(context).size.height;
                  // var width = MediaQuery.of(context).size.width;
                  return Container(
                    height: height - 370,
                    // width: width - 400,
                    child: Column(
                      children: [
                        TextField(
                          autofocus: true,
                          decoration: const InputDecoration(
                            iconColor: Colors.green,
                            labelText: 'Type your garden name',
                            floatingLabelStyle: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            fillColor: Colors.green,
                            focusColor: Colors.green,
                            hintText: 'Ex: New Garden',
                          ),
                          controller: _changeNameTextController,
                        ),
                        TextField(
                          autofocus: true,
                          decoration: const InputDecoration(
                            iconColor: Colors.green,
                            labelText: 'Some descriptions',
                            floatingLabelStyle: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            fillColor: Colors.green,
                            focusColor: Colors.green,
                            hintText: 'Ex: It is a pretty garden!',
                          ),
                          controller: _changeDescTextController,
                        ),
                        const SizedBox(height: 8),
                        selectedImagePath == ''
                            ? Image.asset(
                                'assets/images/image_placeholder.png',
                                height: 200,
                                width: 200,
                                fit: BoxFit.fill,
                              )
                            : Image.file(
                                File(selectedImagePath),
                                height: 200,
                                width: 200,
                                fit: BoxFit.fill,
                              ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(18)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(
                                        fontSize: 14, color: Colors.white))),
                            onPressed: () async {
                              await selectImage();

                              setState(() {
                                selectedImg = selectedImagePath;
                              });
                            },
                            child: const Text(
                              'Select Image',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                            )),
                        // const SizedBox(height: 5),
                      ],
                    ),
                  );
                }),
                actions: <Widget>[
                  TextButton(
                      child: const Text('CANCEL',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  TextButton(
                      child: const Text('SUBMIT',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                      onPressed: () async {
                        var data = {
                          'name': _changeNameTextController.text,
                          'description': _changeDescTextController.text,
                          'id_user': idUser,
                          'id_location': 1,
                          // 'avt_image': File(selectedImagePath),
                          'token': token
                        };

                        var res = await CallApi().postData(data, 'post/things');
                        var body = json.decode(res.body);
                        print(body);
                        // if (body['success']) {
                        //   print("Added a garden!");
                        // } else {
                        //   print("Something were wrong!");
                        // }
                        Navigator.pop(context);
                        setState(() {
                          initState();
                        });
                      })
                ],
              ),
            );
          });
        });
  }

  Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Text(
                      'Select Image From',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromGallery();
                            print('Image_Path:-');
                            print(selectedImagePath);
                            if (selectedImagePath != '') {
                              setState(() {
                                selectedImagePath;
                                refresh();
                              });
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("No Image Selected!"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/gallery.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    const Text('Gallery'),
                                  ],
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromCamera();
                            print('Image_Path:-');
                            print(selectedImagePath);

                            if (selectedImagePath != '') {
                              setState(() {});
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("No Image Captured!"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/camera.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    const Text('Camera'),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  //
  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        // extendBodyBehindAppBar: true,
        // backgroundColor: Colors.blueGrey,
        appBar: const CustomAppBar(title: 'YOUR GARDEN'),
        body: Stack(
          children: [
            const BackgroundImage(
              image: 'assets/images/bg-garden.jpg',
            ),
            ThingsWidget(thing: data),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            selectedImagePath = '';
            _showDialog();
          },
        ),
        // bottomNavigationBar: buildBottomNavigation(),
      );

  Widget buildBottomNavigation() => BottomNavigationBar(
        elevation: 0,
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pin_drop_outlined),
            label: 'Add one',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location),
            label: '',
          ),
        ],
      );
}
