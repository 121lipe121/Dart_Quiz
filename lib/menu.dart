// menu.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 164, 164, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 50),
            // Row superior com imagens
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(
                  '../assets/images/js.png',
                  height: 50,
                ).animate(
                  onPlay: (controller) => controller.repeat(),
                )
                    .shake(delay: 5500.ms),
                const Spacer(flex: 2),
                Image.asset(
                  '../assets/images/python.png',
                  height: 50,
                ).animate(
                  onPlay: (controller) => controller.repeat(),
                )
                    .shake(delay: 5500.ms),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 10),
            // Imagem principal da logo
            Image.asset(
              '../assets/images/logoquiz.png',
              height: 300,
            ).animate(
              onPlay: (controller) => controller.repeat(),
            )
            .moveY(begin: -25, end: 15, curve: Curves.easeInOut, duration: 1800.ms)
            .then()
            .moveY(begin: 15, end: -25, curve: Curves.easeInOut),
            const SizedBox(height: 10),
            // Row inferior com imagens
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(
                  '../assets/images/c.png',
                  height: 50,
                ).animate(
                  onPlay: (controller) => controller.repeat(),
                )
                    .shake(delay: 5500.ms),
                const Spacer(flex: 2),
                Image.asset(
                  '../assets/images/dart.png',
                  height: 50,
                ).animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .shake(delay: 5500.ms),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 80),
            const Text(
              'Quiz para Programadores',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ).animate(
              onPlay: (controller) => controller.repeat(),
            )
            .shimmer(delay: 5000.ms, duration: 1000.ms),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/quiz', arguments: 'Programação');
              },
              child: const Text(
                'Jogo Rápido',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 84, vertical: 15),
                textStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/temas');
              },
              child: const Text(
                'Temas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}