class BankAccount {
  final int _accountId;
  final String _accountOwner;
  double _balance;

  BankAccount(this._accountId, this._accountOwner, [this._balance = 0.0]);

  double get balance => _balance;
  int get accountId => _accountId;
  String get accountOwner => _accountOwner;

  void credit(double amount) {
    if (amount <= 0) {
      throw ArgumentError('Credit amount must be greater than zero.');
    }
    _balance += amount;
  }

  void withdraw(double amount) {
    if (amount <= 0) {
      throw ArgumentError('Withdrawal amount must be greater than zero.');
    }
    if (_balance - amount < 0) {
      throw Exception('Insufficient balance for withdrawal!');
    }
    _balance -= amount;
  }
}

class Bank {
  final String name;
  final List<BankAccount> _accounts = [];

  Bank({required this.name});

  BankAccount createAccount(int accountId, String accountOwner) {
    bool idExists = _accounts.any((account) => account.accountId == accountId);

    if (idExists) {
      throw Exception('Account with ID $accountId already exists!');
    }

    var newAccount = BankAccount(accountId, accountOwner);
    _accounts.add(newAccount);
    return newAccount;
  }
}

void main() {
  Bank myBank = Bank(name: "CADT Bank");
  BankAccount ronanAccount = myBank.createAccount(100, 'Ronan');

  print('Balance: \$${ronanAccount.balance}');
  ronanAccount.credit(100);
  print('Balance: \$${ronanAccount.balance}');
  ronanAccount.withdraw(50);
  print('Balance: \$${ronanAccount.balance}');

  try {
    ronanAccount.withdraw(75);
  } catch (e) {
    print(e);
  }

  try {
    myBank.createAccount(100, 'Hongly');
  } catch (e) {
    print(e);
  }
}
