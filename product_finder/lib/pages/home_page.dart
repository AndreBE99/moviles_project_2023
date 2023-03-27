import 'package:flutter/material.dart';
import 'package:product_finder/pages/search_pages/barcode_page.dart';
import 'package:product_finder/pages/search_pages/speech_page.dart';
import 'package:product_finder/pages/search_pages/text_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TextPage()),
                );
              },
              child: Text("Text Page"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SpeechPage()),
                );
              },
              child: Text("Speech Page"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BarCodePage()),
                );
              },
              child: Text("Barcode Page"),
            ),
          ],
        ),
      ),
    );
  }
}
