import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_sample/home/data/model/user.dart';
import 'package:riverpod_sample/home/data/repository/get_user_list_repository.dart';
import 'package:riverpod_sample/home/home_page.dart';
import 'package:riverpod_sample/main.dart';

class MockGetUserListRepository implements GetUserListRepository {
  @override
  Future<List<User>> getUserList() {
    return Future.value([
      User(
        id: 1,
        name: 'name',
        username: 'username',
        email: 'email',
        phone: 'phone',
        likes: 1,
      ),
      User(
        id: 2,
        name: 'name2',
        username: 'username2',
        email: 'email2',
        phone: 'phone2',
        likes: 0,
      )
    ]);
  }
}

void main() {
  testWidgets('incrementing the state updates the UI', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        getUserListRepositoryProvider.overrideWithValue(MockGetUserListRepository()),
      ],
      child: const MyApp(),
    ));

    expect(find.text('name'), findsOneWidget);
    expect(find.text('name2'), findsOneWidget);
    expect(find.byType(InkWell), findsNWidgets(2));
  });
}
