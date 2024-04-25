import 'package:hive/hive.dart';
part 'expensemodel.g.dart';

@HiveType(typeId: 1)
class ExpenseModel {
 @HiveField(0)
  final String? amount;
 @HiveField(1)
  final String? description;
 @HiveField(2)
  final String? category;
 @HiveField(3)
  final String? transactiontype;
 @HiveField(04)
  final String? date;

  ExpenseModel(
      {required this.amount,required this.description,required this.category,required this.transactiontype,
        required this.date,});


}