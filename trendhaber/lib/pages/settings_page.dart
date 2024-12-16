import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override  
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // logic eklemeye gerek yok
            }
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text('Dark Mode'),
              value: _isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text('Contact Us'),
              onTap: () {
                // logic eklencek navigation da olur buraya QR a yönlendirmeli sayfaya gidilebilir
              },
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text('Version'),
              subtitle: Text('1.0.0'), 
            ),
          ],
        ),
      ),
    );
  }
}