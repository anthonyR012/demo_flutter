import 'package:flutter/material.dart';

class AnimatedListDemo extends StatefulWidget {
  @override
  _AnimatedListDemoState createState() => _AnimatedListDemoState();
}

class _AnimatedListDemoState extends State<AnimatedListDemo> {
  List<String> _data = ['Item 1', 'Item 2', 'Item 3'];
  final _listKey = GlobalKey<AnimatedListState>();
  final duration = const Duration(milliseconds: 700);

  @override
  void initState() {
    super.initState();
  }

  void _removeItem(int index) {
    _listKey.currentState!.removeItem(index, (context, animation) {
      Future.delayed(duration, () => _data.removeAt(index));
      return buildItem(context, index, animation);
    }, duration: duration);
  }

  void _addItem(int index) {
    _data.insert(index,'Item 4');
    _listKey.currentState!.insertItem(index,duration:duration);
  }

  Widget buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return SizeTransition(
      key: ValueKey(_data[index]),
      sizeFactor: animation,
      child: ListTile(
        title: Text(_data[index]),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            _removeItem(index);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedList Demo'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _addItem(_data.length);
          },
          label: const Text("Agregar")),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _data.length,
        itemBuilder: (context, index, animation) {
          return buildItem(context, index, animation);
        },
      ),
    );
  }
}
