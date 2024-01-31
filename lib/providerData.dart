import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyState extends ChangeNotifier {
  bool _isActive = false;
  String data = "";
  bool get isActive => _isActive;

  void setData(String data) {
    this.data = data;
  }

  void toggleActive() {
    _isActive = !_isActive;
    notifyListeners();
  }
}

class MyAppProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Widget1(),
            // Widget2(),
          ],
        ),
      ),
    );
  }
}

class Widget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyState>(
      builder: (context, myState, child) {
        return Column(
          children: [
            Text(
                'Widget1 - is_active: ${myState.isActive} +  data: ${myState.data}'),
            ElevatedButton(
              onPressed: () {
                myState.setData("Seteo data desde mi widget 1");
                myState.toggleActive();
              },
              child: Text('Toggle Active'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Widget2()));
              },
              child: Text('go to widget2'),
            ),
          ],
        );
      },
    );
  }
}

class Widget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyState>(
      builder: (context, myState, child) {
        return Scaffold(
            body: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                'Widget2 - is_active: ${myState.isActive} +  data: ${myState.data}'),
            ElevatedButton(
              onPressed: () {
                myState.setData("Seteo data desde mi widget 2");
                myState.toggleActive();
              },
              child: Text('Toggle Active'),
            ),
          ],
        )));
      },
    );
  }
}
