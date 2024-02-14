import 'package:flutter/material.dart';

class ResponsiveApp extends StatelessWidget {
  const ResponsiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 400) {
            return Center(
              child: SizedBox(
                width: 100,
                child: Text("Small screen",
                    style: TextStyle(color: Colors.green, fontSize: 20)),
              ),
            );
          } else {
            return Center(
              child: SizedBox(
                width: 100,
                child: Text("Big screen",
                    style: TextStyle(color: Colors.red, fontSize: 20)),
              ),
            );
          }
        },
      ),
    );
  }
}
