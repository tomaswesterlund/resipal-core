import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class CreateUser {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  Future<UserId> call({
    required String name,
    required String phoneNumber,
    required String? emergencyPhoneNumber,
    required String email,
    required ApplicationStatus status,
    required String applicationMessage,
    required bool isAdmin,
    required bool isResident,
    required bool isSecurity,
  }) async => await _source.createUser(
    name: name,
    phoneNumber: phoneNumber,
    emergencyPhoneNumber: emergencyPhoneNumber,
    email: email,
    applicationStatus: status.toString(),
    applicationMessage: applicationMessage,
    isAdmin: isAdmin,
    isResident: isResident,
    isSecurity: isSecurity,
  );
}
