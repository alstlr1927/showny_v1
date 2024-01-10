import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showny/api/entities/user.dart';

class UserState extends StateNotifier<SNUser?> {
  UserState() : super(null);

  setUser(SNUser? user) => state = user;
}

final userProvider =
    StateNotifierProvider<UserState, SNUser?>((ref) => UserState());
