import 'package:flutter/material.dart';
import 'package:sqlitedemo/visitors.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home | Dashboard'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                //logout action
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home, size: 20),
                  SizedBox(width: 20),
                  Text('Welcome to the Home Page',
                      style: TextStyle(fontSize: 24)),
                ],
              ),
              const SizedBox(height: 20),
              const Text('This is the main dashboard of the application.',
                  style: TextStyle(fontSize: 18)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Visitors(),
                          ));
                    },
                    child: Container(
                      width: 150,
                      height: 100,
                      color: Colors.grey,
                      child: const Center(
                        child: Text('Visitors', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 100,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
