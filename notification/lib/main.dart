import 'package:flutter/material.dart';
import 'notify.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'notify',
      home: MyHomePage(title: 'notify me'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Local Notification'),
      ),
      body: Column(
        children: [


          new RaisedButton(

            onPressed:
                () { Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (context) => notify()),
                );},

            child: Text("set notification time"),

          ),
        ],
      ),
    );
  }
  }






