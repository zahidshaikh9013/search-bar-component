import 'package:flutter/material.dart';

class TRUTHDatabasePickerSelectionBox extends StatefulWidget {
  /// [List<String>] which is a [required] param for getting the suggestions list for the component.
  final List<String> suggestionsList;

  /// [Function] which passes the selected item data on to the frontend part
  final Function(int, String) onChanged;

  /// [String] gives the initially selected value for the picker
  final String initialValue;

  /// [String] which gives the hint for the search bar
  final String hintText;

  /// [double] which gives the border radius for entire search bar with the options view
  final double borderRadius;

  /// [Color] which gives the color for the border
  final Color borderColor;

  /// [Color] which gives the background color for the search bar and options view
  final Color barThemeColor;

  /// [double] which is the search bar width, mentions the width of the search bar.
  final double? searchBarWidth;

  /// [double] which is the search bar height, mentions the height of the search bar.
  final double searchBarHeight;

  /// [TextStyle] gives the Textstyle to entire search bar with the options view.
  final TextStyle searchBarTextStyle;

  /// [Widget] for the prefix icon of the search bar
  final Widget prefixIcon;

  /// [bool] shows the visibility of the search icon
  final bool showPrefixIcon;

  const TRUTHDatabasePickerSelectionBox({
    Key? key,
    required this.suggestionsList,
    required this.onChanged,
    required this.initialValue,
    required this.hintText,
    this.borderRadius = 15.0,
    this.borderColor = Colors.transparent,
    this.barThemeColor = const Color(0XFFECF1FD),
    this.searchBarWidth,
    this.searchBarHeight = 45,
    this.searchBarTextStyle =
        const TextStyle(color: Color(0XFF6C88A3), fontFamily: 'MontSerrat', fontWeight: FontWeight.w700),
    this.prefixIcon = const Icon(Icons.search, color: Color(0XFF6C88A3), size: 21),
    this.showPrefixIcon = true,
  }) : super(key: key);

  @override
  TRUTHDatabasePickerSelectionBoxState createState() => TRUTHDatabasePickerSelectionBoxState();
}

class TRUTHDatabasePickerSelectionBoxState extends State<TRUTHDatabasePickerSelectionBox> {
  /// [List<String>] which contains the resultant string after the search is applied.
  /// It changes the state of the current list and shows the updated list.
  List<String> resultSuggestionsList = [];

  /// [TextEditingController] and [FocusNode] which holds the current text input state and focus
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  /// [int] value which keeps the current selected list item index
  int? selectedListItem;

  @override
  void initState() {
    super.initState();
    resultSuggestionsList = widget.suggestionsList;
    selectedListItem = widget.suggestionsList.indexWhere((element) => element == widget.initialValue);
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _searchBarWidget();
  }

