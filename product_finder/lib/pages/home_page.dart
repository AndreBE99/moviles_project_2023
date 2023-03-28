import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool bandera = false;

  void cambiarBandera() {
    setState(() {
      bandera = true;
    });
  }

  void cambiarBanderaYRecargar() {
    setState(() {
      bandera = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      home: Scaffold(
        appBar: AppBar(
          title: Text('MyApp'),
        ),
        body: Center(
          child: bandera
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => cambiarBanderaYRecargar(),
                      child: Text('Botón 1'),
                    ),
                    ElevatedButton(
                      onPressed: () => cambiarBanderaYRecargar(),
                      child: Text('Botón 2'),
                    ),
                    ElevatedButton(
                      onPressed: () => cambiarBanderaYRecargar(),
                      child: Text('Botón 3'),
                    ),
                  ],
                )
              : ElevatedButton(
                  onPressed: () => cambiarBandera(),
                  child: Text('Botón'),
                ),
        ),
      ),
    );
  }
}
