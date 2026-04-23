import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// 1. MaterialApp: Configura la aplicación y el tema visual.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Widgets Esenciales',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PantallaPrincipal(),
    );
  }
}

// 16. StatefulWidget: Permite que la pantalla maneje estados y cambios dinámicos.
class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  // 17. PageView: Controlador para permitir el deslizamiento entre páginas (swipe).
  final PageController _pageController = PageController();

  // 19. FutureBuilder: Función que simula la carga de datos asíncronos.
  Future<String> _obtenerDatos() async {
    await Future.delayed(const Duration(seconds: 2));
    return "¡Datos cargados con éxito!";
  }

  @override
  Widget build(BuildContext context) {
    // 2. Scaffold: Estructura visual básica que contiene el AppBar y el cuerpo.
    return Scaffold(
      appBar: AppBar(
        title: const Text("App de 10+ Widgets"), // 9. Text: Muestra el título.
        actions: [
          IconButton(
            icon: const Icon(Icons.ads_click), // 11. Icon: Icono interactivo.
            onPressed: () {
              // 18. Navigator: Gestiona el cambio hacia otra pantalla.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PantallaDestino()),
              );
            },
          )
        ],
      ),
      // 17. PageView: Implementación del deslizamiento lateral entre vistas.
      body: PageView(
        controller: _pageController,
        children: [
          _buildPaginaPrincipal(),
          _buildPaginaLista(),
        ],
      ),
    );
  }

  // --- PRIMERA PÁGINA (DISEÑO) ---
  Widget _buildPaginaPrincipal() {
    // 8. Center: Centra el contenido en la pantalla.
    return Center(
      // 3. Column: Organiza los widgets de manera vertical.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 10. Image: Se usa FlutterLogo para evitar errores de red.
          const FlutterLogo(size: 100),
          
          const SizedBox(height: 20),

          // 12. Padding: Crea espacios internos alrededor de un widget.
          Padding(
            padding: const EdgeInsets.all(10.0),
            // 5. Container: Caja flexible con color y estilo.
            child: Container(
              color: Colors.blue.withOpacity(0.1),
              padding: const EdgeInsets.all(10),
              child: const Text("Estructura Layout (Column/Row)"),
            ),
          ),

          // 4. Row: Organiza los widgets de manera horizontal.
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 6. Expanded: Reparte el espacio disponible proporcionalmente.
              Expanded(child: Center(child: Text("Widget A"))),
              Expanded(child: Center(child: Text("Widget B"))),
            ],
          ),

          const SizedBox(height: 20),

          // 13. TextField: Entrada para que el usuario ingrese texto.
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              decoration: InputDecoration(hintText: "Escribe algo aquí"),
            ),
          ),

          const SizedBox(height: 20),

          // 12. ElevatedButton: Botón principal para ejecutar acciones.
          ElevatedButton(
            onPressed: () {},
            child: const Text("Botón Principal"),
          ),

          const SizedBox(height: 20),

          // 14. GestureDetector: Detecta toques y muestra un SnackBar de confirmación.
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("¡Detector de gestos activado!")),
              );
            },
            child: const Card(
              color: Colors.amber,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text("<- Tócame para probar ->"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- SEGUNDA PÁGINA (LISTAS Y ASYNC) ---
  Widget _buildPaginaLista() {
    // 19. FutureBuilder: Construye la UI esperando datos asíncronos.
    return FutureBuilder<String>(
      future: _obtenerDatos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // 15. ListView: Crea una lista con desplazamiento (scroll).
        return ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: Text("Elemento de lista #${index + 1}"),
              subtitle: Text(snapshot.data ?? ""),
            );
          },
        );
      },
    );
  }
}

// 18. Navigator (Pantalla de destino).
class PantallaDestino extends StatelessWidget {
  const PantallaDestino({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Segunda Pantalla")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context), // Regresa a la pantalla anterior.
          child: const Text("Volver a Inicio"),
        ),
      ),
    );
  }
}