import 'package:flutter/material.dart';
import 'package:ibdaa/ui/quizPage/quizPage.dart';
import 'package:localstorage/localstorage.dart';
import 'package:uuid/uuid.dart';
import 'package:cooky/cooky.dart' as cookie;

import '../style.dart';

class StartQuizPage extends StatefulWidget {
  @override
  _StartQuizPageState createState() => _StartQuizPageState();
}

class _StartQuizPageState extends State<StartQuizPage> {
  String deviceid;
  String cookieName;
  // Save and Delete data from Local Storage

  //testing

  List oldData = ['empty'];
  List progress = [];

  final LocalStorage storage = new LocalStorage('ibdaa');
  final progressStorage = LocalStorage('progress');

  _copyTheOldDataFromLocalStorage() async {
    await storage.ready;
    final getIbdaaData = storage.getItem(deviceid);

    if (getIbdaaData != null) {
      if (getIbdaaData == null) {
        setState(() {
          oldData = [];
        });
      } else if (getIbdaaData == []) {
        setState(() {
          oldData = [];
        });
      } else if (getIbdaaData == true) {
        setState(() {
          oldData = [];
        });
      } else {
        setState(() {
          oldData = getIbdaaData;
        });
      }
    } else {
      setState(() {
        oldData = [];
      });
    }
  }

  _getDeviceId() {
    var uuid = Uuid();
    // Generate a v1 (time-based) id
    var v1 = uuid.v1();
    setState(() {
      deviceid = v1;
    });
    return v1;
  }

  _addCookie() {
    cookie.set('id', deviceid, maxAge: Duration(days: 3));
  }

  _checkCookie() async {
    var value = cookie.get('id');

    if (value != null) {
      setState(() {
        cookieName = value;
        deviceid = value;
      });
    } else {
      await _getDeviceId();
      await _addCookie();

      setState(() {
        cookieName = deviceid;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this._checkCookie();
    this._copyTheOldDataFromLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: RaisedButton(
            shape: buttonStyle,
            textColor: Colors.white,
            color: Colors.blue,
            child: Text('Start Quiz'),
            onPressed: () {
              Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        QuizPage(deviceid, cookieName, oldData),
                  ));
            }),
      ),
    );
  }
}
