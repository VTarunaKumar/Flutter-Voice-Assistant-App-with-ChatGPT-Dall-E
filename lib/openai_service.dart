import 'dart:convert';

import 'package:flutter_voice_assistant_chatgpt_dall_e/secrets.dart';
import 'package:http/http.dart' as http;

class OpenAIService{
  Future<String> isArtPromptAPI(String prompt) async {
    try{
      final res = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
          headers: {
            'Content-Type' : 'application/json' ,
            "Authorization" : "Bearer $openAPIKey"
          },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [{"role": "user","content": "Does this message want to generate  an AI picture , image , art or any similar ? $prompt . Simply answer with yes or no . "}]
      })

      );
      print(res.body);
      if(res.statusCode == 200){
        String content = jsonDecode(res.body)['choices'][0]['message']['content'];
        content.trim();
        switch(content){
          case 'Yes':
          case 'yes':
          case 'Yes.':
          case 'yes.':
            final res = await chatGPTAPI(prompt);
            return res;
          default :
            final res = await chatGPTAPI(prompt);
            return res;

        }


      }
      return "An internal error occurred";
    }catch(e){
      return e.toString();

    }
  }
  Future<String> chatGPTAPI(String prompt) async {
           return "Chat GPT";
  }
  Future<String> dallEAPI(String prompt) async {
       return "dall-E";
  }
  
}