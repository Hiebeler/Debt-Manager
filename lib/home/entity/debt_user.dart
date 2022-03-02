import 'debt.dart';

class DebtUser {
  String? email;
  String? username;
  String? profilePicture;
  List<Debt>? debts_Iget;
  List<Debt>? debts_Iowe;

  DebtUser({this.email, this.username,this.profilePicture, this.debts_Iget, this.debts_Iowe});

  Map<String, dynamic> toJson() => _userToJson(this);
}

Map<String, dynamic> _userToJson(DebtUser instance) => <String, dynamic>{
      'email': instance.email,
      'username': instance.username,
      'debts_IGet': instance.debts_Iget,
      'debts_IOwe': instance.debts_Iowe,
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
