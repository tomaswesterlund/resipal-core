import 'package:resipal_core/lib.dart';

class CanPayMaintenanceFee {
  
  bool call({required String maintenanceFeeId}) {
    final fee = GetMaintenanceFee().call(maintenanceFeeId);
    final member = GetSignedInMember().call();
    final property = GetPropertyById().call(fee.property.id);
    
    if(member.totalMemberBalanceInCents < fee.amountInCents) return false;
    if(fee.status == MaintenanceFeeStatus.paid) return false;
    if(member.isAdmin) return true;
    if(property.resident == null) return false;
    if(property.resident!.id == member.user.id) return true;
    
    return false;
  }
}