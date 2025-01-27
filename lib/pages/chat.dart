
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;

    BubbleStyle styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Colors.white,
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, right: 50.0),
      alignment: Alignment.topLeft,
    );
    BubbleStyle styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: Color.fromARGB(255, 225, 255, 199),
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, left: 50.0),
      alignment: Alignment.topRight,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundIconColor,
        title: Text(labels!.message),
      ),
      body: Container(
        color: Colors.yellow.withAlpha(64),
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: [
            Bubble(
              alignment: Alignment.center,
              color: Color.fromARGB(255, 212, 234, 244),
              elevation: 1 * px,
              margin: BubbleEdges.only(top: 8.0),
              child: Text('TODAY', style: TextStyle(fontSize: 10)),
            ),
            Bubble(
              style: styleSomebody,
              child: Text(
                  'Hi Jason. Sorry to bother you. I have a queston for you.'),
            ),
            Bubble(
              style: styleMe,
              child: Text('Whats\'up?'),
            ),
            Bubble(
              style: styleSomebody,
              child: Text('I\'ve been having a problem with my computer.'),
            ),
            Bubble(
              style: styleSomebody,
              margin: BubbleEdges.only(top: 2.0),
              nip: BubbleNip.no,
              child: Text('Can you help me?'),
            ),
            Bubble(
              style: styleMe,
              child: Text('Ok'),
            ),
            Bubble(
              style: styleMe,
              nip: BubbleNip.no,
              margin: BubbleEdges.only(top: 2.0),
              child: Text('What\'s the problem?'),
            ),
          ],
        ),
      ),
    );
  }
}
