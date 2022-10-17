import 'package:flutter_auth/models/user_info.dart';
import '../../../utilities/constants.dart';

extension UserInfoExtensions on UserInfo {
  bool isUser() {
    return roles.contains(Constants.userRoleName);
  }

  bool isAdmin() {
    return isUser() && roles.contains(Constants.adminRoleName);
  }
}
