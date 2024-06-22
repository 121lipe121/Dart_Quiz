import 'package:flutter/material.dart';

class TemasScreen extends StatelessWidget {
  const TemasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 164, 164, 255), // Cor de fundo azul escuro
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 164, 164, 255), // Cor de fundo do AppBar igual ao fundo
        elevation: 0, // Remove a sombra do AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.cyan), // Ícone de seta para voltar
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A0DAD), // Cor roxa
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text(
                'Temas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Define duas colunas
                crossAxisSpacing: 20, // Espaçamento horizontal entre os itens
                mainAxisSpacing: 20, // Espaçamento vertical entre os itens
                childAspectRatio: 9, // Ajusta a proporção dos itens
                children: [
                  _buildTemaButton('Logos'),
                  _buildTemaButton('Sintaxe'),
                  _buildTemaButton('Dart'),
                  _buildTemaButton('Java'),
                  _buildTemaButton('JS'),
                  _buildTemaButton('Python'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemaButton(String text) {
    return AspectRatio(
      aspectRatio: 2.5, // Ajusta a proporção do botão
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6A0DAD), // Cor roxa
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