  /// Widget function which gives the entire search bar widget
  /// Uses [LayoutBuilder] for maintaining the width of the options(used due to flutter's internal issue)
  /// uses [RawAutocomplete] for the search bar and the suggestions view
  Widget _searchBarWidget() {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          _searchBarDesign(textEditingController, focusNode, () {}),
          _searchSuggestionsViewDesign(context, resultSuggestionsList, constraints),
        ],
      );
    });
  }

  /// Widget function which gives the design for the search bar and the other functionalities for the suggestions.
  Widget _searchBarDesign(TextEditingController textEditingController, FocusNode focusNode, Function onFieldSubmitted) {
    return SizedBox(
      width: widget.searchBarWidth ?? MediaQuery.of(context).size.width * 0.9,
      height: widget.searchBarHeight,
      child: TextField(
        focusNode: focusNode,
        controller: textEditingController,
        onSubmitted: (value) => onFieldSubmitted,
        cursorColor: widget.searchBarTextStyle.color,
        style: widget.searchBarTextStyle.copyWith(fontSize: widget.searchBarHeight * 0.35),
        onChanged: (value) => getSuggestions(value),
        decoration: InputDecoration(
          fillColor: widget.barThemeColor,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(color: widget.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(color: widget.borderColor),
          ),
          prefixIcon: widget.showPrefixIcon
              ? Padding(
                  padding: EdgeInsets.only(left: widget.searchBarHeight * 0.3, right: widget.searchBarHeight * 0.2),
                  child: widget.prefixIcon,
                )
              : null,
          hintStyle: widget.searchBarTextStyle.copyWith(fontSize: widget.searchBarHeight * 0.35),
          hintText: widget.hintText,
        ),
      ),
    );
  }

  /// Widget function which gives the designs for the suggestions root view.
  /// It uses an internal [ListView] which shows the list of the searched suggestions
  Widget _searchSuggestionsViewDesign(BuildContext context, Iterable<String> options, BoxConstraints constraints) {
    double totalViewHeight =
        ((widget.searchBarHeight * options.length) + (options.length > 1 ? ((options.length - 1) * 5) : 0));
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        height: (totalViewHeight < MediaQuery.of(context).size.height * 0.5)
            ? totalViewHeight > 10
                ? totalViewHeight + 2
                : totalViewHeight
            : MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
            color: widget.barThemeColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(color: Colors.transparent)),
        margin: const EdgeInsets.only(top: 8),
        width: widget.searchBarWidth ?? constraints.biggest.width,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: options.length,
          shrinkWrap: false,
          itemBuilder: (BuildContext context, int index) {
            final String option = options.elementAt(index);
            return _searchSuggestionItem(option, index);
          },
        ),
      ),
    );
  }

  /// Widget function which gives the design for the single suggestion item
  Widget _searchSuggestionItem(String option, int index) {
    return Column(
      children: [
        InkWell(
          onTap: () => onSelected(index),
          borderRadius: _suggestionItemRadius(index),
          hoverColor: const Color(0xFF4d83ff),
          child: Container(
            height: widget.searchBarHeight,
            decoration: BoxDecoration(
              borderRadius: _suggestionItemRadius(index),
              color: selectedListItem == index ? Colors.blueAccent[700] : null,
            ),
            padding: EdgeInsets.symmetric(horizontal: widget.searchBarHeight * 0.4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                option,
                style: widget.searchBarTextStyle.copyWith(
                  fontSize: widget.searchBarHeight * 0.35,
                  fontWeight: FontWeight.w900,
                  color: selectedListItem == index ? Colors.white : null,
                ),
              ),
            ),
          ),
        ),
        if (index != resultSuggestionsList.length - 1) const Divider(color: Colors.white, height: 5, thickness: 2),
      ],
    );
  }

  /// Function which gives the list of the suggestions for the searched text.
  void getSuggestions(String textEditingValue) {
    setState(() {
      selectedListItem = null;
      resultSuggestionsList = widget.suggestionsList.where((String option) {
        return option.toLowerCase().contains(textEditingValue.toLowerCase());
      }).toList();
    });
  }

  /// Function which gives the border radius for the single suggestion item to show the hover colors with a radius
  BorderRadius? _suggestionItemRadius(int index) {
    if (resultSuggestionsList.length == 1) {
      return BorderRadius.circular(widget.borderRadius);
    } else if (index == 0) {
      return BorderRadius.only(
        topLeft: Radius.circular(widget.borderRadius),
        topRight: Radius.circular(widget.borderRadius),
      );
    } else if (index == resultSuggestionsList.length - 1) {
      return BorderRadius.only(
        bottomLeft: Radius.circular(widget.borderRadius),
        bottomRight: Radius.circular(widget.borderRadius),
      );
    }

    return null;
  }

  /// Function which change the state of the current selected list item.
  void onSelected(int selectedItem) {
    setState(() {
      selectedListItem = selectedItem;
      widget.onChanged(selectedItem, resultSuggestionsList[selectedItem]);
    });
  }
}
