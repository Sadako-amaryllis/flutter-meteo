import 'package:flutter/material.dart';

class NewCountry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouvelle Page'),
      ),
      body: const Center(
        child: Text('Contenu de la nouvelle page'),
      ),
    );
  }
}
