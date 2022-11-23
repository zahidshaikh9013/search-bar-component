import 'package:flutter/material.dart';
import 'package:search_bar_component/widgets/search_bar_component.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search bar',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WidgetHomePage(),
    );
  }
}

/// [StatelessWidget] called for showing the home page which in turn contains the entire
/// search bar widget.
class WidgetHomePage extends StatelessWidget {
  const WidgetHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Card(
        margin: EdgeInsets.all(25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Add Big query table/View", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: MediaQuery.of(context).size.width * 0.05),
                child: Row(
                  children: [
                    const Expanded(
                      child: SearchbarComponent(
                        suggestionsList: ["Search1", "Tester", "ABC", "xabs", "Name", "Paper", "Place", "Search1", "Tester", "ABC", "xabs", "Name", "Paper", "Place", "Search1", "Tester", "ABC", "xabs", "Name", "Paper", "Place"],
                        hintText: "Search Project",
                        borderColor: Colors.red,
                        searchBarHeight: 50,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.015),
                    const Expanded(
                      child: SearchbarComponent(
                        suggestionsList: ["Name", "Paper", "Place"],
                        hintText: "Search Database",
                        searchBarHeight: 40,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.015),
                    const Expanded(
                      child: SearchbarComponent(
                        suggestionsList: ["Tester", "ABC", "xabs"],
                        hintText: "Search Table",
                        searchBarHeight: 40,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: 300,
                  width: 300,
                  margin: EdgeInsets.all(10),
                  color: Colors.lime,
                  child: Center(child: const Text("Other app component")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
