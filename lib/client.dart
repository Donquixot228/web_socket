import 'dart:io';

Future<void> main() async {
  final socket = await Socket.connect('0.0.0.0', 3000);
  print(
      'Client: Connect to: ${socket.remoteAddress.address}:${socket.remotePort}');

  socket.listen((data) {
    final serverResponse = String.fromCharCodes(data).trim();
    print('Client: $serverResponse');
  }, onError: (error) {
    print(error);
    socket.destroy();
  }, onDone: () {
    print('Client: Server left');
    socket.destroy();
  });
  String? username;

  do {
    print('Enter your username: ');
    username = stdin.readLineSync();
  } while (username == null || username.isEmpty);
}
