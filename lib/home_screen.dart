import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    IconData genderIcon = theme.gender == 'mujer' ? Icons.female : Icons.male;

    return Scaffold(
      appBar: AppBar(
        title: Container(
          color: theme.primaryColor.shade200,
          padding: const EdgeInsets.all(8),
          child: Text('¡Bienvenid@ ${theme.name}!', style: TextStyle(fontSize: 20)),
        ),
        backgroundColor: theme.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 6,
              color: theme.primaryColor.shade100,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: theme.primaryColor,
                      child: Icon(genderIcon, size: 40, color: Colors.white),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nombre: ${theme.name}', style: TextStyle(fontSize: theme.fontSize)),
                           Text('Apellido: ${theme.lastname}', style: TextStyle(fontSize: theme.fontSize)),
                          Text('Edad: ${theme.age}', style: TextStyle(fontSize: theme.fontSize)),
                          Text('Teléfono: ${theme.phone}', style: TextStyle(fontSize: theme.fontSize)),
                          Text('Correo: ${theme.email}', style: TextStyle(fontSize: theme.fontSize)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            const Text(
              'Mariluz Gayosso Vargas',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
