import 'package:flutter/material.dart';
import 'package:flutter_voice_assistant_chatgpt_dall_e/feature_box.dart';
import 'package:flutter_voice_assistant_chatgpt_dall_e/pallete.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  String lastWords = '';


   @override
  void initState() {
    super.initState();
    initSpeechToText();
  }
   Future<void> initSpeechToText() async {
     await speechToText.initialize();
     setState(() {

     });

   }
  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }


  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }


  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }





   @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:const Text("Jarvis"),
        leading: const Icon(Icons.menu),
        centerTitle: true,
        backgroundColor: Pallete.whiteColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
              Stack(children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle,
                    )
                    ,
                  ),
                ),
                Container(
                  height: 123,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage('assets/images/virtualAssistant.png',
                    ),
                    ),
                  ),
                ),
              ],),
            //chat bubble
            Container(
               padding: const EdgeInsets.symmetric(
                 horizontal: 20,
                 vertical: 10,
               ),
              margin: const EdgeInsets.symmetric(horizontal:40).copyWith(top: 30,),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Pallete.borderColor,
                ),borderRadius: BorderRadius.circular(20).copyWith(
                topLeft: Radius.zero,bottomRight: Radius.zero),
              ),
    child: const Padding(
    padding:  EdgeInsets.symmetric(vertical: 10.0),
    child:  Text("Good Morning , what task i can do for you ?",style: TextStyle(
    color: Pallete.mainFontColor,
    fontSize: 25,
    fontFamily: 'Cera Pro'
    ),),
    ),
              ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 10,left: 22),
              alignment: Alignment.centerLeft,
              child: const Text("Here are few features",
              style: TextStyle(
                fontFamily: 'Cera Pro',
                color: Pallete.mainFontColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
            //features list
            Column(
              children: const [
                FeatureBox(color: Pallete.firstSuggestionBoxColor, headerText: 'ChatGpt',descriptionText: 'A smarter way to stay organized and informed with ChatGPT',),
             FeatureBox(color: Pallete.secondSuggestionBoxColor, headerText: 'Dall-E', descriptionText: "Get inspired and stay creative with your personal assistant powered by Dall-E"),
                FeatureBox(color: Pallete.thirdSuggestionBoxColor, headerText: 'Smart Voice Assistant', descriptionText: "Get the best of both worlds with a voice assistant powered by ChatGPT and Dall-E ")
              ],
            ),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.firstSuggestionBoxColor,
        onPressed: () async {
          if(await speechToText.hasPermission && speechToText.isNotListening)
          {
            await startListening();
          }
          else if(speechToText.isListening){
           await stopListening();
          }
          else{
            initSpeechToText();
          }
        },
        child: const Icon(Icons.mic),
      ),
    );
  }
}
