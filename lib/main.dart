import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kasir/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ekbunssaenfdpksjgawj.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVrYnVuc3NhZW5mZHBrc2pnYXdqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY5OTI0MDIsImV4cCI6MjA1MjU2ODQwMn0.OpstswFI0iDa5Ky6Lil3rDk2nsK9l1r_-Y5zoSdf4T8',
  );
  
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
