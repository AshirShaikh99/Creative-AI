import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:social_networking/features/auth/widgets/auth_button.dart';
import 'package:social_networking/features/auth/widgets/auth_fields.dart';
import 'package:social_networking/styles/text_style.dart';
import 'package:social_networking/theme/theme_imports.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../widgets/feature_container.dart';
import 'package:share_plus/share_plus.dart';
import '../../../services/openai_api/openai_api.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:rich_clipboard/rich_clipboard.dart';

class HomePage extends StatefulWidget {
  static route() {
    return MaterialPageRoute(
      builder: (context) => const HomePage(),
    );
  }

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final flutterTts = FlutterTts();
  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedImageUrl;
  int start = 200;
  int delay = 200;
  bool isAnimate = false;
  bool isDrawing = false;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();

    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff151419),
        appBar: AppBar(
          backgroundColor: const Color(0xff151419),
          title: BounceInDown(
            child: const Text(
              'Creative AI',
              style: TextStyle(
                fontFamily: 'Rubik',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(context, HomePage.route());
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: Pallete.border,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // chat bubble
              FadeInRight(
                child: Visibility(
                  visible: generatedImageUrl == null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
                      top: 30,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Pallete.border,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20).copyWith(
                        topLeft: Radius.zero,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        generatedContent == null
                            ? 'Good Morning, I am your instructor. How can I help you?'
                            : generatedContent!,
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: generatedContent == null ? 25 : 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (generatedContent != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.copy,
                        color: Pallete.border,
                      ),
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: generatedContent),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Copied'),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.share,
                        color: Pallete.border,
                      ),
                      onPressed: () async {
                        await Share.share(generatedContent!);
                      },
                    ),
                  ],
                ),

              if (generatedImageUrl != null)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(generatedImageUrl!),
                  ),
                ),
              SlideInLeft(
                child: Visibility(
                  visible:
                      generatedContent == null && generatedImageUrl == null,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 10, left: 22),
                    child: const Text(
                      'I can help you with',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // features list
              Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Column(
                  children: [
                    SlideInLeft(
                      delay: Duration(milliseconds: start),
                      child: const FeatureContainer(
                        color: Pallete.blockColor1,
                        headingText: 'AppWrite',
                        subHeadingText:
                            'A smarter way to get knowledge about AppWrite',
                      ),
                    ),
                    SlideInLeft(
                      delay: Duration(milliseconds: start + delay),
                      child: const FeatureContainer(
                        color: Pallete.blockColor2,
                        headingText: 'Instant Answers',
                        subHeadingText:
                            'Get knowledge from me in a matter of seconds',
                      ),
                    ),
                    SlideInLeft(
                      delay: Duration(milliseconds: start + 2 * delay),
                      child: const FeatureContainer(
                        color: Pallete.blockColor3,
                        headingText: 'Instant Drawing',
                        subHeadingText:
                            'Draw a picture by voice and I will generate it for you',
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Visibility(
                  visible: isAnimate == true ? true : false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/animation/animate.json',
                        height: 40,
                      ),
                      SizedBox(
                        width: 250.0,
                        child: AnimatedTextKit(
                          animatedTexts: [
                            ColorizeAnimatedText(
                              'I',
                              textStyle: colorizeTextStyle,
                              colors: Pallete.colorizeColors,
                            ),
                            ColorizeAnimatedText(
                              'am',
                              textStyle: colorizeTextStyle,
                              colors: Pallete.colorizeColors,
                            ),
                            ColorizeAnimatedText(
                              isDrawing == true ? 'Drawing' : 'Generating',
                              textStyle: colorizeTextStyle,
                              colors: Pallete.colorizeColors,
                            ),
                          ],
                          isRepeatingAnimation: true,
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ZoomIn(
              delay: Duration(milliseconds: start + 3 * delay),
              child: FloatingActionButton(
                backgroundColor: Pallete.floatingActionButton,
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        backgroundColor: Pallete.backgroundColor,
                        title: const Text(
                          "I am your Illustrator",
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        content: SizedBox(
                          height: 100,
                          child: Column(
                            children: [
                              AuthField(
                                hintText: "Type your illustration here",
                                controller: textEditingController,
                                color: Pallete.border,
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Pallete.floatingActionButton,
                            ),
                            onPressed: () async {
                              if (textEditingController.text.isNotEmpty) {
                                Navigator.pop(context);
                                setState(() {
                                  isDrawing = true;
                                });
                                final drawing = await openAIService
                                    .dallEAPI(textEditingController.text);
                                isDrawing = false;
                                setState(() {
                                  generatedImageUrl = drawing;
                                  generatedContent = null;
                                });
                              }
                            },
                            child: const Text(
                              'Draw',
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Icon(
                  Icons.image,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 10),
            ZoomIn(
              delay: Duration(milliseconds: start + 3 * delay),
              child: FloatingActionButton(
                backgroundColor: Pallete.floatingActionButton,
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        backgroundColor: Pallete.backgroundColor,
                        title: const Text("Ask me anything",
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            )),
                        content: SizedBox(
                          height: 100,
                          child: Column(
                            children: [
                              AuthField(
                                hintText: "Type here",
                                controller: textEditingController,
                                color: Pallete.border,
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Pallete.floatingActionButton,
                            ),
                            onPressed: () async {
                              if (textEditingController.text.isNotEmpty) {
                                Navigator.pop(context);
                                setState(() {
                                  isAnimate = true;
                                });
                                final generated = await openAIService
                                    .chatGPTAPI(textEditingController.text);
                                isAnimate = false;
                                setState(() {
                                  generatedImageUrl = null;
                                  generatedContent = generated;
                                });
                                systemSpeak(generated);
                              }
                            },
                            child: const Text(
                              'Ask',
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Icon(
                  Icons.article,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ));
  }
}
