
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                const SizedBox(height: 30),
                const Text('Soporte técnico IOSTEC'),
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

  bool cargando = false;

  @override
  void dispose() {
    nombre.dispose();
    apellido.dispose();
    telefono.dispose();
    super.dispose();
  }

  Future<void> crearCuenta() async {
    if (nombre.text.trim().isEmpty ||
        apellido.text.trim().isEmpty ||
        telefono.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Completa todos los campos'),
        ),
      );
      return;
    }

    setState(() => cargando = true);

    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('cliente_nombre', nombre.text.trim());
      await prefs.setString('cliente_apellido', apellido.text.trim());
      await prefs.setString('cliente_telefono', telefono.text.trim());
      await prefs.setBool('cuenta_creada', true);

      if (!mounted) return;

      setState(() => cargando = false);

      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('¡Bienvenido a IOSTEC!'),
          content: const Text(
            'Tu cuenta fue creada correctamente.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.pop(context);
              },
              child: const Text('ACEPTAR'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() => cargando = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo guardar la cuenta. Intenta nuevamente.'),
        ),
      );
    }
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
                'Completa tus datos para crear tu cuenta.',
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
                  onPressed: cargando ? null : crearCuenta,
                  child: cargando
                      ? const CircularProgressIndicator()
                      : const Text('CREAR MI CUENTA'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
