import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'arrays.dart';

void main() {
  runApp(MaterialApp(
    home: Main(),
  ));
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {

  List<Image> l = [
    Image.asset('assets/syence.jpg', height: 80.0, width: 240.0,),
    Image.asset('assets/img.png', height: 80.0, width: 240.0,)];

  int counter=0;
  String encodedeasy="";
  // Array.ndeasy;
  
  @override
  initState(){
    super.initState();
    // Array arr = new Array();
    // for(int i=0;i<8;i++){
    //   arr.ndeasy[i]=0;
    // }
    loadCounter();
  }

  Widget img(){
    // Array.ndeasy = json.decode(array);
    print(arr.ndeasy);
    return l[0];
  }

  loadCounter() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      // counter = pre.getInt('counter') ?? 0;
      // encodedeasy = pre.getString('alleasy') ?? "";
      // for(int i=0;i<8;i++){
      //   Array.ndeasy[i] = pre.getInt(Array.easy[i]) ?? 0;
      // }
    });
  }

  updateCounter() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      counter = (pre.getInt('counter') ?? 0) + 1;
      pre.setInt('counter', counter);
      // Array.ndeasy[i] = (pre.getInt(Array.easy[i]) ?? 0) + 1;
      // pre.setInt(Array.easy[i], Array.ndeasy[i]);
      // encodedeasy = pre.getString('alleasy') ?? "";
      // Array.ndeasy = json.decode(encodedeasy);
      // Array.ndeasy[i]+=1;
      // encodedeasy = json.encode(Array.ndeasy);
      // pre.setString('alleasy', encodedeasy);
    });
  }

  resetCounter() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      // counter = (pre.getInt('counter') ?? 0);
      // counter = 0;
      // pre.setInt('counter', counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Persistence'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: Text('$counter',
          style: TextStyle(
            fontSize: 18.0
          ),)),
          SizedBox(height: 40.0,),
          l[arr.ndeasy[0]%2],
          // img(),
          SizedBox(height: 40.0,),
          FlatButton(
            onPressed: resetCounter,
            child: Text('reset'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: updateCounter,
        child: Icon(Icons.add),
      ),
    );
  }
}
