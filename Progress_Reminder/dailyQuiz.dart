import 'flashcard_model.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'question.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          onPressed: () => Navigator.of(context).pop(),
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
}
