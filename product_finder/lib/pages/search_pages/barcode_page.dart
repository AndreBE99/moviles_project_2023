import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_finder/pages/product/bloc/product_bloc.dart';
import 'package:product_finder/pages/result_list_page.dart';

void main() => runApp(BarCodePage());

class BarCodePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<BarCodePage> {
  String _scanBarcode = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black,
                  Colors.grey,
                ],
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('Search by Barcode'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/buscar1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(4, 20, 4, 15),
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(4),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () => scanBarcodeNormal(),
                    child: Text('Start barcode Scan'),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 15),
                child: SizedBox(
                  width: 125,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      BlocProvider.of<ProductBloc>(context).add(
                          LoadProductListEvent(
                              searchValue: _scanBarcode, op: true));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BlocBuilder<ProductBloc, ProductState>(
                            builder: (context, state) {
                              if (state is ProductListLoadedState) {
                                return ResultList(products: state.productList);
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                        ),
                      );
                    },
                    child: Text('Search'),
                  ),
                ),
              ),
            ),
            Text(
              'Scan result: $_scanBarcode \n',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}
