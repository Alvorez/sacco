// ignore: unnecessary_import
// ignore_for_file: use_build_context_synchronously, unnecessary_import, unnecessary_cast, duplicate_ignore

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sacco_teller/api_service.dart';
import 'package:sacco_teller/constants.dart';

class TransactionSelectionPage extends StatelessWidget {
  const TransactionSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Select Transaction'),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appBlack,
        titleTextStyle: const TextStyle(
          color: appWhite,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _transactionItem(context, 'Deposit', Icons.account_balance_wallet,
                const DepositPage()),
            _transactionItem(
                context, 'Withdrawal', Icons.money_off, const WithdrawalPage()),
            _transactionItem(
                context, 'Transfer', Icons.swap_horiz, const TransferPage()),
            _transactionItem(
                context, 'Payment', Icons.payment, const PaymentPage()),
            _transactionItem(context, 'Loan Application', Icons.assignment,
                const LoanApplicationPage()),
            _transactionItem(context, 'Loan Repayment', Icons.receipt,
                const LoanRepaymentPage()),
            _transactionItem(context, 'Balance Inquiry', Icons.account_balance,
                const BalanceInquiryPage()),
            _transactionItem(context, 'Mini Statement', Icons.list,
                const MiniStatementPage()),
            _transactionItem(context, 'Bill Payment', Icons.receipt_long,
                const BillPaymentPage()),
            _transactionItem(context, 'Airtime Purchase', Icons.phone_android,
                const AirtimePurchasePage()),
            _transactionItem(context, 'Funds Transfer', Icons.send,
                const FundsTransferPage()),
            _transactionItem(context, 'Investment', Icons.trending_up,
                const InvestmentPage()),
          ],
        ),
      ),
    );
  }

  Widget _transactionItem(
      BuildContext context, String title, IconData icon, Widget page) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: primaryColor),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
      ),
    );
  }
}

// Placeholder pages for each transaction type
class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  final _accountNumberController = TextEditingController();
  final _amountController = TextEditingController();
  final ApiService _apiService = ApiService(baseUrl: 'https://businesscentral.coretec.co.ke:8989/');

  void _deposit() async {
    final accountNumber = _accountNumberController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;

    if (accountNumber.isEmpty || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter a valid account number and amount')),
      );
      return;
    }

    try {
      final response = await _apiService.deposit(accountNumber, amount);
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Deposit successful')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Deposit failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deposit', style: TextStyle(color: appWhite)),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appWhite,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _accountNumberController,
              decoration: const InputDecoration(labelText: 'Account Number'),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _deposit,
                child: const Text('Deposit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class WithdrawalPage extends StatefulWidget {
  const WithdrawalPage({super.key});

  @override
  State<WithdrawalPage> createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends State<WithdrawalPage> {
  final _accountNumberController = TextEditingController();
  final _amountController = TextEditingController();
  final ApiService _apiService = ApiService(baseUrl: 'https://businesscentral.coretec.co.ke:8989/');

  void _withdraw() async {
    final accountNumber = _accountNumberController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;

    if (accountNumber.isEmpty || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid account number and amount')),
      );
      return;
    }

    try {
      final response = await _apiService.withdraw(accountNumber, amount);
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Withdrawal successful')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Withdrawal failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withdrawal', style: TextStyle(color: appWhite)),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appWhite,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _accountNumberController,
              decoration: const InputDecoration(labelText: 'Account Number'),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _withdraw,
                child: const Text('Withdraw'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer', style: TextStyle(color: appWhite)),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appWhite,
      ),
      body: const Center(
        child: Text('Details of Transfer transaction will be displayed here.'),
      ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment', style: TextStyle(color: appWhite)),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appWhite,
      ),
      body: const Center(
        child: Text('Details of Payment transaction will be displayed here.'),
      ),
    );
  }
}

class LoanApplicationPage extends StatelessWidget {
  const LoanApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Loan Application', style: TextStyle(color: appWhite)),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appWhite,
      ),
      body: const Center(
        child: Text(
            'Details of Loan Application transaction will be displayed here.'),
      ),
    );
  }
}

class LoanRepaymentPage extends StatelessWidget {
  const LoanRepaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Repayment', style: TextStyle(color: appWhite)),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appWhite,
      ),
      body: const Center(
        child: Text(
            'Details of Loan Repayment transaction will be displayed here.'),
      ),
    );
  }
}

class BalanceInquiryPage extends StatefulWidget {
  const BalanceInquiryPage({super.key});

  @override
  State<BalanceInquiryPage> createState() => _BalanceInquiryPageState();
}

class _BalanceInquiryPageState extends State<BalanceInquiryPage> {
  final _accountNumberController = TextEditingController();
  final ApiService _apiService = ApiService(baseUrl: 'https://businesscentral.coretec.co.ke:8989/');

  void _checkBalance() async {
    final accountNumber = _accountNumberController.text;

    if (accountNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid account number')),
      );
      return;
    }

