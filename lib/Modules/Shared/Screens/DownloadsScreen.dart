import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'dart:io' show Platform;

import 'package:share/share.dart';
import 'package:sp_app/Modules/Shared/Screens/DisplayPDF.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';

class DownloadsScreen extends StatefulWidget {
  const DownloadsScreen({Key? key}) : super(key: key);

  @override
  _DownloadsScreenState createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  @override
  void initState() {
    loadfiles();
    pdfrender();
    super.initState();
  }

  void loadfiles() async {
    await listfiles();
  }

  // List<String> file = [
  //   '/storage/emulated/0/Android/data/com.example.project/files/COA.pdf',
  //   '/storage/emulated/0/Android/data/com.example.project/files/COA.pdf',
  //   '/storage/emulated/0/Android/data/com.example.project/files/COA.pdf',
  //   '/storage/emulated/0/Android/data/com.example.project/files/COA.pdf',
  //   '/storage/emulated/0/Android/data/com.example.project/files/COA.pdf'
  // ];
  List<FileSystemEntity> file_fetch = [];
  List<String> file_name = [];
  List<String> file_path = [];
  bool isloaded_pdf = false;
  Future listfiles() async {
    setState(() {
      file_fetch = Directory('/storage/emulated/0/Straw_Boss').listSync();
    });
    file_fetch.forEach((fileedit) {
      String extract = fileedit.toString().substring(
          fileedit.toString().indexOf('\u0027') + 1,
          fileedit.toString().lastIndexOf('\u0027'));
      file_path.add(extract);
    });
    file_fetch.forEach((fileedit) {
      String extract = fileedit.toString().substring(
          fileedit.toString().lastIndexOf('/') + 1,
          fileedit.toString().length - 1);
      file_name.add(extract);
    });
    print(file_path);
    setState(() {});
  }

  List<PdfPageImage?> pageimage = [];
  PdfPageImage? pageImage;
  void pdfrender() async {
    for (int i = 0; i < (file_path.length); i++) {
      final document = await PdfDocument.openFile((file_path[i]));
      final page = await document.getPage(1);
      pageImage = await page.render(
          backgroundColor: '#ffffff',
          width: (page.width * 0.5).toInt(),
          height: (page.height * 0.5).toInt());
      await page.close();
      pageimage.add(pageImage);
    }
    setState(() {});
  }

  Widget futurebuilder() {
    return FutureBuilder(builder: (context, snapshot) {
      return ListView.builder(
          itemCount: file_path.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                setState(
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayPDF(
                        url: 'asasas',
                        path: file_path[index],
                        name: file_name[index],
                        from: 'downloads',
                      ),
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 1,
                margin: EdgeInsets.all(0.7),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.height * 1,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  margin: EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(
                                top: 10,
                                bottom: 10.0,
                                left: MediaQuery.of(context).size.height * 0.03,
                              ),
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.height * 0.2,
                              child: (pageimage.length != 0)
                                  ? Stack(
                                      children: [
                                        // SfPdfViewer.file(
                                        //   File(file_path[index]),
                                        //   initialZoomLevel: 0.05,
                                        //   canShowScrollHead: false,
                                        //   enableDoubleTapZooming: false,
                                        //   enableTextSelection: false,
                                        //   enableDocumentLinkAnnotation: false,
                                        //   canShowPaginationDialog: false,
                                        //   interactionMode: PdfInteractionMode.pan,
                                        //   onDocumentLoaded: (PdfDocumentLoadedDetails
                                        //       details) async {
                                        //     setState(() => isloaded_pdf = true);
                                        //   },
                                        //   onDocumentLoadFailed: (PdfDocumentLoadFailedDetails)async{
                                        //       setState(() => isloaded_pdf = true);
                                        //   },
                                        // ),
                                        Image(
                                          image: MemoryImage(
                                              pageimage[index]!.bytes),
                                        ),
                                      ],
                                    )
                                  : Container()),
                          Container(
                              padding: EdgeInsets.only(
                                top: 10,
                                bottom: 10.0,
                                left: MediaQuery.of(context).size.height * 0.03,
                              ),
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.height * 0.23,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        file_name[index].toUpperCase(),
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  )),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          List<String> file_share = [];
                                          file_share.add(file_path[index]);
                                          await Share.shareFiles(
                                            file_share,
                                            text: 'file',
                                          );
                                          // selectFile();
                                        },
                                        child: Icon(Icons.share),
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.all(9),
                                          elevation: 10,
                                          primary: Colors.lightBlue,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: const Text(
                                                  'Are you sure to delete the material?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    final file =
                                                        File(file_path[index]);
                                                    await file.delete();
                                                    file_fetch.clear();
                                                    file_name.clear();
                                                    file_path.clear();
                                                    setState(() {
                                                      futurebuilder();
                                                      listfiles();
                                                    });
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Icon(Icons.delete),
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.all(9),
                                          elevation: 10,
                                          primary: Colors.lightBlue,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (file_path.isNotEmpty)
          // body: (1 == 2)
          ? futurebuilder()
          : Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.height * 0.23,
                          color: Colors.teal,
                          child: Center(
                            child: Text(
                              'NO downloads'.toUpperCase(),
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          )),
                    )
                  ],
                )
              ],
            ),
    );
  }
}
