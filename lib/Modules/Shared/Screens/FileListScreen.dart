import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:async';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_app/Modules/Shared/Screens/DisplayPDF.dart';
import 'package:sp_app/Provider/Data.dart';
import 'DisplayPDF.dart';

class DisplayFile extends StatefulWidget {
  String subjectName;
  DisplayFile(this.subjectName);
  @override
  _DisplayFileState createState() => _DisplayFileState();
}

class _DisplayFileState extends State<DisplayFile> {
  late Future<List<FirebaseFile>> futureFiles;
  UploadTask? task;
  var materials = [];
  File? file;
  bool uploadScreen = false;
  bool uploadLoading = false;
  bool successFul = false;
  bool isStaff = false;
  String ref = '';
  String name = '';
  String fileNameR = '';
  bool isFileLoaded = false;
  bool isReviewed = false;

  @override
  void initState() {
    super.initState();
    getRole();
  }

  Future<void> getRole() async {
    final SharedPreferences sharedpref = await SharedPreferences.getInstance();
    isStaff = sharedpref.getString('role') == 'staff';
  }

  Future<String> futureProvider() async {
    final provider = Provider.of<Data>(context, listen: false);
    final SharedPreferences sharedpref = await SharedPreferences.getInstance();
    // isStaff = sharedpref.getString('role') == 'staff';
    materials = await provider.getMaterialBySuject(
        {"role": 'staff', "subjectName": widget.subjectName});
    print(materials);

    return 'completed';
  }

  Future<void> updateStatus(id, status) async {
    final provider = Provider.of<Data>(context, listen: false);
    print({"id": id, "status": status, "subjectName": widget.subjectName});
    var update = await provider.updateMaterialStatus(
        {"id": id, "status": status, "subjectName": widget.subjectName});

    print(update);
    futureProvider();
  }

