import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';

import '../../../constant.dart';

class SHCreateFormScreen extends StatefulWidget {
  const SHCreateFormScreen({Key? key}) : super(key: key);

  @override
  _SHCreateFormScreenState createState() => _SHCreateFormScreenState();
}

class _SHCreateFormScreenState extends State<SHCreateFormScreen> {
  final dateNow = DateTime.now();
  int _count = 1;
  var dateAPI;
  var date;
  var _result = '';
  final TextEditingController _lastDate = TextEditingController();
  var className = 'IIICSEA';

  List<bool> isExpanded = [true];
  List<int> _radioSelected = [1];
  List<String> _radioType = ['Text'];
  List<Map<String, dynamic>> _values = [];
  List<bool> required = [true];

  void _datePicker() async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year, now.month, now.day),
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year, now.month, now.day + 30),
    );
    if (picked != null) {
      setState(() {
        date = (DateFormat('dd-MM-yyyy').format(picked));
        _lastDate.text = date;
      });
    }
  }

  void _submitted() {
    var data = {
      'lastDate': _lastDate.text,
      'question': _values,
      'creatorId': '12',
      'creatorName': 'ads',
      'class': className
    };
    print(data);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _lastDate.text = (DateFormat('dd-MM-yyyy')
        .format(DateTime(dateNow.year, dateNow.month, dateNow.day + 1)));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _lastDate.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _submitted();
          },
          label: const Text(
            'Create Form',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Color(0xff6E7FFC),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height * .11,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .02,
            ),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Create Form',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.black,
                  onPressed: () async {
                    setState(() {
                      _count++;
                      isExpanded.add(true);
                      _radioType.add('Text');
                      _radioSelected.add(1);
                      required.add(true);
                    });
                  },
                ),
                IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.refresh),
                  onPressed: () async {
                    setState(() {
                      _count = 0;
                      _result = '';
                      isExpanded = [];
                      _radioType = [];
                      _radioSelected = [];
                      required = [];

                      _values = [];
                    });
                  },
                )
              ],
            ),
          ),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: _lastDate,
                          onTap: () {
                            _datePicker();
                          },
                          focusNode: NoKeyboardEditableTextFocusNode(),
                          decoration: kTextFieldDecoration.copyWith(
                            contentPadding: EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                              left: 15.0,
                            ),
                            suffixIcon: Icon(
                              Icons.calendar_today,
                              color: Color(0xff0A662F),
                              size: 20,
                            ),
                            labelText: 'Last Date',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            // color: Colors.white,
                            border: Border.all(
                                color: Color(0xff2598FA),
                                style: BorderStyle.solid,
                                width: 0.80),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: className,
                              items: ['IIICSEA'].map((String item) {
                                return DropdownMenuItem<String>(
                                  child: Text(item),
                                  value: item,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  className = value.toString();
                                });
                              },
                              hint: Text("Class"),
                              disabledHint: Text("Disabled"),
                              elevation: 8,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                size: 25,
                              ),
                              iconEnabledColor: Colors.black,
                              isExpanded: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _count,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: AnimatedContainer(
                          margin: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.01,
                            horizontal:
                                MediaQuery.of(context).size.height * 0.01,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          duration: Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        decoration:
                                            TextFieldDecoration.copyWith(
                                          hintText: 'Enter Question',
                                        ),
                                        maxLines: null,
                                        keyboardType: TextInputType.multiline,
                                        onChanged: (val) {
                                          _onUpdate(
                                              index,
                                              val,
                                              _radioType[index],
                                              required[index]);
                                        },
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(isExpanded[index]
                                          ? Icons.expand_less
                                          : Icons.expand_more),
                                      onPressed: () {
                                        setState(() {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          isExpanded[index] =
                                              !isExpanded[index];
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                AnimatedContainer(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  height: isExpanded[index] ? 150 : 0,
                                  duration: Duration(milliseconds: 400),
                                  child: isExpanded[index]
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 25),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .4,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5.0),
                                                          child: Text(
                                                            'Type',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5.0),
                                                          child: Row(
                                                            children: [
                                                              Transform.scale(
                                                                scale: 1.2,
                                                                child: Radio(
                                                                  value: 1,
                                                                  groupValue:
                                                                      _radioSelected[
                                                                          index],
                                                                  activeColor:
                                                                      Color(
                                                                          0xff0A662F),
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      _radioSelected[
                                                                              index] =
                                                                          int.parse(
                                                                              value.toString());
                                                                      _radioType[
                                                                              index] =
                                                                          'Text';
                                                                      _onUpdate(
                                                                          index,
                                                                          '',
                                                                          _radioType[
                                                                              index],
                                                                          required[
                                                                              index]);
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                              Text(
                                                                'Text',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5.0),
                                                          child: Row(
                                                            children: [
                                                              Transform.scale(
                                                                scale: 1.2,
                                                                child: Radio(
                                                                  value: 2,
                                                                  groupValue:
                                                                      _radioSelected[
                                                                          index],
                                                                  activeColor:
                                                                      Color(
                                                                          0xff0A662F),
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      _radioSelected[
                                                                              index] =
                                                                          int.parse(
                                                                              value.toString());
                                                                      _radioType[
                                                                              index] =
                                                                          'Options';
                                                                      _onUpdate(
                                                                          index,
                                                                          '',
                                                                          _radioType[
                                                                              index],
                                                                          required[
                                                                              index]);
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                              Text(
                                                                'Options',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            isExpanded.removeAt(
                                                                index);
                                                            _radioType.removeAt(
                                                                index);
                                                            _radioSelected
                                                                .removeAt(
                                                                    index);
                                                            required.removeAt(
                                                                index);
                                                            if (_values.length >
                                                                0) {
                                                              _values.removeAt(
                                                                  index);
                                                            }
                                                            _count--;
                                                          });
                                                        },
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .4,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                'Remove',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Icon(
                                                                Icons.delete,
                                                                size: 27,
                                                                color: Colors
                                                                    .redAccent,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 50,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            'Required',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          FlutterSwitch(
                                                            width: 65.0,
                                                            height: 35.0,
                                                            valueFontSize: 15.0,
                                                            toggleSize: 15.0,
                                                            value:
                                                                required[index],
                                                            activeColor: Color(
                                                                0xff0A662F),
                                                            borderRadius: 30.0,
                                                            padding: 7.0,
                                                            showOnOff: true,
                                                            onToggle: (val) {
                                                              setState(() {
                                                                required[
                                                                        index] =
                                                                    val;
                                                                _onUpdate(
                                                                    index,
                                                                    '',
                                                                    _radioType[
                                                                        index],
                                                                    required[
                                                                        index]);
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : null,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Text(_result),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onUpdate(int index, String val, String type, bool required) async {
    int foundKey = -1;
    for (var map in _values) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _values.removeWhere((map) {
        if (val == '') {
          val = map['question'];
        }
        return map["id"] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      "id": index,
      "question": val,
      "type": type,
      "required": required
    };
    _values.add(json);
    setState(() {
      _result = _values.toString();
    });
  }
}

class NoKeyboardEditableTextFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
  @override
  bool consumeKeyboardToken() {
    return false;
  }
}
