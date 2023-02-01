class Transaction{
  final String? id;
  final String? title;
  final double? amount;
  final DateTime? date;
  
  Transaction({
    this.id,
    this.title,
    this.amount,
    this.date
  });
}


void main(){

  final List<Transaction> transactions =[
    Transaction(
      id: "t1",
      title: "Shoes",
      amount: 12.00,
      date: DateTime.now()
    ),
     Transaction(
      id: "t1",
      title: "Shoes",
      amount: 12.00,
      date: DateTime.now()
    ),
     Transaction(
      id: "t2",
      title: "Weekly Groceries",
       
      amount: 12.00,
      date: DateTime.now()
    ),
  ];
  
  
final List trans=  transactions.map((tx){
  return tx; 
  }).toList();
  
  for(var i in trans){
    print(' id    : ${i.id}');
    print(' title : ${i.title}');
    print(' amount: ${i.amount}');
    print(' date  : ${i.date}');
    
    
  }
  
  
//  print(transactionList);

}