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
  String ref = '';
  String name = '';
  String fileNameR = '';
  bool isFileLoaded = false;
  bool isFLoata = false;

  @override
  void initState() {
    super.initState();
  }

  Future<String> futureProvider() async {
    final provider = Provider.of<Data>(context, listen: false);
    materials = await provider.getMaterialBySuject(
        {"role": "staff", "subjectName": widget.subjectName});
    return 'completed';
  }

  Widget futureBuild() {
    return new FutureBuilder(
        future: futureProvider(),
        builder: (context, snapshot) {
          if (snapshot.data == 'completed')
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.8,
                childAspectRatio: 3 / 3,
                crossAxisSpacing: 15,
                mainAxisSpacing: 20,
              ),
              itemCount: materials.length,
              itemBuilder: (BuildContext context, int index) {
                final fileDetails = materials[index];
                print(fileDetails);
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
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DisplayPDF(
                                    url: fileDetails['materialLink'],
                                    name: fileDetails['materialName']),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 90.0),
                                child: Text(
                                  fileDetails['materialName'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                height: 65,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 60.0),
                                child: Text(
                                  'Created by: ARJUN',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
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
            );

          return Center(
            child: Center(
              child: Container(
                color: Colors.amber,
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
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      child: LoadingIndicator(
                          indicatorType: Indicator.ballPulseSync,
                          colors: const [Colors.black],
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
        body: LoadingOverlay(
            color: Colors.lightBlue,
            progressIndicator: uploadLoading
                ? Stack(
                    children: [
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.only(top: 100.0, left: 30.0),
                                height:
                                    MediaQuery.of(context).size.height * 0.19,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Text(
                                  'are you to sure to upload the file'
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.025,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.04),
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                width: MediaQuery.of(context).size.width * 0.6,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.0)),
                                  border: Border.all(
                                      color: Colors.black, width: 4.0),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.file_present),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Container(
                                      child: Text(
                                        '$fileName'.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
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
                              ElevatedButton(
                                child: Text(
                                  'YEs'.toUpperCase(),
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  side: BorderSide(
                                    width: 3.0,
                                    color: Colors.black,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 60.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                ),
                                onPressed: uploadFile,
                              ),
                              SizedBox(
                                height: 25.0,
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
                                      color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                  side: BorderSide(
                                    width: 3.0,
                                    color: Colors.black,
                                  ),
                                  primary: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 60.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0))),
                        ),
                      ),
                    ],
                  )
                : successFul
                    ? Stack(
                        children: [
                          Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
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
                                              'File is successfully uploaded,thank you'
                                                  .toUpperCase(),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.0))),
                            ),
                          ),
                        ],
                      )
                    : Stack(
                        children: [
                          Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
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
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.0))),
                            ),
                          ),
                        ],
                      ),
            isLoading: uploadScreen,
            child: Stack(
              children: [
                futureBuild(),
              ],
            )),
        floatingActionButton: Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(30.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.cyan,
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
        ),
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
    await provider.addMaterialBySuject({
      "materialName": fileName,
      "subjectName": widget.subjectName,
      "materialLink": urlDownload,
      "uploadedBy": "Bala"
    });

    setState(() => {successFul = true});
    print('   $successFul');
    await Future.delayed(Duration(milliseconds: 2200));
    setState(() => {successFul = false, uploadScreen = false});
    futureProvider();
    setState(() {
      uploadLoading = true;
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