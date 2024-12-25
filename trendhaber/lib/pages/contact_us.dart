import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    //for QR colors to be able to change
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color qrColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Spacer(), 
            Row(
              //to make QR's centered
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        'Doruk Artan',
                        style: TextStyle(fontSize: 40.0),
                        ),
                    ),
                    QrImageView(
                      //Flutter automatically converts URL's into QR with specific dependencies
                      data: 'https://bento.me/doruk-artan',
                      version: QrVersions.auto,
                      size: 400.0,
                      eyeStyle: QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: qrColor,
                      ),
                      dataModuleStyle: QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: qrColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 200), 
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        'Ata Sesli',
                        style: TextStyle(fontSize: 40.0),
                        ),
                    ),
                    QrImageView(
                      data: 'https://bento.me/ata-sesli',
                      version: QrVersions.auto,
                      size: 400.0,
                      eyeStyle: QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: qrColor,
                      ),
                      dataModuleStyle: QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: qrColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}