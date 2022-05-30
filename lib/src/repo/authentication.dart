import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:porter_app/src/services/authentication.dart';

final authenticationRepo = Provider((ref) {
  return AuthenticationRepository();
});

final authenticationMethods = FutureProvider((ref) {
  final repo = ref.read(authenticationRepo);
  return repo;
});