  Widget futureBuild() {
    return new FutureBuilder(
        future: futureProvider(),
        builder: (context, snapshot) {
          if (snapshot.data == 'completed') {
            if (materials.length == 0)
              return Center(
                child: Text(
                  'No Materials Available',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              );
            else {
              return AnimationLimiter(
                child: Column(
                  children: [
                    if (isStaff)
                      Container(
                        height: 60,
                        margin: EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: ToggleButtons(
                              borderRadius: BorderRadius.circular(10),
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: Center(
                                    child: Text(
                                      "Published",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: Center(
                                    child: Text(
                                      "To be Reviewed",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              onPressed: (int index) {
                                setState(() {
                                  if (index == 0) {
                                    isReviewed = false;
                                  } else {
                                    isReviewed = true;
                                  }
                                });
                              },
                              color: Color(0xff6E7FFC),
                              selectedColor: Colors.white,
                              fillColor: Color(0xff6E7FFC),
                              isSelected: [!isReviewed, isReviewed],
                              borderColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    if (isReviewed)
                      materials.length > 0
                          ? Flexible(
                              child: ListView.builder(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                itemCount: materials.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final fileDetails = materials[index];
                                  print(fileDetails['accepted']);
                                  if ((fileDetails['accepted'] == true &&
                                      isReviewed)) return Material();

                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 500),
                                    child: SlideAnimation(
                                      verticalOffset: 10.0,
                                      child: FadeInAnimation(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DisplayPDF(
                                                        url: fileDetails[
                                                            'materialLink'],
                                                        name: fileDetails[
                                                            'materialName'],
                                                        from: 'url',
                                                        path: ''),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15.0,
                                                      horizontal: 8),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .3,
                                                    child: Image.network(
                                                      'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .55,
                                                        child: Text(
                                                          fileDetails[
                                                              'materialName'],
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                          maxLines: 2,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 6,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          'Uploaded by : ${fileDetails['uploadedBy']}',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              showDialog<
                                                                  String>(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    AlertDialog(
                                                                  title: const Text(
                                                                      'Are you sure to publish the material?'),
                                                                  actions: <
                                                                      Widget>[
                                                                    TextButton(
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.pop(context),
                                                                      child: const Text(
                                                                          'Cancel'),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        updateStatus(
                                                                            fileDetails['_id'],
                                                                            true);
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const Text(
                                                                          'OK'),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                            child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .23,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  'Accept',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              showDialog<
                                                                  String>(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    AlertDialog(
                                                                  title: const Text(
                                                                      'Are you sure to publish the material?'),
                                                                  actions: <
                                                                      Widget>[
                                                                    TextButton(
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.pop(context),
                                                                      child: const Text(
                                                                          'Cancel'),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        updateStatus(
                                                                            fileDetails['_id'],
                                                                            false);
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const Text(
                                                                          'OK'),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                            child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .23,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  'Reject',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: Text(
                                'No Materials Available',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                    if (!isReviewed)
                      materials.length > 0
                          ? Flexible(
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent:
                                      MediaQuery.of(context).size.width * 0.8,
                                  childAspectRatio: 3 / 3,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 20,
                                ),
                                itemCount: materials.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final fileDetails = materials[index];
                                  if ((fileDetails['accepted'] == false &&
                                      !isReviewed)) return Material();
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 500),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 20,
                                              primary: Colors.white,
                                              side: BorderSide(
                                                width: 1.5,
                                                color: Colors.black,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DisplayPDF(
                                                          url: fileDetails[
                                                              'materialLink'],
                                                          name: fileDetails[
                                                              'materialName'],
                                                          from: 'url',
                                                          path: ''),
                                                ),
                                              );
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: Text(
                                                      fileDetails[
                                                          'materialName'],
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 60.0),
                                                  child: Text(
                                                    'Uploaded by: ARJUN',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: Text(
                                'No Materials Available',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                  ],
                ),
              );
            }
          }

          return Center(
            child: Center(
              child: Container(
                color: Color(0xff6E7FFC),
                height: 130,
                width: 130,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Loading',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.025,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      child: LoadingIndicator(
                          indicatorType: Indicator.ballPulseSync,
                          colors: const [Colors.white],
                          strokeWidth: 0,
                          backgroundColor: Colors.transparent,
                          pathBackgroundColor: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final fileName =
        file != null ? Path.basename(file!.path) : 'No File Selected';
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff6E7FFC),
          title: Text(widget.subjectName),
        ),
        body: LoadingOverlay(
            color: Colors.black,
            progressIndicator: uploadLoading
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: Text(
                              'are you to sure to upload the file?'
                                  .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.025,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .13,
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.file_present),
                              SizedBox(
                                width: 10.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .4,
                                child: Text(
                                  '$fileName'.toUpperCase(),
                                  maxLines: 5,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              child: Text(
                                'Yes'.toUpperCase(),
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.02,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                padding: EdgeInsets.symmetric(
                                    vertical: 17.0, horizontal: 30.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                              onPressed: uploadFile,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() => uploadScreen = false);
                              },
                              child: Text(
                                'no'.toUpperCase(),
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                padding: EdgeInsets.symmetric(
                                    vertical: 17.0, horizontal: 30.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                  )
                : successFul
                    ? Stack(
                        children: [
                          Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 150,
                                            child: Lottie.asset(
                                                'assets/animation/1870-check-mark-done.json',
                                                repeat: false),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 30.0,
                                                horizontal: 0.0),
                                            child: Text(
                                              'File is successfully uploaded'
                                                  .toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 150,
                                            child: Lottie.asset(
                                              'assets/animation/60041-upload.json',
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 30.0,
                                                horizontal: 0.0),
                                            child: Text(
                                              'File is being uploaded',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                          ),
                        ],
                      ),
            isLoading: uploadScreen,
            child: Stack(
              children: [
                futureBuild(),
              ],
            )),
        floatingActionButton: !uploadScreen
            ? Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(30.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff6E7FFC),
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40.0),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if (!uploadScreen) {
                      await selectFile();
                    }
                  },
                  child: Icon(
                    Icons.add_box,
                    color: Colors.white,
                    size: 35.0,
                  ),
                ),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path =
        result.files.single.path!; // store it in the cache of file picker
    print("path  : $path");
    // setState(() => file = File(path));
    setState(() {
      file = File(path);
      uploadLoading = true;
      uploadScreen = true;
    });
  }

  Future uploadFile() async {
    if (file == null) return;
    final fileName = Path.basename(file!.path); // retrieve the file name
    final destination = 'files/$fileName';
    print("filename  : $fileName");
    setState(() => {uploadLoading = false});
    task = FirebaseApi.uploadFile(destination, file!);
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    final provider = Provider.of<Data>(context, listen: false);
    final SharedPreferences sharedpref = await SharedPreferences.getInstance();

    await provider.addMaterialBySuject({
      "materialName": fileName,
      "subjectName": widget.subjectName,
      "materialLink": urlDownload,
      "uploadedBy": sharedpref.getString('name')
    });

    setState(() => {successFul = true});
    print('   $successFul');
    await Future.delayed(Duration(milliseconds: 2200));
    setState(() => {successFul = false, uploadScreen = false});
    futureProvider();
    setState(() {
      uploadLoading = true;
      uploadScreen = false;
    });
    print('Download-Link: $urlDownload');
  }
}

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}

class FirebaseFile {
  final Reference ref;
  final String name;
  final String url;

  const FirebaseFile({
    required this.ref,
    required this.name,
    required this.url,
  });
}
