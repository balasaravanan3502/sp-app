import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'dart:math' as math;
import 'package:share/share.dart';

class DisplayPDF extends StatefulWidget {
  final String url;
  final String name;
  DisplayPDF({Key? key, required this.url, required this.name})
      : super(key: key);

  @override
  _DisplayPDFState createState() => _DisplayPDFState();
}

class _DisplayPDFState extends State<DisplayPDF>
    with SingleTickerProviderStateMixin {
  bool fileLoaded = false;
  PdfViewerController _controller = PdfViewerController();
  late PdfTextSearchResult _searchResult = PdfTextSearchResult();
  late TextEditingController _textEditingController = TextEditingController();
  bool isShare = true;
  bool isSearch = true;
  int searchIndex = 0;
  int searchCount = 0;
  bool search = false;
  int pageCount = 1;
  int start = 1;
  late SfRangeValues _pageNum = SfRangeValues(1, pageCount);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100.0, right: 30.0),
            child: SfPdfViewer.network(
              widget.url,
              pageSpacing: 8,
              onDocumentLoaded: (PdfDocumentLoadedDetails details) async {
                pageCount = details.document.pages.count;
                setState(() => fileLoaded = true);
              },
              onPageChanged: (PdfPageChangedDetails details) async {
                setState(() {
                  _pageNum = SfRangeValues(details.newPageNumber, pageCount);
                  start = details.newPageNumber;
                });
              },
              controller: _controller,
              canShowScrollHead: false,
              canShowScrollStatus: true,
              canShowPaginationDialog: true,
              enableDoubleTapZooming: true,
              searchTextHighlightColor: Colors.lightBlue,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            right: 10,
            bottom: 10,
            child: Container(
                padding: EdgeInsets.only(bottom: 10.0, top: 40.0),
                // height: MediaQuery.of(context).size.height * 0.1,
                height: 100,
                color: Colors.amber,
                width: 20,
                child: Transform.rotate(
                  angle: -math.pi,
                  child: SfRangeSlider.vertical(
                      startThumbIcon: Icon(Icons.navigate_next),
                      activeColor: Colors.transparent,
                      inactiveColor: Colors.transparent,
                      //minorTicksPerInterval: 1,
                      min: pageCount == 1 ? 0 : 1,
                      max: pageCount,
                      interval: 1,
                      values: _pageNum,
                      onChanged: (dynamic values) {
                        setState(() {
                          _pageNum = values;
                          String page = values.toString();
                          String start_Page =
                              page.substring(26, 29).replaceAll('.', '');
                          start = int.parse(start_Page);
                          _controller.jumpToPage(start);
                        });
                      }),
                )),
          ),
          fileLoaded
              ? Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child: (isSearch == true && isShare == true)
                      ? SlideInLeft(
                          duration: Duration(milliseconds: 250),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  //color: Colors.indigo,
                                  child: Text(
                                    widget.name.toUpperCase(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: (pageCount != 1)
                                      ? Text(
                                          '$start/$pageCount',
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.035,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      : Text(
                                          '1/1',
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.035,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.lightBlue,
                                    elevation: 5,
                                    padding: EdgeInsets.all(15.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    isSearch = false;
                                    setState(() {});
                                  },
                                  child: Icon(Icons.search),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.lightBlue,
                                    elevation: 5,
                                    padding: EdgeInsets.all(10.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    isShare = false;
                                    setState(() {});
                                  },
                                  child: Icon(Icons.link_sharp),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.lightBlue,
                                    elevation: 5,
                                    padding: EdgeInsets.all(10.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : (isSearch == false && isShare == true)
                          ? SlideInRight(
                              duration: Duration(milliseconds: 250),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.navigate_before,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      _searchResult.previousInstance();
                                      if (searchIndex == 1) {
                                        return setState(() {
                                          searchIndex = searchCount;
                                        });
                                      } else {
                                        searchIndex--;
                                        setState(() {});
                                      }
                                    },
                                  ),
                                  Container(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: TextField(
                                      showCursor: false,
                                      controller: _textEditingController,
                                      decoration: InputDecoration(
                                          hintText: 'search',
                                          hintStyle: TextStyle(
                                            fontStyle: FontStyle.italic,
                                          )),
                                      style: TextStyle(
                                        color: Colors.indigo,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        _searchResult =
                                            (await _controller.searchText(
                                                _textEditingController.text));
                                        setState(() => isSearch = false);
                                        searchIndex =
                                            _searchResult.currentInstanceIndex;
                                        searchCount =
                                            _searchResult.totalInstanceCount;
                                        if (searchCount > 0) {
                                          search = true;
                                        }
                                      },
                                      child: Icon(Icons.search),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.lightBlue,
                                        elevation: 5,
                                        padding: EdgeInsets.all(10.0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.navigate_next,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      _searchResult.nextInstance();
                                      if (searchIndex == 1) {
                                        return setState(() {
                                          searchIndex = 1;
                                        });
                                      } else {
                                        searchIndex++;
                                        setState(() {});
                                      }
                                    },
                                  ),
                                  search
                                      ? Container(
                                          padding: EdgeInsets.only(top: 12.0),
                                          height: 40,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          child: Text(
                                            '$searchIndex / $searchCount',
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.035,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        )
                                      : SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        _searchResult =
                                            (await _controller.searchText(
                                                'qwertyuiopasdfghjklzxcvbnm'));
                                        setState(() {
                                          search = false;
                                          isSearch = true;
                                        });
                                        searchIndex = searchCount = 0;
                                      },
                                      child: Icon(Icons.cancel_sharp),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(10.0),
                                        primary: Colors.lightBlue,
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SlideInRight(
                              duration: Duration(milliseconds: 250),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: ElevatedButton(
                                      onPressed: () async {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(Icons.cloud_download_sharp),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Text(
                                            'Download'.toUpperCase(),
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.lightBlue,
                                        elevation: 5,
                                        padding: EdgeInsets.all(15.0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await Share.share(widget.url);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(Icons.share_sharp),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Text(
                                            'share'.toUpperCase(),
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.lightBlue,
                                        elevation: 5,
                                        padding: EdgeInsets.only(
                                            top: 15.0,
                                            bottom: 15.0,
                                            left: 17.0,
                                            right: 20.0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        setState(() => isShare = true);
                                      },
                                      child: Icon(Icons.cancel_sharp),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(10.0),
                                        primary: Colors.lightBlue,
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * 1,
                  width: MediaQuery.of(context).size.width * 1,
                  color: Colors.white,
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
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
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
                ),
        ],
      )),
    );
  }
}
