import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constant.dart';

class STSubmitFormScreen extends StatefulWidget {
  final data = {
    'lastDate': '13-08-2021',
    'question': [
      {'id': 0, 'question': 'Name', 'type': 'Text', 'required': true},
      {'id': 1, 'question': 'Age', 'type': 'Text', 'required': false},
      {
        'id': 1,
        'question': 'Dept',
        'type': 'Options',
        'options': ['CSE', 'ECE', 'EEE', 'IT'],
        'required': true
      },
    ],
    'creatorId': '12',
    'creatorName': 'ads',
    'class': 'IIICSEA'
  };

  @override
  _STSubmitFormScreenState createState() => _STSubmitFormScreenState();
}

class _STSubmitFormScreenState extends State<STSubmitFormScreen> {
  final dateNow = DateTime.now();
  var dateAPI;
  var date;
  var _result = '';
  var className = 'IIICSEA';
  bool _trySubmitted = false;

  List<Map<String, dynamic>> _values = [];
  List<bool> required = [true];

  final _formKey = GlobalKey<FormState>();

  void _submitted() {
    print(_values);
    setState(() {
      _trySubmitted = true;
    });
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      FocusScope.of(context).unfocus();
      var data = {'answers': _values, 'formId': widget.data['_uid']};
      print(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data['question'] as List;
    print(data.length);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _submitted();
          },
          label: const Text(
            'Submit Form',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          icon: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: Color(0xffE49D70),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Color(0xffF5F6FD),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height * .11,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .02,
            ),
            child: AppBar(
              backgroundColor: Color(0xffF5F6FD),
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Form',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.refresh),
                    onPressed: () async {
                      setState(() {
                        _result = '';
                        required = [];
                        _values = [];
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        if (data[index]['type'] == 'Text')
                          return Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: AnimatedContainer(
                              margin: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.01,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                                bottom: 10.0,
                                              ),
                                              child: Text(
                                                '${data[index]['question']} :',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            if (data[index]['required'])
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  bottom: 10.0,
                                                ),
                                                child: Text(
                                                  '* Required',
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.redAccent),
                                                ),
                                              ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                decoration: TextFieldDecoration
                                                    .copyWith(
                                                  hintText: ' ',
                                                ),
                                                validator: (val) {
                                                  if (data[index]['required'] ==
                                                      true) if (val!.isEmpty) {
                                                    return 'Field Required';
                                                  }
                                                  return null;
                                                },
                                                maxLines: null,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                onChanged: (val) {
                                                  if (_trySubmitted)
                                                    _formKey.currentState!
                                                        .validate();
                                                  _onUpdate(
                                                    index,
                                                    val,
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        else
                          print('asd');
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: AnimatedContainer(
                            margin: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.01,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                              bottom: 10.0,
                                            ),
                                            child: Text(
                                              '${data[index]['question']} :',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          if (data[index]['required'])
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                                bottom: 10.0,
                                              ),
                                              child: Text(
                                                '* Required',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.redAccent),
                                              ),
                                            ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  _onUpdate(
                                                    index,
                                                    data[index]['options'][0],
                                                  );
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  padding: EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    color: Color(0xff6E7FFC),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      data[index]['options'][0],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  _onUpdate(
                                                    index,
                                                    data[index]['options'][1],
                                                  );
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  padding: EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    color: Color(0xff6E7FFC),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      data[index]['options'][1],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  _onUpdate(
                                                    index,
                                                    data[index]['options'][1],
                                                  );
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  padding: EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    color: Color(0xff6E7FFC),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      data[index]['options'][2],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  _onUpdate(
                                                    index,
                                                    data[index]['options'][3],
                                                  );
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  padding: EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    color: Color(0xff6E7FFC),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      data[index]['options'][3],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
      ),
    );
  }

  _onUpdate(int index, String val) async {
    if (val != '') {
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
        "answer": val,
      };
      _values.add(json);
      setState(() {
        _result = _values.toString();
      });
    }
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
