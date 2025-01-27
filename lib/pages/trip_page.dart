// import 'package:fdottedline/fdottedline.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TripPage extends StatefulWidget {
  @override
  _TripPageState createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  List data = [
    {"id": "1", "name": "Test1"},
    {"id": "2", "name": "Test2"},
    {"id": "3", "name": "Test3"},
    {"id": "4", "name": "Test4"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ("trips"),
          style: TextStyle(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(8.0),
          child: Container(
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  const Color.fromRGBO(216, 181, 0, 1),
                  const Color.fromRGBO(231, 235, 235, 1)
                ],
              ),
            ),
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 5),
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(216, 181, 0, 1),
              child: ClipRRect(
                borderRadius: new BorderRadius.circular(50.0),
                child: Image.network(
                  "https://machinecurve.com/wp-content/uploads/2019/07/thispersondoesnotexist-1-1022x1024.jpg",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: List.generate(data.length, (index) {
            return Container(
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.circle,
                        color: Color.fromRGBO(60, 47, 126, 1),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      DottedLine(
                        lineThickness: 1.0,
                        dashLength: 10.0,
                        dashColor: Color.fromRGBO(60, 47, 126, 1)
                      )
                      // DottedLine(
                      //   color: Color.fromRGBO(60, 47, 126, 1),
                      //   height: 100.0,
                      //   strokeWidth: 2.0,
                      //   dottedLength: 10.0,
                      //   space: 2.0,
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "Current Location",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                              "No 432,thunandarRoad North Okkalapa Yangon"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "7 km",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "10000 Ks / 8000 Ks",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Color.fromRGBO(60, 47, 126, 1))),
                      ),
                      // color: Colors.white,
                      // shape: RoundedRectangleBorder(
                      //     side: BorderSide(
                      //         color: Color.fromRGBO(60, 47, 126, 1))),
                      child: Text("Start"),
                      onPressed: () {},
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Color.fromRGBO(60, 47, 126, 1),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
