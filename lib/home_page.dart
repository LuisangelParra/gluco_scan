import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.onThemeChanged});

  final VoidCallback? onThemeChanged;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GlucoScan'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onThemeChanged,
        child: Icon(Icons.color_lens),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Hello, World!'),
            ElevatedButton(onPressed: (){}, child: Text('Elevated Button')),
            TextButton(onPressed: (){}, child: Text('Text Button')),
            OutlinedButton(onPressed: (){}, child: Text('Outlined Button')),
            Switch.adaptive(value: false, onChanged: (v){})
          ],
        ),
      ),
    );
  }
}