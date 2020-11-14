/*import 'flashcard_model.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'question.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homescreen.dart';

class DailyQuiz extends StatefulWidget {

  DailyQuiz();

  @override
  _DailyQuizState createState() => _DailyQuizState();
}

class _DailyQuizState extends State<DailyQuiz> {

  bool rem;
  int index,diff,id;
  bool daily;

  List<bool> ndeasyrem = new List(9);
  List<bool> ndmediumrem = new List(19);
  List<bool> ndhardrem = new List(12);

  List<bool> deasyrem = new List(2);
  List<bool> dmediumrem = new List(6);
  List<bool> dhardrem = new List(3);

  loadCounter() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      // if (!daily) {
      //   if (diff == 1) {
      //     this.rem = pre.getBool('easyrem$id') ?? false;
      //     // return pre.getBool('easyrem$id') ?? false;
      //   } else if (diff == 2) {
      //     this.rem = pre.getBool('mediumrem$id') ?? false;
      //     // return pre.getBool('mediumrem$id') ?? false;
      //
      //   } else if (diff == 3) {
      //     this.rem = pre.getBool('hardrem$id') ?? false;
      //
      //   }
      // }
      // // } else if (daily && quiz == 1) {
      // else if (daily) {
      //   if (diff == 1) {
      //     this.rem = pre.getBool('deasyrem$id') ?? false;
      //
      //   } else if (diff == 2) {
      //     this.rem = pre.getBool('dmediumrem$id') ?? false;
      //
      //   } else if (diff == 3) {
      //     this.rem = pre.getBool('dhardrem$id') ?? false;
      //
      //   }
      // }
      for(int i=0;i<9;i++){
        ndeasyrem[i]=pre.getBool('easyrem$id') ?? false;
      }
      for(int i=0;i<19;i++){
        ndmediumrem[i]=pre.getBool('mediumrem$id') ?? false;
      }
      for(int i=0;i<12;i++){
        ndhardrem[i]=pre.getBool('hardrem$id') ?? false;
      }
      for(int i=0;i<2;i++){
        deasyrem[i]=pre.getBool('deasyrem$id') ?? false;
      }
      for(int i=0;i<6;i++){
        dmediumrem[i]=pre.getBool('dmediumrem$id') ?? false;
      }
      for(int i=0;i<3;i++){
        dhardrem[i]=pre.getBool('dhardrem$id') ?? false;
      }
    });
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    loadCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xff2C2E36,
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            // Navigator.push(context, MaterialPageRoute(
            //   builder: (context) => HomeScreen(),
            // ));
          },
        ),
        title: Text("ECO"),
        centerTitle: true,
        backgroundColor: const Color(
          0xff2C2E36,
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: flashcardModels.map((e) {
            this.index=flashcardModels.indexOf(e);
            this.diff=(data[index]["difficulty"] as Map)["scale"];
            this.id=data[index]["id"];
            this.id-=1;
            // bool rem;
            this.daily=data[index]["isDaily"];

            // List<bool> ndeasyrem = new List(8);
            // List<bool> ndmediumrem = new List(19);
            // List<bool> ndhardrem = new List(12);
            //
            // List<bool> deasyrem = new List(2);
            // List<bool> dmediumrem = new List(6);
            // List<bool> dhardrem = new List(3);
            // loadCounter(diff, id);
            if(!daily){
              if(diff==1){
                this.rem=ndeasyrem[id];
              }
              else if(diff==2){
                this.rem=ndmediumrem[id];
              }
              else if(diff==3){
                this.rem=ndhardrem[id];
              }
            }
            else {
              if(diff==1){
                this.rem=deasyrem[id];
              }
              else if(diff==2){
                this.rem=dmediumrem[id];
              }
              else if(diff==3){
                this.rem=dhardrem[id];
              }
            }

            if (this.rem) {
              return Question(e.question, e.options,
                  data[flashcardModels.indexOf(e)], 1, e,flashcardModels.indexOf(e));
            }
            return SizedBox(
              height: 0,
              width: 0,
            );
          }).toList(),
        ),
      ),
    );
  }
}*/






import 'flashcard_model.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'question.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homescreen.dart';
import 'question2.dart';
import 'options.dart';

