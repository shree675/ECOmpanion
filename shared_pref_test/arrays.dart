import 'dart:convert';

class Array{

  List<int> ndeasy;
  static List<int> ndmedium;
  static List<int> ndhard;
  static List<String> easy;
  String encodedeasy;

  @override
  initState(){
    for(int i=0;i<8;i++){
      ndeasy[i]=0;
    }
  }

  Array(){

    for(int i=0;i<8;i++){
      // Array.ndeasy[i]=0;
      // Array.ndeasy.add(0);
      easy[i]=("easy$i");
    }

    for(int i=0;i<19;i++){
      ndmedium[i]=0;
    }

    for(int i=0;i<12;i++){
      ndeasy[i]=0;
    }

    // encodedeasy = json.encode(ndeasy);
    print(ndeasy);

  }

  // int getNonDailyEasy(int )

  // void update(){
  //   for(int i=0;i<8;i++){
  //     if(Array.ndeasy[i])
  //   }
  // }

  void validate(){
    for(int i=0;i<8;i++){
      if(ndeasy[i]>51){
        ndeasy[i]=51;
      }
    }

    for(int i=0;i<19;i++){
      if(ndmedium[i]>34){
        ndeasy[i]=34;
      }
    }

    for(int i=0;i<12;i++){
      if(ndhard[i]>17){
        ndhard[i]=17;
      }
    }
  }

}

Array arr = Array();