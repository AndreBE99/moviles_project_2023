import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:speech_to_text/speech_recognition_result.dart";
import 'package:speech_to_text/speech_to_text.dart';
import 'package:product_finder/pages/product/bloc/product_bloc.dart';
import 'package:product_finder/pages/result_list_page.dart';

void main() {
  runApp(SpeechPage());
}

class SpeechPage extends StatefulWidget {
  SpeechPage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SpeechPage> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
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
        title: Text('Search by Voice'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/buscar2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: _speechToText.isNotListening
                  ? _startListening
                  : _stopListening,
              child: Icon(
                  _speechToText.isNotListening ? Icons.mic_off : Icons.mic),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  // If listening is active show the recognized words
                  _speechToText.isListening
                      ? '$_lastWords'
                      // If listening isn't active but could be tell the user
                      // how to start it, otherwise indicate that speech
                      // recognition is not yet ready or not supported on
                      // the target device
                      : _speechEnabled
                          ? 'Tap the microphone to start listening...'
                          : 'Speech not available',
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
                              searchValue: _lastWords, op: false, range: -1));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BlocBuilder<ProductBloc, ProductState>(
                            builder: (context, state) {
                              if (state is ProductListLoadedState) {
                                return ResultList(
                                  products: state.productList,
                                  range: -1,
                                );
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
              'Scan results : $_lastWords \n',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
