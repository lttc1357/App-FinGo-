class VirtualWallet {
  double balance;
  List<TransactionRecord> history;

  VirtualWallet({required this.balance, this.history = const []});
}

class TransactionRecord {
  final String id;
  final double amount;
  final DateTime timestamp;
  final String description;

  TransactionRecord({
    required this.id,
    required this.amount,
    required this.timestamp,
    required this.description,
  });
}

enum PetState { happy, normal, sad, sick, evolved }

class VirtualPet {
  String name;
  int level;
  int xp;
  PetState state;

  VirtualPet({
    required this.name,
    this.level = 1,
    this.xp = 0,
    this.state = PetState.happy,
  });
}

class BudgetPlan {
  double limit;
  double currentSpent;

  BudgetPlan({required this.limit, this.currentSpent = 0.0});
}
