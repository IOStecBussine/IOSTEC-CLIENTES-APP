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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF087CF0),
          brightness: Brightness.dark,
        ),
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
                  style: TextStyle(fontSize: 14, letterSpacing: 4),
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegistroPage(),
                        ),
                      );
                    },
                    child: const Text('CREAR MI CUENTA'),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegistroPage(),
                        ),
                      );
                    },
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
class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final nombre = TextEditingController();
  final apellido = TextEditingController();
  final telefono = TextEditingController();

  @override
  void dispose() {
    nombre.dispose();
    apellido.dispose();
    telefono.dispose();
    super.dispose();
  }

  void continuar() {
    if (nombre.text.trim().isEmpty ||
        apellido.text.trim().isEmpty ||
        telefono.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Completa todos los campos para continuar'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Datos completados. Verificación pendiente.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear mi cuenta'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.account_circle,
                size: 85,
                color: Color(0xFF168BFF),
              ),
              const SizedBox(height: 20),
              const Text(
                '¡Bienvenido a IOSTEC!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Registra tus datos para crear tu cuenta.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextField(
                controller: nombre,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: apellido,
                decoration: const InputDecoration(
                  labelText: 'Apellido',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: telefono,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Número de teléfono',
                  hintText: '+595...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: continuar,
                  child: const Text('CONTINUAR'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
