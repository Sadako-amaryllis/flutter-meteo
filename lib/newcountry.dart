import 'package:flutter/material.dart';

class NewCountryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Contenu de la nouvelle page
    return Scaffold(
      appBar: AppBar(
        title: Text('Nouvelle Page'),
      ),
      body: Center(
        child: Text('Contenu de la nouvelle page'),
      ),
    );
  }
}

