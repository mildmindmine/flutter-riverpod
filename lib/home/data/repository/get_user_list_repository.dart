import 'package:riverpod_sample/home/data/model/user.dart';
import 'package:riverpod_sample/home/data/services/user_services.dart';

abstract class GetUserListRepository {
  Future<List<User>> getUserList();
}

class GetUserListRepositoryImpl extends GetUserListRepository {
  final UserServices userServices;

  GetUserListRepositoryImpl(this.userServices);

  @override
  Future<List<User>> getUserList() async {
    try {
      await Future.delayed(Duration(seconds: 2));

      final response = await userServices.getUserList();

      return response.map((e) => e.convertToUserModel()).toList();
    } catch (e) {
      return [];
    }
  }
}
