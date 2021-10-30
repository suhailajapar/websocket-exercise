import 'dart:convert';
import 'package:web_socket_channel/io.dart';
//import 'package:web_socket_channel/status.dart' as status;

void main(List<String> arguments) {

  //establishing connection
  final channel = IOWebSocketChannel.connect(
    'wss://ws.binaryws.com/websockets/v3?app_id=1089');
  
  channel.stream.listen((results) {
    //getting access to json
    final decodedResults = jsonDecode(results);
    final timeAsEpoch = decodedResults['tick']['epoch'];
    final price = decodedResults['tick']['quote'];
    final name = decodedResults['tick']['symbol'];
    final date = DateTime.fromMillisecondsSinceEpoch(
      timeAsEpoch * 1000);
    print('Name: $name, Price: $price, Date: $date');

    //disconnect websocket
    //channel.sink.close();
  });

  //Sending msg to server
  channel.sink.add('{"ticks": "frxAUDJPY", "subscribe": 1}');
}
