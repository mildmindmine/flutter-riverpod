import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/detail_page/detail_page.dart';
import 'package:riverpod_sample/home/data/model/user.dart';
import 'package:riverpod_sample/home/data/repository/get_user_list_repository.dart';
import 'package:riverpod_sample/home/data/services/user_services.dart';

final userServicesProvider = Provider<UserServices>((ref) {
  Dio _dio = Dio();
  return UserServices(_dio);
});

final getUserListRepositoryProvider = Provider<GetUserListRepository>((ref) {
  return GetUserListRepositoryImpl(ref.read(userServicesProvider));
});

final userNotifierProvider = FutureProvider.autoDispose<List<User>>((ref) {
  GetUserListRepository _repository = ref.read(getUserListRepositoryProvider);

  /// When the provider is destroyed, call the on dispose method
  ref.onDispose(() {
    debugPrint('future provider is disposed');
  });

  /// If the request completed successfully, keep the state
  ref.maintainState = true;
  return _repository.getUserList();
});

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNotifierProvideValue = ref.watch(userNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: userNotifierProvideValue.when(
        data: (data) => UserList(users: data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Text('Error: $e'),
      ),
    );
  }
}

class UserList extends ConsumerWidget {
  final List<User> users;

  const UserList({required this.users, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemBuilder: (context, int index) {
        return InkWell(
            onTap: () {
              ref.read(selectedUserProvider.state).state = users[index];
              Navigator.pushNamed(context, '/detailPage');
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(users[index].name),
            ));
      },
      itemCount: users.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(
        thickness: 1,
        indent: 16,
      ),
    );
  }
}
