import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/app.dart';
import 'package:whatsapp/core/di/dependency_injection.dart';
import 'package:whatsapp/core/networking/result.dart';
import 'package:whatsapp/feature/chat/data/models/user_model.dart';
import 'package:whatsapp/feature/chat/data/repository/chat_repo.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const WhatsApp());
}