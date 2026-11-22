
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
      home: const InicioPage(),
    );
  }
}

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  bool cargando = true;
  bool registrada = false;

  @override
  void initState() {
    super.initState();
    comprobarCuenta();
  }

  Future<void> comprobarCuenta() async {
    final prefs = await SharedPreferences.getInstance();
    final existe = prefs.getBool('cuenta_creada') ?? false;

    if (!mounted) return;

    setState(() {
      registrada = existe;
      cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (cargando) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return registrada
        ? const PrincipalPage()
        : const BienvenidaPage();
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
                  style: TextStyle(letterSpacing: 4),
                ),
                const SizedBox(height: 20),
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

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const PrincipalPage(),
        ),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;

      setState(() => cargando = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al guardar los datos'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear mi cuenta')),
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

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  String nombre = '';
  String apellido = '';
  String telefono = '';

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      nombre = prefs.getString('cliente_nombre') ?? '';
      apellido = prefs.getString('cliente_apellido') ?? '';
      telefono = prefs.getString('cliente_telefono') ?? '';
    });
  }

  void mostrarOpcion(String titulo) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$titulo: próximamente en IOSTEC'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'IOSTEC CLIENTES',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.phone_iphone,
              color: Color(0xFF168BFF),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 15),
              const Icon(
                Icons.account_circle,
                size: 75,
                color: Color(0xFF168BFF),
              ),
              const SizedBox(height: 15),
              Text(
                '¡Hola, $nombre!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Bienvenido a tu espacio de cliente.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 35),
              opcion(
                Icons.phone_android,
                'Mis reparaciones',
                'Consulta el estado de tus reparaciones.',
                () => mostrarOpcion('Mis reparaciones'),
              ),
              opcion(
                Icons.history,
                'Mi historial',
                'Consulta tus servicios anteriores.',
                () => mostrarOpcion('Mi historial'),
              ),
              opcion(
                Icons.support_agent,
                'Soporte técnico',
                'Contacta con el equipo IOSTEC.',
                () => mostrarOpcion('Soporte técnico'),
              ),
              opcion(
                Icons.person,
                'Mi perfil',
                'Consulta tus datos personales.',
                () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Mi perfil'),
                      content: Text(
                        'Nombre: $nombre\n'
                        'Apellido: $apellido\n'
                        'Teléfono: $telefono',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('CERRAR'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 35),
              const Text(
                'IOSTEC ASISTENCIA TÉCNICA',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF168BFF),
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tu celular siempre en buenas manos.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget opcion(
    IconData icono,
    String titulo,
    String descripcion,
    VoidCallback accion,
  ) {
    return Card(
      color: const Color(0xFF102C50),
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: Icon(
          icono,
          color: const Color(0xFF168BFF),
          size: 32,
        ),
        title: Text(
          titulo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(descripcion),
        trailing: const Icon(Icons.arrow_forward_ios, size: 17),
        onTap: accion,
      ),
    );
  }
}
