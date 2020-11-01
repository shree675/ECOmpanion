import 'package:flutter/material.dart';
import 'package:github1/dailyQuiz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Question extends StatefulWidget {
  final String question;
  final List<String> options;
  Map<String, Object> data;
  int quiz;
  Question(this.question, this.options, this.data, this.quiz);

  @override
  _QuestionState createState() => _QuestionState(this.question, this.options, this.data, this.quiz);
}

class _QuestionState extends State<Question> {
  final String question;
  final List<String> options;
  Map<String, Object> data;

  int id;
  int diff;
  bool daily,level;
  int quiz;

  _QuestionState(this.question, this.options, this.data, this.quiz);
  List<int> ndeasy = new List(8);
  List<String> easystring = new List(8);
  List<int> ndmedium = new List(19);
  List<String> mediumstring = new List(19);
  List<int> ndhard = new List(12);
  List<String> hardstring = new List(12);

  List<int> deasy = new List(2);
  List<String> deasystring = new List(2);
  List<int> dmedium = new List(6);
  List<String> dmediumstring = new List(6);
  List<int> dhard = new List(3);
  List<String> dhardstring = new List(3);

  @override
  initState(){
    super.initState();
    id=data["id"];
    diff = (this.data["difficulty"] as Map)["scale"];
    daily=this.data["isDaily"];
    level=this.data["hasLevel"];

    if(!daily) {
      if (diff == 1) {
        ndeasy[id] = 0;
        easystring[id] = "easy$id";
      }
      else if (diff == 2) {
        ndmedium[id] = 0;
        mediumstring[id] = "medium$id";
      }
      else if (diff == 3) {
        ndhard[id] = 0;
        hardstring[id] = "hard$id";
      }
    }
    else if(daily && quiz==1){
      if (diff == 1) {
        deasy[id] = 0;
        deasystring[id] = "deasy$id";
      }
      else if (diff == 2) {
        dmedium[id] = 0;
        dmediumstring[id] = "dmedium$id";
      }
      else if (diff == 3) {
        dhard[id] = 0;
        dhardstring[id] = "dhard$id";
      }
    }
    loadCounter(diff,id);
  }

  loadCounter(diff,id) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      if(!daily) {
        if (diff == 1) {
          ndeasy[id] = pre.getInt('easy$id') ?? 0;
        }
        else if (diff == 2) {
          ndmedium[id] = pre.getInt('medium$id') ?? 0;
        }
        else if (diff == 3) {
          ndhard[id] = pre.getInt('hard$id') ?? 0;
        }
      }
      else if(daily && quiz==1){
        if (diff == 1) {
          deasy[id] = pre.getInt('deasy$id') ?? 0;
        }
        else if (diff == 2) {
          dmedium[id] = pre.getInt('dmedium$id') ?? 0;
        }
        else if (diff == 3) {
          dhard[id] = pre.getInt('dhard$id') ?? 0;
        }
      }
    });
  }

  validate() async{
    SharedPreferences pre = await SharedPreferences.getInstance();
    if(!daily){
      if(diff==1){
        if(ndeasy[id]<0){
          ndeasy[id] = (pre.getInt('easy$id') ?? 0);
          ndeasy[id] = 0;
          pre.setInt('easy$id', ndeasy[id]);
        }
      }
      else if(diff==2){
        if(ndmedium[id]<0){
          ndmedium[id] = (pre.getInt('medium$id') ?? 0);
          ndmedium[id] = 0;
          pre.setInt('medium$id', ndmedium[id]);
        }
      }
      else if(diff==3){
        if(ndhard[id]<=0){
          ndhard[id] = (pre.getInt('hard$id') ?? 0);
          ndhard[id] = 0;
          pre.setInt('hard$id', ndhard[id]);
        }
      }
    }
    else if(daily && quiz==1){
      if(diff==1){
        if(deasy[id]<0){
          deasy[id] = (pre.getInt('deasy$id') ?? 0);
          deasy[id] = 0;
          pre.setInt('deasy$id', deasy[id]);
        }
      }
      else if(diff==2){
        if(dmedium[id]<0){
          dmedium[id] = (pre.getInt('dmedium$id') ?? 0);
          dmedium[id] = 0;
          pre.setInt('dmedium$id', dmedium[id]);
        }
      }
      else if(diff==3){
        if(dhard[id]<=0){
          dhard[id] = (pre.getInt('dhard$id') ?? 0);
          dhard[id] = 0;
          pre.setInt('dhard$id', dhard[id]);
        }
      }
    }
  }

  updateCounter(int i, int points) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      if(!daily) {
        if (diff == 1) {
          ndeasy[i] = (pre.getInt('easy$i') ?? 0) + points;
          pre.setInt('easy$i', ndeasy[i]);
        }
        else if (diff == 2) {
          ndmedium[i] = (pre.getInt('medium$i') ?? 0) + points;
          pre.setInt('medium$i', ndmedium[i]);
        }
        else if (diff == 3) {
          ndhard[i] = (pre.getInt('hard$i') ?? 0) + points;
          pre.setInt('hard$i', ndhard[i]);
        }
      }
      else if(daily && quiz==1){
        if (diff == 1) {
          deasy[i] = (pre.getInt('deasy$i') ?? 0) + points;
          pre.setInt('deasy$i', deasy[i]);
        }
        else if (diff == 2) {
          dmedium[i] = (pre.getInt('dmedium$i') ?? 0) + points;
          pre.setInt('dmedium$i', dmedium[i]);
        }
        else if (diff == 3) {
          dhard[i] = (pre.getInt('dhard$i') ?? 0) + points;
          pre.setInt('dhard$i', dhard[i]);
        }
      }
    });
    validate();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        color: const Color(0xff1F4EB4),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(7),
              child: Text(
                widget.question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xffFFFFFF),
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ...widget.options.map(
                  (e) => Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  color: const Color(0xff1B3671),
                  onPressed: () {

                    if(e==(data["options"] as List)[0] && level){
                      updateCounter(id,1);
                    }

                    else if(e==(data["options"] as List)[1] && level){
                      updateCounter(id, 0);
                    }

                    else if(e==(data["options"] as List)[2] && level){
                      updateCounter(id, -1);
                    }

                  },
                  child: Text(
                    e,
                    style: TextStyle(color: const Color(0xffFFFFFF)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('${ndmedium}'),
          ],
        ),
      ),
    );
  }
}