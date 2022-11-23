import 'package:flutter/material.dart';
import 'package:search_bar_component/widgets/truth_database_picker_selection_box.dart';

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
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: Row(
                    children: [
                      Expanded(
                        child: TRUTHDatabasePickerSelectionBox(
                          initialValue: "WorkizCore",
                          suggestionsList: const [
                            "Masterschool",
                            "Marketting Bricks",
                            "Workiz-US",
                            "Funne-Workiz",
                            "WorkizCore",
                            "Google Ads Manager"
                          ],
                          hintText: "Choose Workspace",
                          searchBarHeight: 40,
                          onChanged: (int index, String selectedItemValue) {
                            print("The index ---> $index and item value ---> $selectedItemValue");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
