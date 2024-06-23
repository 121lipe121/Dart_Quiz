// main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'firebase_options.dart';
import 'menu.dart'; // Importando o arquivo menu.dart
import 'temas.dart'; // Importando o arquivo temas.dart
import 'quiz.dart';
import 'package:flutter_gemini/flutter_gemini.dart'; // Importando o pacote flutter_gemini

void main() async {
  Animate.restartOnHotReload = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inicializar Gemini
  Gemini.init(apiKey: 'AIzaSyBl6_Mr_IMMc7HbyCxbusAmkxYcZ8fgefU');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz para Programadores',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const Menu(),
      routes: {
        '/temas': (context) => const TemasScreen(), // Definindo a rota para TemasScreen
        '/quiz': (context) => const QuizScreen()
      },
    );
  }
}