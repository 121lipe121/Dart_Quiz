import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';

Future<String?> generateGeminiContent() async {
  // Acessa a chave API a partir de uma variável de ambiente
  final apiKey = Platform.environment['API_KEY'];
  if (apiKey == null) {
    return 'No \$API_KEY environment variable';
  }

  // Configura o modelo Generative AI
  final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
  final content = [Content.text('Write a story about a magic backpack.')];
  final response = await model.generateContent(content);
  print(response);
  return response.text;
}
