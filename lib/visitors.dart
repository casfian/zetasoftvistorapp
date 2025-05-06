import 'package:flutter/material.dart';
import 'package:sqlitedemo/dbhelper.dart';
import 'package:sqlitedemo/vistor.dart';

class Visitors extends StatefulWidget {
  const Visitors({super.key});

  @override
  State<Visitors> createState() => _VisitorsState();
}

class _VisitorsState extends State<Visitors> {
  List<Visitor> visitors = [];

  //initialise database
  // This function initializes the database and fetches visitors
  initialDBase() async {
    // Load or initialize database
    MyDatabaseHelper.getDatabase().then((db) {
      // Fetch visitors from the database
      db.query('visitors').then((data) {
        setState(() {
          visitors = data.map((map) => Visitor.fromMap(map)).toList();
        });
      });
    });
  }

  addVisitors(String name, String purpose) async {
    // Add a visitor to the database
    MyDatabaseHelper.getDatabase().then((db) {
      db.insert('visitors', {
        'name': name,
        'visitDate': DateTime.now().toString(),
        'purpose': purpose
      }).then((_) {
        initialDBase(); // Refresh the visitors list
      });
    });
  }

  updateVisitor(int id, String name, String purpose) async {
    // Update a visitor in the database
    MyDatabaseHelper.getDatabase().then((db) {
      db.update('visitors', {
        'name': name,
        'visitDate': DateTime.now().toString(),
        'purpose': purpose
      }, where: 'id = ?', whereArgs: [id]).then((_) {
        initialDBase(); // Refresh the visitors list
      });
    });
  }

  deleteVisitor(int id) async {
    // Delete a visitor from the database
    MyDatabaseHelper.getDatabase().then((db) {
      db.delete('visitors', where: 'id = ?', whereArgs: [id]).then((_) {
        initialDBase(); // Refresh the visitors list
      });
    });
  }

  @override
  void initState() {
    super.initState();
    //load or initialise database
    initialDBase();
  }

  @override
  Widget build(BuildContext context) {
    showAddVisitorDialog() {
      // Show a dialog to add a visitor
      TextEditingController nameController = TextEditingController();
      TextEditingController purposeController = TextEditingController();

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Visitor'),
            content: SizedBox(
              height: 150,
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(hintText: 'Visitor Name'),
                  ),
                  TextField(
                    controller: purposeController,
                    decoration: const InputDecoration(hintText: 'Purpose'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Add visitor action
                  setState(() {
                    addVisitors(nameController.text, purposeController.text);
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Add'),
              ),
            ],
          );
        },
      );
    }

    updateVisitorDialog(int id) {
      // Show a dialog to add a visitor
      TextEditingController nameController = TextEditingController()..text = visitors.firstWhere((visitor) => visitor.id == id).name;
      TextEditingController purposeController = TextEditingController()..text = visitors.firstWhere((visitor) => visitor.id == id).purpose;

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update Visitor'),
            content: SizedBox(
              height: 150,
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(hintText: 'Visitor Name'),
                  ),
                  TextField(
                    controller: purposeController,
                    decoration: const InputDecoration(hintText: 'Purpose'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Add visitor action
                  setState(() {
                    updateVisitor(id, nameController.text, purposeController.text);
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Update'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Visitors'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // Add visitor action
                setState(() {
                  showAddVisitorDialog();
                });
              },
            )
          ],
        ),
        body: ListView.builder(
          itemCount: visitors.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(visitors[index].name),
              subtitle: Text('Visitor ${index + 1}'),
              leading: CircleAvatar(
                child: Text(visitors[index].id.toString()),
              ),
              trailing: PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.grey),
                onSelected: (value) {
                  if (value == 'update') {
                    // Call your update function here
                    updateVisitorDialog(visitors[index].id);
                  } else if (value == 'delete') {
                    setState(() {
                      deleteVisitor(visitors[index].id);
                    });
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'update',
                    child: Text('Update'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'delete',
                    child: Text('Delete'),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
