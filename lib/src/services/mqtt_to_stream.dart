import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:nanoid/async.dart';
import 'package:porter_app/src/data/zone_data.dart';
import 'package:porter_app/src/repo/providers.dart';

class StreamData {
  StreamController streamController = StreamController<String>();
  Stream get stream => streamController.stream;
  void Function(String) get addResponse => streamController.add;

  void dispose() {
    streamController.close();
  }
}

class FetchMqtt {
  MqttServerClient client;
  WidgetRef ref;
  FetchMqtt({
    required this.client,
    required this.ref,
  });

  Future<MqttServerClient> connect() async {
    client.logging(on: true);

    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;
    client.keepAlivePeriod = 60;
    client.port = 1883;

    final id = await nanoid();

    final MqttConnectMessage connMessage = MqttConnectMessage()
        .authenticateAs('clevercare', 'sacC2p7rFaLj')
        .withClientIdentifier(id)
        .withWillTopic('willTopic')
        .withWillMessage('Hello')
        .startClean()
        .withWillQos(
          MqttQos.atLeastOnce,
        );

    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } catch (e, s) {
      print('Error occurred while connecting to mqtt client: $e $s');
      client.disconnect();
    }

    return client;
  }

  Future<String> fetchLocationData() async {
    client.subscribe('zone_wise_location', MqttQos.atMostOnce);
    String payload = '';

    final _connect = ref.watch(mqttMessage.notifier);

    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);

      print('Received message:$payload from topic: ${c[0].topic}>');
      _connect.updateZone(payload);
    });
    // final zoneData = ZoneData.fromJson(jsonDecode(payload));
    // print('Zone Data: $zoneData');

    // _stream.addResponse(payload);

    return payload;
  }

  void disconnect() {
    client.disconnect();
  }

  // connection succeeded
  void onConnected() {
    print('Connected');

    fetchLocationData();
  }

// unconnected
  void onDisconnected() {
    print('Disconnected');
    disconnect();
  }

// subscribe to topic succeeded
  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

// subscribe to topic failed
  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

// PING response received
  void pong() {
    print('Ping response client callback invoked');
  }
}
