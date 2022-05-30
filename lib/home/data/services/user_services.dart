import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod_sample/home/data/model/get_users_response.dart';

part 'user_services.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class UserServices {
  factory UserServices(Dio dio, {String baseUrl}) = _UserServices;

  @GET('/users')
  Future<List<GetUsersResponse>> getUserList();
}
