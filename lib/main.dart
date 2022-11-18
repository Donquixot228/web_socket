import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

List<Socket> clients = [];

void handleConnection(Socket client) {
  client.listen((data) {
    final message = String.fromCharCodes(data).trim();
    log('Received: $message');
    clients.forEach((client) {
      client.write("Server: $message joined the party!");
    });
  }, onError: (error) {
    log(error);
    client.close();
  }, onDone: () {
    log('Server: Client left');
    client.close();
  });
}

Future<void> main() async {
  final ip = InternetAddress.anyIPv4;
  final server = await ServerSocket.bind(ip, 3000);
  print("Server is running on ${server.address.address}:${server.port}");
  server.listen((Socket event) {
    print("Server: New client connected");
    handleConnection(event);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Web Sockets'),
      ),
    );
  }
}
