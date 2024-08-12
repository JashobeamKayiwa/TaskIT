import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_it/screens/finance/calculator.dart';

class TrackerPage extends StatefulWidget {
  @override
  _TrackerPageState createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  bool isPersonal = true;
  bool calculationsCompleted = false;
  int personalIncomeBalance = 0;
  int personalExpenseBalance = 0;
  int workIncomeBalance = 0;
  int workExpenseBalance = 0;

  @override
  void initState() {
    super.initState();
    _performCalculationsAndRetrieveBalances();
  }

  Future<void> _performCalculationsAndRetrieveBalances() async {
    // Perform the calculations first
    await Calculations().processCompletedFinanceTasks();

    // Then retrieve the balances
    await _retrieveBalances();

    setState(() {
      calculationsCompleted = true;
    });
  }

  Future<void> _retrieveBalances() async {
    DateTime today = DateTime.now();
    DateTime entryDate = DateTime(today.year, today.month, today.day);

    final balanceDoc = await FirebaseFirestore.instance
        .collection('balances')
        .where('entryDate', isEqualTo: Timestamp.fromDate(entryDate))
        .limit(1)
        .get();

    if (balanceDoc.docs.isNotEmpty) {
      final data = balanceDoc.docs.first.data();

      setState(() {
        personalIncomeBalance = data['personalIncomeBalance'] ?? 0;
        personalExpenseBalance = data['personalExpenseBalance'] ?? 0;
        workIncomeBalance = data['workIncomeBalance'] ?? 0;
        workExpenseBalance = data['workExpenseBalance'] ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!calculationsCompleted) {
      return Scaffold(
        appBar: AppBar(title: Text('Finance Tracker')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    int personalTotalEarnings = personalIncomeBalance - personalExpenseBalance;
    int workTotalEarnings = workIncomeBalance - workExpenseBalance;

    return Scaffold(
      appBar: AppBar(
        title: Text('Finance Tracker'),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Personal'),
                  Switch(
                    value: isPersonal,
                    onChanged: (value) {
                      setState(() {
                        isPersonal = value;
                      });
                    },
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Colors.red.withOpacity(0.3),
                  ),
                  Text('Work'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBalanceCard('Income', personalIncomeBalance,
                    workIncomeBalance, Colors.green, Icons.arrow_upward),
                _buildBalanceCard('Expense', personalExpenseBalance,
                    workExpenseBalance, Colors.red, Icons.arrow_downward),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildTotalEarningsCard(
              'Total Earnings',
              personalTotalEarnings,
              workTotalEarnings,
              isPersonal,
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('tasks')
                  .where('category', isEqualTo: 'Finance')
                  .where('status', isEqualTo: 'Completed')
                  .where('isPersonal', isEqualTo: isPersonal)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final doc = snapshot.data!.docs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    final title = data['title'] ?? 'No Title';
                    final amount = data['amount'] ?? 0;

                    return Card(
                      child: ListTile(
                        title: Text(
                          title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text('\$${amount.toString()}',
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 16)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(String title, int personalBalance, int workBalance,
      Color color, IconData icon) {
    int balanceValue = isPersonal ? personalBalance : workBalance;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            SizedBox(height: 8),
            Text(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('\$${balanceValue.toString()}',
                style: TextStyle(fontSize: 22, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalEarningsCard(
      String title, int personalEarnings, int workEarnings, bool isPersonal) {
    int totalEarnings = isPersonal ? personalEarnings : workEarnings;
    final earningsColor = totalEarnings >= 0 ? Colors.green : Colors.red;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(Icons.account_balance_wallet, color: earningsColor, size: 32),
            SizedBox(height: 8),
            Text(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('\$${totalEarnings.toString()}',
                style: TextStyle(fontSize: 22, color: earningsColor)),
          ],
        ),
      ),
    );
  }
}
