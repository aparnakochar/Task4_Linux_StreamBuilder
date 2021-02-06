import 'package:fb_task/output_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "package:http/http.dart" as http;

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String command;
  String url = 'http://192.168.43.191/cgi-bin/linuxApp.py';
  var data;
  final _firestore = FirebaseFirestore.instance;

  Future getOutput(String command) async {
    http.Response response = await http.get('$url?x=$command');
    print('response code:${response.statusCode}');
    data = response.body;
  }

  toastFun(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.red,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Container(
                  child: Image(image: AssetImage('images/linux_logo.png')),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Any Command',
                  hintStyle: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 20.0,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 20.0,
                  ),
                  fillColor: Colors.red,
                  focusColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.orange,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
                autocorrect: false,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.orange,
                  fontWeight: FontWeight.w500,
                ),
                onChanged: (value) {
                  command = value;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Material(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.lightBlueAccent,
                elevation: 5.0,
                child: MaterialButton(
                  minWidth: 150.0,
                  child: Text(
                    'Run Command',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () async {
                    if (command != null) {
                       await getOutput(command);
                      await _firestore.collection('commandAndOutput').add({
                        'command': command,
                        'output': data,   
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return OutputPage(command);
                          },
                        ),
                      );
                    } else {
                      toastFun('Enter any commmand to see the output');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

