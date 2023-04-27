import 'package:flutter/material.dart';
// import 'package:product_finder/pages/login_page.dart';

// class HomePage extends StatefulWidget {
//   HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   bool bandera = true;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Scaffold(
//             body: bandera ? home() : LoginPage(),
//           ),
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

class home extends StatelessWidget {
  const home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/login_bg.jpg',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.25,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35),
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(0, -60), // mueve 20 pixeles hacia arriba
                  child: Text(
                    'ProductFinder',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 15),
                    child: Text(
                      "Buscar por",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(4, 20, 4, 15),
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        MaterialPageRoute(
                            builder: (context) =>
                                HomePage()); // Cambiar por el correcto
                      },
                      child: Text(
                        'Texto',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 15),
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        MaterialPageRoute(
                            builder: (context) =>
                                HomePage()); // Cambiar por el correcto
                      },
                      child: Text(
                        'Speech to text',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 15),
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        MaterialPageRoute(
                            builder: (context) =>
                                HomePage()); // Cambiar por el correcto
                      },
                      child: Text(
                        'Código de barra',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Row()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
