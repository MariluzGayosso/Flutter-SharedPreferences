import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool isDarkTheme;
  late double fontSize;
  late MaterialColor selectedColor;
  final nameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  String gender = 'otro';

  @override
  void initState() {
    super.initState();
    final theme = Provider.of<ThemeProvider>(context, listen: false);
    isDarkTheme = theme.isDarkTheme;
    fontSize = theme.fontSize;
    selectedColor = theme.primaryColor;
    nameController.text = theme.name;
    lastnameController.text = theme.lastname;
    emailController.text = theme.email;
    phoneController.text = theme.phone;
    ageController.text = theme.age;
    gender = theme.gender;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        backgroundColor: theme.primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Tema Oscuro'),
            value: isDarkTheme,
            onChanged: (val) {
              setState(() => isDarkTheme = val);
              theme.toggleTheme(val); // Aplicar inmediatamente
            },
          ),
          const SizedBox(height: 16),
          const Text('Tamaño de Fuente'),
          Slider(
            min: 10,
            max: 30,
            divisions: 9,
            value: fontSize,
            onChanged: (val) {
              setState(() => fontSize = val);
              theme.setFontSize(val); // Aplicar inmediatamente
            },
          ),
          const SizedBox(height: 16),
          const Text('Color Primario'),
          Wrap(
            spacing: 10,
            children: [
              colorCircle(Colors.blue),
              colorCircle(Colors.red),
              colorCircle(Colors.green),
              colorCircle(Colors.purple),
              colorCircle(Colors.pink),
            ],
          ),
          const SizedBox(height: 16),
          TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Nombre')),
          TextField(controller: lastnameController, decoration: const InputDecoration(labelText: 'Apellido')),
          TextField(controller: ageController, decoration: const InputDecoration(labelText: 'Edad')),
          TextField(controller: phoneController, decoration: const InputDecoration(labelText: 'Teléfono')),
          TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Correo')),

          const SizedBox(height: 26),
          const Text('Género'),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  title: const Text('Hombre'),
                  value: 'hombre',
                  groupValue: gender,
                  onChanged: (val) => setState(() => gender = val!),
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: const Text('Mujer'),
                  value: 'mujer',
                  groupValue: gender,
                  onChanged: (val) => setState(() => gender = val!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              theme.setPrimaryColor(selectedColor);
              theme.setUserData(
                nameController.text,
                lastnameController.text,
                emailController.text,
                phoneController.text,
                ageController.text,
                gender,
              );
              Navigator.pop(context);
            },
            child: const Text('Guardar'),
          ),
          TextButton(
            onPressed: () {
              theme.resetPreferences();
              setState(() {
                isDarkTheme = false;
                fontSize = 16;
                selectedColor = Colors.blue;
                nameController.clear();
                lastnameController.clear();
                emailController.clear();
                phoneController.clear();
                ageController.clear();
                gender = 'otro';
              });
            },
            child: const Text('Restablecer'),
          )
        ],
      ),
    );
  }

  Widget colorCircle(MaterialColor color) {
    return GestureDetector(
      onTap: () {
        setState(() => selectedColor = color);
        Provider.of<ThemeProvider>(context, listen: false).setPrimaryColor(color);
      },
      child: CircleAvatar(
        backgroundColor: color,
        child: selectedColor == color ? const Icon(Icons.check, color: Colors.white) : null,
      ),
    );
  }
}
