import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_networking/apis/user_api.dart';
import 'package:social_networking/features/home/widgets/feature_container.dart';
import 'package:social_networking/models/user.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static route() {
    return MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    );
  }

  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // get the user data from the provider
  String speech = "";
  final speechToText = SpeechToText();
  @override
  void initState() {
    super.initState();
    initSpeechToText();
  } // Init State //

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {
      speechToText.isAvailable;
    });
  } // ignore: avoid_void_async

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      speech = result.recognizedWords;
    });
  } // Speech Result //

  Future<void> _startListening() async {
    await speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  } // Start Listening //

  Future<void> _stopListening() async {
    await speechToText.stop();
    setState(() {});
  } // Stop Listening //

  @override
  void dispose() {
    super.dispose();
    speechToText.stop(); // Stop Listening //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("My Instructor"),
        leading: const Icon(Icons.menu),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Hi Ashir",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 20)
                      .copyWith(top: 30),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20)
                        .copyWith(topLeft: Radius.zero, topRight: Radius.zero),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "What task can I do for you today?",
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'serif',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 22,
                  ),
                  child: const Text(
                    "Explore Features",
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'serif',
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: const [
                      FeatureContainer(
                        color: Colors.lightGreenAccent,
                        headingText: "My Instructor",
                        subHeadingText: "Get your own instructor",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FeatureContainer(
                        color: Colors.lightGreenAccent,
                        headingText: "My Instructor",
                        subHeadingText: "Get your own instructor",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FeatureContainer(
                        color: Colors.lightGreenAccent,
                        headingText: "My Instructor",
                        subHeadingText: "Get your own instructor",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            _startListening();
          } else if (speechToText.isListening) {
            await _stopListening();
          } else {
            initSpeechToText();
          }
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.mic),
      ),
    );
  }
}
