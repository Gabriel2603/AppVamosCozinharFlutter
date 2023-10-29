import 'package:flutter/material.dart';
import '../components/main_drawer.dart';
import '../models/settings.dart';

class SettingsScreen extends StatefulWidget {
  final Settings? settings;
  final Function(Settings) onSettingsChanged;
  const SettingsScreen(
      {super.key, required this.onSettingsChanged, required this.settings});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Settings? settings;

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  Widget _createSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool?) onChanged,
  ) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (value) {
        onChanged(value);
        widget.onSettingsChanged(settings!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Configurações",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _createSwitch(
                  "Sem Glutén",
                  "Só exibe refeições sem glutén",
                  settings!.isGlutenFree,
                  (value) {
                    setState(() {
                      settings!.isGlutenFree = value ?? true;
                    });
                  },
                ),
                _createSwitch(
                  "Sem Lactose",
                  "Só exibe refeições sem Lactose",
                  settings!.isLactoseFree,
                  (value) {
                    setState(() {
                      settings!.isLactoseFree = value ?? true;
                    });
                  },
                ),
                _createSwitch(
                  "Vegana",
                  "Só exibe refeições sem Vegana",
                  settings!.isVegan,
                  (value) {
                    setState(() {
                      settings!.isVegan = value ?? true;
                    });
                  },
                ),
                _createSwitch(
                  "Vegetariana",
                  "Só exibe refeições sem Vegetariana",
                  settings!.isVegetarian,
                  (value) {
                    setState(() {
                      settings!.isVegetarian = value ?? true;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
