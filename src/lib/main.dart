import 'package:flutter/material.dart';
import 'ui/core/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  void _showMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You typed: $text')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Flutter UI')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Enter your name:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Type here...',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showMessage,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

