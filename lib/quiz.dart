import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'dart:async';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String question = 'Carregando...';
  int level = 1; // Estado para o nível do jogo
  late String tema;
  int _timeLeft = 15; // Tempo restante em segundos
  Timer? _timer;
  double _progress = 1.0; // Progresso da barra de tempo
  bool _isLoading = true; // Estado para carregamento

  @override
  void initState() {
    super.initState();
    // Recupera o argumento passado pela navegação
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as String?;
      if (args != null) {
        tema = args;
        _loadQuestion();
      } else {
        setState(() {
          question = 'Erro: Tema não especificado';
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Color getColor(double value) {
    if (value > 0.5) {
      return Color.lerp(Colors.yellow, Colors.green, (value - 0.5) * 2)!;
    } else {
      return Color.lerp(Colors.red, Colors.yellow, value * 2)!;
    }
  }

  Future<void> _loadQuestion() async {
    setState(() {
      _isLoading = true;
    });
    final gemini = Gemini.instance;
    try {
      final response = await gemini.text(
        "Estamos em um jogo de quiz sobre $tema onde a dificuldade começa em 1, quanto maior o numero da dificuldade mais difíceis são as perguntas\n\nVocê ira fazer uma pequena pergunta de dificuldade $level sobre o tema, e dar 4 opções sendo A, B, C ou D\n\nE lembre de dar APENAS UMA opção correta e nunca escrever qual é a resposta.\n\nSua resposta DEVE SER APENAS assim:\n\nTema:\n\nPergunta sobre o tema\n\nA:\nB:\nC:\nD:\n\n"
      );
      setState(() {
        question = response?.output?.replaceAll(RegExp(r'[*]'), '') ?? 'Erro ao carregar a pergunta';
        _isLoading = false;
        _startTimer();
      });
    } catch (e) {
      setState(() {
        question = 'Erro ao carregar a pergunta';
        _isLoading = false;
      });
      print(e);
    }
  }

  void _startTimer() {
    setState(() {
      _timeLeft = 15;
      _progress = 1.0;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
          _progress = _timeLeft / 15;
        });
      } else {
        timer.cancel();
        _onTimeExpired();
      }
    });
  }

    void _pauseTimer() {
    _timer?.cancel();
  }

  void _onTimeExpired() {
    // Lógica para lidar com o tempo expirado
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tempo Esgotado'),
        content: const Text('O tempo para responder a pergunta esgotou.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Voltar ao menu'),
          ),
        ],
      ),
    );
  }

  Future<void> _checkAnswer(String answer) async {
    _pauseTimer();
    final gemini = Gemini.instance;
    final prompt = "De acordo com a pergunta a seguir:\n\n[$question]\n\nA resposta $answer está correta?\n\nResponda apenas com 'Yes' ou 'No'";
    try {
      final response = await gemini.text(prompt);
      final result = response?.output?.trim() ?? 'Erro';
      if (result == 'Yes') {
        _showResultDialog('Parabéns', 'Você acertou!', true);
      } else {
        _showResultDialog('Tente novamente', 'Você errou!', false);
      }
    } catch (e) {
      print(e);
      _showResultDialog('Erro', 'Erro ao verificar a resposta.', false);
    }
  }

  void _showResultDialog(String title, String content, bool correct) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (correct) {
                setState(() {
                  level += 1; // Incrementar o nível
                  question = 'Carregando...';
                  _timeLeft = 15;
                  _progress = 1.0;
                });
                _loadQuestion(); // Carregar nova pergunta
              } else {
                Navigator.of(context).pop();
              }
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF002366),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.cyan),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: const Color(0xFF002366),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Level $level',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              question,
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ), 
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Tempo restante: $_timeLeft segundos',
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.grey[300],
              color: getColor(_progress),
            ),
            const SizedBox(height: 24),
            OptionButton(label: 'A.', onPressed: () => _checkAnswer('A')),
            OptionButton(label: 'B.', onPressed: () => _checkAnswer('B')),
            OptionButton(label: 'C.', onPressed: () => _checkAnswer('C')),
            OptionButton(label: 'D.', onPressed: () => _checkAnswer('D')),
          ],
        ),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const OptionButton({super.key, 
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          textStyle: const TextStyle(fontSize: 18),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

