import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:porter_app/src/data/zone_data.dart';
import 'package:porter_app/src/services/register_pushy.dart';

import '../services/mqtt_to_stream.dart';

final pushyRepo = Provider((ref) {
  return PushyRepository();
});

final pushyRef = FutureProvider((ref) {
  final repo = ref.watch(pushyRepo);
  return repo;
});

final mqttProvider = Provider.family((ref, MqttHelper payload) {
  return FetchMqtt(
    client: payload.client,
    ref: payload.ref,
  );
});

class MqttHelper {
  final MqttServerClient client;
  final WidgetRef ref;

  MqttHelper(this.client, this.ref);
}

final mqttMessage = StateNotifierProvider<MqttPayload, String>((ref) {
  return MqttPayload();
});

class MqttPayload extends StateNotifier<String> {
  MqttPayload() : super('');

  void updateZone(String data) {
    state = data;
  }

  String returnZone() {
    print('State: $state');
    return state;
  }
}
