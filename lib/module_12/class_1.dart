import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'expense_model.dart';

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  final List<String> categories = ['Food', 'Transport', 'Enter', 'Bills'];
  final List<Expense> _expense = [];
  double total = 0.0;

  void _showForm() {
    String selectedCategory = categories.first;
    TextEditingController titleController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    DateTime expenseDatetime = DateTime.now();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title')),
              SizedBox(height: 10),
              TextField(
                controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Amount')),
              SizedBox(height: 10),
              DropdownButtonFormField(
                items:
                    categories
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ),
                        )
                        .toList(),

                onChanged: (value) => selectedCategory = value!,
                decoration: InputDecoration(labelText: 'select any one'),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                      if (titleController.text.isNotEmpty ||
                         double.tryParse(amountController.text) != null) {
                      _adExpense(
                        titleController.text,
                        double.parse(amountController.text),
                        expenseDatetime,
                        selectedCategory,
                      );
                      Navigator.pop(context);

                     }
                    },
                      child: Text(
                  'Add expense',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        );
      },
    );
  }

  void _adExpense(String title, double amount, DateTime date, String category) {
    setState(() {
      _expense.add(
        Expense(title: title, amount: amount, date: date, category: category),
      );
      total += amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Expense Tracker'),
        actions: [
          IconButton(onPressed: () => _showForm(), icon: Icon(Icons.add)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Card(
                color: Colors.orange,
                margin: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 100,
                    right: 100,
                    bottom: 50,
                    top: 50,
                  ),
                  child: Text(
                    'Total $total',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _expense.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.blueAccent,
                        child: Text(_expense[index].category),
                      ),
                      title: Text(_expense[index].title),
                      subtitle: Text(
                         DateFormat.yMMMd().format(_expense[index].date)
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> _showForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}
