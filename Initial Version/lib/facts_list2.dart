import 'package:flutter/material.dart';
import 'package:expansion_card/expansion_card.dart';
import 'modified_card.dart';

class FactsList2 extends StatelessWidget {
  final facts = [
    {
      "title": "Fact 1",
      "shortDescription":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "longDescription":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris dolor justo, facilisis nec consequat at, volutpat et arcu. Vestibulum congue semper libero a congue. Vestibulum ullamcorper lectus orci, ut rhoncus ligula pharetra a. Etiam scelerisque magna nec purus vulputate, ut faucibus tortor laoreet. Sed nisi leo, dignissim at laoreet non, ornare eget risus. Integer scelerisque nibh erat, sed aliquet leo efficitur in. Mauris et augue ac erat porttitor gravida eget a justo. Curabitur nisl lectus, porta et dolor at, sollicitudin viverra libero. Nam et leo fermentum magna interdum tincidunt.",
    },
    {
      "title": "Fact 2",
      "shortDescription":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "longDescription":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris dolor justo, facilisis nec consequat at, volutpat et arcu. Vestibulum congue semper libero a congue. Vestibulum ullamcorper lectus orci, ut rhoncus ligula pharetra a. Etiam scelerisque magna nec purus vulputate, ut faucibus tortor laoreet. Sed nisi leo, dignissim at laoreet non, ornare eget risus. Integer scelerisque nibh erat, sed aliquet leo efficitur in. Mauris et augue ac erat porttitor gravida eget a justo. Curabitur nisl lectus, porta et dolor at, sollicitudin viverra libero. Nam et leo fermentum magna interdum tincidunt.",
    },
    {
      "title": "Fact 3",
      "shortDescription":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "longDescription":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris dolor justo, facilisis nec consequat at, volutpat et arcu. Vestibulum congue semper libero a congue. Vestibulum ullamcorper lectus orci, ut rhoncus ligula pharetra a. Etiam scelerisque magna nec purus vulputate, ut faucibus tortor laoreet. Sed nisi leo, dignissim at laoreet non, ornare eget risus. Integer scelerisque nibh erat, sed aliquet leo efficitur in. Mauris et augue ac erat porttitor gravida eget a justo. Curabitur nisl lectus, porta et dolor at, sollicitudin viverra libero. Nam et leo fermentum magna interdum tincidunt.",
    },
    {
      "title": "Fact 4",
      "shortDescription":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "longDescription":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris dolor justo, facilisis nec consequat at, volutpat et arcu. Vestibulum congue semper libero a congue. Vestibulum ullamcorper lectus orci, ut rhoncus ligula pharetra a. Etiam scelerisque magna nec purus vulputate, ut faucibus tortor laoreet. Sed nisi leo, dignissim at laoreet non, ornare eget risus. Integer scelerisque nibh erat, sed aliquet leo efficitur in. Mauris et augue ac erat porttitor gravida eget a justo. Curabitur nisl lectus, porta et dolor at, sollicitudin viverra libero. Nam et leo fermentum magna interdum tincidunt.",
    },
    {
      "title": "Fact 5",
      "shortDescription":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "longDescription":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris dolor justo, facilisis nec consequat at, volutpat et arcu. Vestibulum congue semper libero a congue. Vestibulum ullamcorper lectus orci, ut rhoncus ligula pharetra a. Etiam scelerisque magna nec purus vulputate, ut faucibus tortor laoreet. Sed nisi leo, dignissim at laoreet non, ornare eget risus. Integer scelerisque nibh erat, sed aliquet leo efficitur in. Mauris et augue ac erat porttitor gravida eget a justo. Curabitur nisl lectus, porta et dolor at, sollicitudin viverra libero. Nam et leo fermentum magna interdum tincidunt.",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: facts.map((e) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            color: Colors.lightBlue,
            child: ExpansionCard1(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              backgroundColor: Colors.lightGreen,
              title: Container(
                // padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      e["title"],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      e["shortDescription"],
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 100),
                  child: Text(
                    e["longDescription"],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
