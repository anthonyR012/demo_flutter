import 'dart:math';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int percentage = 0; // Porcentaje de carga

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Círculo de carga'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              value: percentage / 100, // Establece el valor del progreso
              strokeWidth: 10, // Ancho del círculo de carga
            ),
            SizedBox(height: 20),
            Text(
              'Cargando: $percentage%',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simula un aumento gradual del porcentaje
                if (percentage < 100) {
                  setState(() {
                    percentage += 10;
                  });
                }
              },
              child: Text('Aumentar carga'),
            ),
          ],
        ),
      ),
    );
  }
}