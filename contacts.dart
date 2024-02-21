import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'My Contacts',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 243, 111, 232),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Cassy: +250788719187'),
              onTap: () {
                // Implement phone call functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Jane: +250788719188'),
              onTap: () {
                // Implement phone call functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Alice: +250788719189'),
              onTap: () {
                // Implement phone call functionality
              },
            ),
            // Add more contacts here as needed
          ],
        ),
      ),
    );
  }
}
