import 'package:flutter/material.dart';

void main() {
  runApp(const IostecClientesApp());
}

class IostecClientesApp extends StatelessWidget {
  const IostecClientesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IOSTEC CLIENTES',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF06152F),
        primaryColor: const Color(0xFF087CF0),
        useMaterial3: true,
      ),
      home: const BienvenidaPage(),
    );
  }
}

class BienvenidaPage extends StatelessWidget {
  const BienvenidaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.phone_iphone,
                  size: 95,
                  color: Color(0xFF168BFF),
                ),
                const SizedBox(height: 25),
                const Text(
                  'IOSTEC',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
                const Text(
                  'ASISTENCIA TÉCNICA',
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Tu celular siempre en buenas manos.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 45),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('CREAR MI CUENTA'),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('INICIAR SESIÓN'),
                  ),
                ),
                const SizedBox(height: 30),
                const Text('Soporte técnico por WhatsApp'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
