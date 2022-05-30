import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_sample/home/data/model/user.dart';

part 'get_users_response.g.dart';

@JsonSerializable()
class GetUsersResponse {
  final int id;
  final String name;
  final String username;
  final String email;
  final AddressResponse address;
  final String phone;
  final String website;
  final CompanyResponse company;

  GetUsersResponse(
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  );

  factory GetUsersResponse.fromJson(Map<String, dynamic> json) => _$GetUsersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUsersResponseToJson(this);

  User convertToUserModel() {
    return User(id: id, name: name, username: username, email: email, phone: phone, likes: 0);
  }
}

@JsonSerializable()
class AddressResponse {
  final String street;
  final String suite;
  final String city;
  final String zipcode;

  AddressResponse(this.street, this.suite, this.city, this.zipcode);

  factory AddressResponse.fromJson(Map<String, dynamic> json) => _$AddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddressResponseToJson(this);
}

@JsonSerializable()
class CompanyResponse {
  final String name;
  final String catchPhrase;
  final String bs;

  CompanyResponse(this.name, this.catchPhrase, this.bs);

  factory CompanyResponse.fromJson(Map<String, dynamic> json) => _$CompanyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyResponseToJson(this);
}