class DailyQuiz extends StatefulWidget {

  int curIndex;
  DailyQuiz(this.curIndex);

  @override
  _DailyQuizState createState() => _DailyQuizState(this.curIndex);
}

class _DailyQuizState extends State<DailyQuiz> {

  bool rem;
  int index,diff,id;
  bool daily;
  int curIndex=-1;

  void answer() {                                                                 // need to change this later
    setState(() {
      curIndex+=1;
      if(curIndex>=50){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
      }
      if(!data[curIndex]["isDaily"]) {
        answer();
      }
    });
  }

  _DailyQuizState(this.curIndex);

  List<bool> ndeasyrem = new List(9);
  List<bool> ndmediumrem = new List(19);
  List<bool> ndhardrem = new List(12);

  List<bool> deasyrem = new List(2);
  List<bool> dmediumrem = new List(6);
  List<bool> dhardrem = new List(3);

  loadCounter() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      for(int i=0;i<9;i++){
        ndeasyrem[i]=pre.getBool('easyrem$id') ?? false;
      }
      for(int i=0;i<19;i++){
        ndmediumrem[i]=pre.getBool('mediumrem$id') ?? false;
      }
      for(int i=0;i<12;i++){
        ndhardrem[i]=pre.getBool('hardrem$id') ?? false;
      }
      for(int i=0;i<2;i++){
        deasyrem[i]=pre.getBool('deasyrem$id') ?? false;
      }
      for(int i=0;i<6;i++){
        dmediumrem[i]=pre.getBool('dmediumrem$id') ?? false;
      }
      for(int i=0;i<3;i++){
        dhardrem[i]=pre.getBool('dhardrem$id') ?? false;
      }
    });
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    loadCounter();
    answer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xff2C2E36,
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            // Navigator.push(context, MaterialPageRoute(
            //   builder: (context) => HomeScreen(),
            // ));
          },
        ),
        title: Text("ECO"),
        centerTitle: true,
        backgroundColor: const Color(
          0xff2C2E36,
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle,
            ),
            onPressed: () {},
          ),
        ],
      ),
      // body: curIndex<data.length ? Column(
        // children: flashcardModels.map((e) {
        //   print('$curIndex');
          // this.index=flashcardModels.indexOf(e);
          // this.diff=(data[index]["difficulty"] as Map)["scale"];
          // this.id=data[index]["id"];
          // this.id-=1;
          // // bool rem;
          // this.daily=data[index]["isDaily"];
          //
          // // List<bool> ndeasyrem = new List(8);
          // // List<bool> ndmediumrem = new List(19);
          // // List<bool> ndhardrem = new List(12);
          // //
          // // List<bool> deasyrem = new List(2);
          // // List<bool> dmediumrem = new List(6);
          // // List<bool> dhardrem = new List(3);
          // // loadCounter(diff, id);
          // if(!daily){
          //   if(diff==1){
          //     this.rem=ndeasyrem[id];
          //   }
          //   else if(diff==2){
          //     this.rem=ndmediumrem[id];
          //   }
          //   else if(diff==3){
          //     this.rem=ndhardrem[id];
          //   }
          // }
          // else {
          //   if(diff==1){
          //     this.rem=deasyrem[id];
          //   }
          //   else if(diff==2){
          //     this.rem=dmediumrem[id];
          //   }
          //   else if(diff==3){
          //     this.rem=dhardrem[id];
          //   }
          // }
          // print('${data[curIndex]["isDaily"]}');

          // if(data[curIndex]["isDaily"]){
          //   // answer();
          //   return Question(data[curIndex]["question"], data[curIndex]["options"],
          //       data[curIndex], 1, e,curIndex);
          // }
          //
          // // answer();
          // curIndex+=1;

    //       return SizedBox(
    //         height: 0,
    //         width: 0,
    //       );
    //     }).toList(),
    //   )
    //   :HomeScreen(),
    // );
    body: curIndex<data.length ? Column(
    children: [Question2(data[curIndex]["question"]), ...(data[curIndex]["options"] as List).map((e) => Option(answer, e, curIndex)),],
    ): Center(
      child: RaisedButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
        },
        child: Text("Reset"),
      ),
    ),
    );
  }
}