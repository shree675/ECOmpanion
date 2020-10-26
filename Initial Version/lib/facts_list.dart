import 'package:flutter/material.dart';

class FactsList extends StatelessWidget {
  final facts = [
    {
      "title": "Fact 1",
      "shortDescription":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      "longDescription":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris dolor justo, facilisis nec consequat at, volutpat et arcu. Vestibulum congue semper libero a congue. Vestibulum ullamcorper lectus orci, ut rhoncus ligula pharetra a. Etiam scelerisque magna nec purus vulputate, ut faucibus tortor laoreet. Sed nisi leo, dignissim at laoreet non, ornare eget risus. Integer scelerisque nibh erat, sed aliquet leo efficitur in. Mauris et augue ac erat porttitor gravida eget a justo. Curabitur nisl lectus, porta et dolor at, sollicitudin viverra libero. Nam et leo fermentum magna interdum tincidunt.",
    },
    {
      "title": "Fact 2",
      "shortDescription":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      "longDescription":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris dolor justo, facilisis nec consequat at, volutpat et arcu. Vestibulum congue semper libero a congue. Vestibulum ullamcorper lectus orci, ut rhoncus ligula pharetra a. Etiam scelerisque magna nec purus vulputate, ut faucibus tortor laoreet. Sed nisi leo, dignissim at laoreet non, ornare eget risus. Integer scelerisque nibh erat, sed aliquet leo efficitur in. Mauris et augue ac erat porttitor gravida eget a justo. Curabitur nisl lectus, porta et dolor at, sollicitudin viverra libero. Nam et leo fermentum magna interdum tincidunt.",
    },
    {
      "title": "Fact 3",
      "shortDescription":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      "longDescription":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris dolor justo, facilisis nec consequat at, volutpat et arcu. Vestibulum congue semper libero a congue. Vestibulum ullamcorper lectus orci, ut rhoncus ligula pharetra a. Etiam scelerisque magna nec purus vulputate, ut faucibus tortor laoreet. Sed nisi leo, dignissim at laoreet non, ornare eget risus. Integer scelerisque nibh erat, sed aliquet leo efficitur in. Mauris et augue ac erat porttitor gravida eget a justo. Curabitur nisl lectus, porta et dolor at, sollicitudin viverra libero. Nam et leo fermentum magna interdum tincidunt.",
    },
    {
      "title": "Fact 4",
      "shortDescription":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      "longDescription":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris dolor justo, facilisis nec consequat at, volutpat et arcu. Vestibulum congue semper libero a congue. Vestibulum ullamcorper lectus orci, ut rhoncus ligula pharetra a. Etiam scelerisque magna nec purus vulputate, ut faucibus tortor laoreet. Sed nisi leo, dignissim at laoreet non, ornare eget risus. Integer scelerisque nibh erat, sed aliquet leo efficitur in. Mauris et augue ac erat porttitor gravida eget a justo. Curabitur nisl lectus, porta et dolor at, sollicitudin viverra libero. Nam et leo fermentum magna interdum tincidunt.",
    },
    {
      "title": "Fact 5",
      "shortDescription":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      "longDescription":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris dolor justo, facilisis nec consequat at, volutpat et arcu. Vestibulum congue semper libero a congue. Vestibulum ullamcorper lectus orci, ut rhoncus ligula pharetra a. Etiam scelerisque magna nec purus vulputate, ut faucibus tortor laoreet. Sed nisi leo, dignissim at laoreet non, ornare eget risus. Integer scelerisque nibh erat, sed aliquet leo efficitur in. Mauris et augue ac erat porttitor gravida eget a justo. Curabitur nisl lectus, porta et dolor at, sollicitudin viverra libero. Nam et leo fermentum magna interdum tincidunt.",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: facts.map((e) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Card(
            // margin: EdgeInsets.symmetric(vertical: 7),
            color: Colors.lightGreen,
            elevation: 10,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e["title"],
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(e["shortDescription"]),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
