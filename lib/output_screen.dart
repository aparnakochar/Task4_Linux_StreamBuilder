import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OutputPage extends StatefulWidget {
  OutputPage(this.data);
  final String data;
  @override
  _OutputPageState createState() => _OutputPageState();
}

class _OutputPageState extends State<OutputPage> {
  String outputData;
  final _firestore = FirebaseFirestore.instance;
  String firebaseCommand;
  String firebaseOutput;
  @override
  void initState() {
    super.initState();
    updateOutput(widget.data);
    getMessages();
  }

  void updateOutput(data) {
    outputData = data;
  }

  void getMessages() async {
    await for (var commandOutput
        in _firestore.collection('commandAndOutput').snapshots()) {
      for (var output in commandOutput.docs) {
        firebaseCommand = output.data()['command'];
        print(
            'firebasecommand: $firebaseCommand and firebaseOutput: $firebaseOutput');
        if (outputData == firebaseCommand) {
          setState(() {
            firebaseOutput = output.data()['output'];
          });
        }
        // print(output.data());
        // firebaseCommand = output.data()['command'];
        // firebaseOutput = output.data()['output'];
      }
    }
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Text(
                    'Output',
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 25.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      toastFun('Error!!! \n Check The Entered Command');
                    },
                    icon: Icon(Icons.help),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(),
                  ),
                  // color: Colors.amber,
                  child: Text(
                    widget.data == firebaseCommand
                        ? firebaseOutput
                        : 'No Output',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
StreamBuilder<QuerySnapshot>
(
  stream:_firestore.collection('commandAndOutput').snapshots;
  builder:(context,commandOutput){
     final messages=snapshot.data.documents;
     List<Text> messageWidgets=[];
     for(var message in messages){
      final messageText = message.data()['command'];
      final messageSender = message.data()['output'];
    final messageWidget=Text('$messageText from $messageSender');
    messageWidgets.add(messageWidget);
     }
     return Column{
       children:messageWidgets;
     };
  },
  
)
*/
/* Stream builder code
StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        List<MessageBubble> messageBubbles = [];
        final messages = snapshot.data.docs.reversed;
        for (var message in messages) {
          final messageText = message.data()['text'];
          final messageSender = message.data()['sender'];
          final currentUser = loggedInUser.email;

          final messageBubble = MessageBubble(
            text: messageText,
            sender: messageSender,
            isMe: currentUser == messageSender,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            children: messageBubbles,
          ),
        );
      },
    );
*/

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class OutputPage extends StatefulWidget {
//   OutputPage(this.data);

//   final String data;
//   @override
//   _OutputPageState createState() => _OutputPageState();
// }

// class _OutputPageState extends State<OutputPage> {
//   String outputData;
//   final _firestore = FirebaseFirestore.instance;
//   String firebaseCommand;
//   String firebaseOutput;
//   @override
//   void initState() {
//     super.initState();
//     updateOutput(widget.data);
//     getMessages();
//   }

//   void updateOutput(data) {
//     outputData = data;
//   }

//   void getMessages() async {
//     final commandOutput = await _firestore.collection('commandAndOutput').get();
//     for (var output in commandOutput.docs) {
//       firebaseCommand = output.data()['command'];
//       print(
//           'firebasecommand: $firebaseCommand and firebaseOutput: $firebaseOutput');
//       if (outputData == firebaseCommand) {
//         setState(() {
//           firebaseOutput = output.data()['output'];
//         });
//       }
//       // print(output.data());
//       // firebaseCommand = output.data()['command'];
//       // firebaseOutput = output.data()['output'];
//     }
//   }

//   toastFun(String msg) {
//     Fluttertoast.showToast(
//         msg: msg,
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.white,
//         textColor: Colors.red,
//         fontSize: 16.0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Column(
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 // crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(Icons.arrow_back),
//                   ),
//                   Text(
//                     'Output',
//                     style: TextStyle(
//                       color: Colors.lightBlueAccent,
//                       fontSize: 25.0,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       toastFun('Error!!! \n Check The Entered Command');
//                     },
//                     icon: Icon(Icons.help),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     // borderRadius: BorderRadius.circular(10.0),
//                     border: Border.all(),
//                   ),
//                   // color: Colors.amber,
//                   child: Text(
//                     widget.data == firebaseCommand
//                         ? firebaseOutput
//                         : 'No Output',
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// .....
// firebaseOutput,
//'Yeha par firebase wale data ka output aana chahiye',
// outputData,
//widget.data != null ? outputData : 'No data found',
//                     style: TextStyle(
//                       fontSize: 20.0,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//             ],
//           ),
//     ));
//   }
// }
