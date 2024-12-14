import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override  
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Add your settings action here
            }
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Contact Us'),
              onTap: () {
                
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