    try {
      final response = await _apiService.checkBalance(accountNumber);
      if (response['status'] == 'success') {
        final balance = response['balance'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Your balance is: $balance')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Balance inquiry failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Balance Inquiry', style: TextStyle(color: appWhite)),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appWhite,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _accountNumberController,
              decoration: const InputDecoration(labelText: 'Account Number'),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _checkBalance,
                child: const Text('Check Balance'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MiniStatementPage extends StatefulWidget {
  const MiniStatementPage({super.key});

  @override
  State<MiniStatementPage> createState() => _MiniStatementPageState();
}

class _MiniStatementPageState extends State<MiniStatementPage> {
  final _accountNumberController = TextEditingController();
  final ApiService _apiService = ApiService(baseUrl: 'https://businesscentral.coretec.co.ke:8989/');

  void _fetchMiniStatement() async {
    final accountNumber = _accountNumberController.text;

    if (accountNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid account number')),
      );
      return;
    }

    try {
      final response = await _apiService.getMiniStatement(accountNumber);
      if (response['status'] == 'success') {
        final transactions = response['transactions'] as List;
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Mini Statement'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: transactions.map((transaction) {
                  return Text(
                      'Date: ${transaction['date']}, Amount: ${transaction['amount']}, Type: ${transaction['type']}');
                }).toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to fetch mini statement')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Statement', style: TextStyle(color: appWhite)),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appWhite,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _accountNumberController,
              decoration: const InputDecoration(labelText: 'Account Number'),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _fetchMiniStatement,
                child: const Text('Fetch Mini Statement'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BillPaymentPage extends StatefulWidget {
  const BillPaymentPage({super.key});

  @override
  State<BillPaymentPage> createState() => _BillPaymentPageState();
}

class _BillPaymentPageState extends State<BillPaymentPage> {
  final _accountNumberController = TextEditingController();
  final _billDetailsController = TextEditingController();
  final _amountController = TextEditingController();
  final ApiService _apiService = ApiService(baseUrl: 'https://businesscentral.coretec.co.ke:8989/');

  void _payBill() async {
    final accountNumber = _accountNumberController.text;
    final billDetails = _billDetailsController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;

    if (accountNumber.isEmpty || billDetails.isEmpty || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Please enter valid account number, bill details, and amount')),
      );
      return;
    }

    try {
      final response =
          await _apiService.payBill(accountNumber, billDetails as String, amount as double);
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bill payment successful')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bill payment failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Payment', style: TextStyle(color: appWhite)),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appWhite,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _accountNumberController,
              decoration: const InputDecoration(labelText: 'Account Number'),
            ),
            TextField(
              controller: _billDetailsController,
              decoration: const InputDecoration(labelText: 'Bill Details'),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _payBill,
                child: const Text('Pay Bill'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AirtimePurchasePage extends StatefulWidget {
  const AirtimePurchasePage({super.key});

  @override
  State<AirtimePurchasePage> createState() => _AirtimePurchasePageState();
}

class _AirtimePurchasePageState extends State<AirtimePurchasePage> {
  final _phoneNumberController = TextEditingController();
  final _amountController = TextEditingController();
  final ApiService _apiService = ApiService(baseUrl: 'https://businesscentral.coretec.co.ke:8989/');

  void _purchaseAirtime() async {
    final phoneNumber = _phoneNumberController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;

    if (phoneNumber.isEmpty || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter a valid phone number and amount')),
      );
      return;
    }

    try {
      final response = await _apiService.purchaseAirtime(phoneNumber, amount);
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Airtime purchase successful')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Airtime purchase failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Airtime Purchase', style: TextStyle(color: appWhite)),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appWhite,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _purchaseAirtime,
                child: const Text('Purchase Airtime'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FundsTransferPage extends StatefulWidget {
  const FundsTransferPage({super.key});

  @override
  State<FundsTransferPage> createState() => _FundsTransferPageState();
}

class _FundsTransferPageState extends State<FundsTransferPage> {
  final _sourceAccountController = TextEditingController();
  final _destinationAccountController = TextEditingController();
  final _amountController = TextEditingController();
  final ApiService _apiService = ApiService(baseUrl: 'https://businesscentral.coretec.co.ke:8989/');

  void _transferFunds() async {
    final sourceAccount = _sourceAccountController.text;
    final destinationAccount = _destinationAccountController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;

    if (sourceAccount.isEmpty || destinationAccount.isEmpty || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Please enter valid source account, destination account, and amount')),
      );
      return;
    }

    try {
      final response = await _apiService.transferFunds(
          sourceAccount, destinationAccount, amount);
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Funds transfer successful')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Funds transfer failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Funds Transfer', style: TextStyle(color: appWhite)),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appWhite,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _sourceAccountController,
              decoration:
                  const InputDecoration(labelText: 'Source Account Number'),
            ),
            TextField(
              controller: _destinationAccountController,
              decoration: const InputDecoration(
                  labelText: 'Destination Account Number'),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _transferFunds,
                child: const Text('Transfer Funds'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InvestmentPage extends StatefulWidget {
  const InvestmentPage({super.key});

  @override
  State<InvestmentPage> createState() => _InvestmentPageState();
}

class _InvestmentPageState extends State<InvestmentPage> {
  final _investmentAmountController = TextEditingController();
  final _investmentDetailsController = TextEditingController();
  final ApiService _apiService = ApiService(baseUrl: 'https://businesscentral.coretec.co.ke:8989/');

  void _invest() async {
    final investmentAmount =
        double.tryParse(_investmentAmountController.text) ?? 0.0;
    final investmentDetails = _investmentDetailsController.text;

    if (investmentAmount <= 0 || investmentDetails.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Please enter a valid investment amount and details')),
      );
      return;
    }

    try {
      final response =
          await _apiService.invest(investmentAmount, investmentDetails);
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Investment successful')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Investment failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investment', style: TextStyle(color: appWhite)),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appWhite,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _investmentAmountController,
              decoration: const InputDecoration(labelText: 'Investment Amount'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _investmentDetailsController,
              decoration:
                  const InputDecoration(labelText: 'Investment Details'),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _invest,
                child: const Text('Invest'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
