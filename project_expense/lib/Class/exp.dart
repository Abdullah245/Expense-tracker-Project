
class ExpenseClass {
  String amount;
  String dropDownValue;

  ExpenseClass({required this.amount, required this.dropDownValue});
  factory ExpenseClass.fromMap(Map<String, dynamic> map) {
    return ExpenseClass(
      amount: map['amount'],
      dropDownValue: map['dropdown'],
    );
  }
}