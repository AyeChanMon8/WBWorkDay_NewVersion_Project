

import 'dart:io';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import '../my_class/my_app_bar.dart';
class PdfView extends StatefulWidget {
  String pathPDF;
  String display_name;
  PdfView(this.pathPDF,this.display_name);
  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  late PDFDocument doc;
  @override
  void initState() async{
    super.initState();
    File file = File(widget.pathPDF);
     doc = await PDFDocument.fromFile(file);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Example'),
      ),
      body: Center(child:PDFViewer(document: doc)),
    );
  }
   /* return PDFViewerScaffold(
        appBar: AppBar(
          title: Text(widget.display_name),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
        path:widget.pathPDF);
  }*/
}

