import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.onThemeChanged});

  final VoidCallback? onThemeChanged;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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