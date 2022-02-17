import 'debt.dart';

class DebtUser {
  String? email;
  String? username;
  List<Debt>? debts_IGet;
  List<Debt>? debts_IOwe;

  DebtUser({this.email, this.username, this.debts_IGet, this.debts_IOwe});

  Map<String, dynamic> toJson() => _userToJson(this);
}

Map<String, dynamic> _userToJson(DebtUser instance) => <String, dynamic>{
      'email': instance.email,
      'username': instance.username,
      'debts_IGet': instance.debts_IGet,
      'debts_IOwe': instance.debts_IOwe
    };

List<Map<String, dynamic>>? _debtsList(List<Debt>? debts) {
  if (debts == null) {
    return null;
  }
  final debtsMap = <Map<String, dynamic>>[];
  debts.forEach((debts) {
    debtsMap.add(debts.toJson());
  });
  return debtsMap;
}
