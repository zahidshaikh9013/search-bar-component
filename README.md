# search-bar-component

A new Flutter project which gives the customised search bar component. 
It provides the list of suggestions on the base of the search query for the user.

# Web Demo

![](https://github.com/zahidshaikh9013/search-bar-component/blob/main/demo/web_demo.gif)

# Desktop App Demo

![](https://github.com/zahidshaikh9013/search-bar-component/blob/main/demo/desktop_app_demo.gif)

# Usage :

Steps to use the component in any project : 
1. Copy the file "truth_database_picker_selection_box.dart" and paste it in any flutter project.
2. Use the component just like a normal widget. To initialize the widge, use the following code : 
  
   TRUTHDatabasePickerSelectionBox(
     initialValue: "initialSelectionValue",
     suggestionsList: [],
     hintText: "HintText",
     searchBarHeight: 40,
     onChanged: (int index, String selectedItemValue) {
        print("The index ---> $index and item value ---> $selectedItemValue");
     },
   )

# Features

Search bar component gives the following customisations : 

- Customised width of search bar
- Customised height of search bar
- Customised text style of search bar
- Customised border radius of search bar
- Customised border color of search bar
- Customised search bar background color

Few other customised fields like hint text, prefix icon.
