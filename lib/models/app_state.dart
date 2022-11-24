import 'package:meta/meta.dart';

@immutable
class AppState {
  final String _name;
  final String _phone;
  final String _email;
  final String _userType;
  final String _utValue;

  String get name => _name;
  String get phone => _phone;
  String get email => _email;
  String get userType => _userType;
  String get utValue => _utValue;

  const AppState(
      this._name, this._phone, this._email, this._userType, this._utValue);

  const AppState.initialState()
      : _name = "",
        _phone = "",
        _email = "",
        _userType = "",
        _utValue = "";
}

class FetchUserAction {
  final String _name;
  final String _phone;
  final String _email;
  final String _userType;
  final String _utValue;

  String get name => _name;
  String get phone => _phone;
  String get email => _email;
  String get userType => _userType;
  String get utValue => _utValue;

  const FetchUserAction(
      this._name, this._phone, this._email, this._userType, this._utValue);
}

// AppState reducer(AppState prev, dynamic action) {
//   if (action is FetchUserAction) {
//     return AppState(action.name, action.phone, action.email, action.userType,
//         action.utValue);
//   }
// }
