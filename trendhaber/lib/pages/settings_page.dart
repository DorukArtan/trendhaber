import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trendhaber/provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});
  @override  
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = ref.watch(darkModeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
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
                ref.read(darkModeProvider.notifier).state = value;
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