import 'package:flutter/material.dart';
import 'package:sp_app/Modules/Shared/Screens/FileListScreen.dart';
import 'package:sp_app/Helpers/ConstantData.dart';
import 'package:sliver_header_delegate/sliver_header_delegate.dart';
import 'package:sp_app/Modules/Shared/Widgets/BottomNavigationBar.dart';

class SubjectListScreen extends StatefulWidget {
  const SubjectListScreen({Key? key}) : super(key: key);

  @override
  _SubjectListScreenState createState() => _SubjectListScreenState();
}

class _SubjectListScreenState extends State<SubjectListScreen> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavBar(2),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: FlexibleHeaderDelegate(
                expandedHeight: 240,
                background: MutableBackground(
                  expandedColor: Colors.lightBlue,
                  collapsedColor: Colors.indigo,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(15),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 450.0,
                  mainAxisSpacing: 7,
                  crossAxisSpacing: 7,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                    margin: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        primary: Colors.lightBlue,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DisplayFile(subjectList[index]),
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          subjectList[index],
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo),
                        ),
                      ),
                    ),
                  ),
                  childCount: subjectList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
