import 'package:flutter/material.dart';

class SearchbarComponent extends StatefulWidget {

  /// [List<String>] which is a [required] param for getting the suggestions list for the component.
  final List<String> suggestionsList;

  /// [double] which is the search bar width, mentions the width of the search bar.
  final double? searchBarWidth;

  /// [double] which is the search bar height, mentions the height of the search bar.
  final double searchBarHeight;

  /// [TextStyle] gives the Textstyle to entire search bar with the options view.
  final TextStyle searchBarTextStyle;

  /// [double] which gives the border radius for entire search bar with the options view
  final double borderRadius;

  /// [Color] which gives the color for the border
  final Color borderColor;

  /// [Color] which gives the background color for the search bar and options view
  final Color barThemeColor;

  /// [Widget] for the prefix icon of the search bar
  final Widget prefixIcon;

  /// [String] which gives the hint for the search bar
  final String hintText;
  final double? maxSearchResultsHeight;

  const SearchbarComponent({
    Key? key,
    required this.suggestionsList,
    required this.hintText,
    this.maxSearchResultsHeight,
    this.searchBarWidth,
    this.searchBarHeight = 45,
    this.searchBarTextStyle = const TextStyle(color: Colors.blueGrey),
    this.borderRadius = 15.0,
    this.borderColor = Colors.transparent,
    this.barThemeColor = const Color(0XFFCFDCFC),
    this.prefixIcon = const Icon(Icons.search, color: Color(0XFF6C88A3), size: 21),
  }) : super(key: key);

  @override
  SearchbarComponentState createState() => SearchbarComponentState();
}

class SearchbarComponentState extends State<SearchbarComponent> {
  List<String> resultSuggestionsList = [];

  @override
  Widget build(BuildContext context) {
    return _searchBarWidget();
  }

  /// Widget function which gives the entire search bar widget
  /// Uses [LayoutBuilder] for maintaining the width of the options(used due to flutter's internal issue)
  /// uses [RawAutocomplete] for the search bar and the suggestions view
  Widget _searchBarWidget() {
    return LayoutBuilder(builder: (context, constraints) {
      return RawAutocomplete(
        optionsBuilder: (TextEditingValue textEditingValue) => getSuggestions(textEditingValue),
        optionsViewBuilder: (context, onSelected, options) =>
            _searchSuggestionsViewDesign(context, onSelected, options, constraints),
        fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) =>
            _searchBarDesign(textEditingController, focusNode, onFieldSubmitted),
        onSelected: (String selection) {
          debugPrint('You just selected $selection');
        },
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
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: widget.searchBarHeight * 0.3, right: widget.searchBarHeight * 0.2),
            child: widget.prefixIcon,
          ),
          hintStyle: widget.searchBarTextStyle.copyWith(fontSize: widget.searchBarHeight * 0.35),
          hintText: widget.hintText,
        ),
      ),
    );
  }

  /// Widget function which gives the designs for the suggestions root view.
  /// It uses an internal [ListView] which shows the list of the searched suggestions
  Widget _searchSuggestionsViewDesign(
      BuildContext context, Function onSelected, Iterable<String> options, BoxConstraints constraints) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.borderRadius)),
        child: Column(
          children: [
            Container(
              height: widget.maxSearchResultsHeight ?? widget.searchBarHeight * options.length,
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
                  return _searchSuggestionItem(option, onSelected, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget function which gives the design for the single suggestion item
  Widget _searchSuggestionItem(String option, Function onSelected, int index) {
    return InkWell(
      onTap: () => onSelected(option),
      borderRadius: _suggestionItemRadius(index),
      hoverColor: widget.barThemeColor,
      child: Container(
        height: widget.searchBarHeight,
        padding: EdgeInsets.symmetric(horizontal: widget.searchBarHeight * 0.4),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            option,
            style: widget.searchBarTextStyle.copyWith(fontSize: widget.searchBarHeight * 0.35),
          ),
        ),
      ),
    );
  }

  /// Function which gives the list of the suggestions for the searched text.
  List<String> getSuggestions(TextEditingValue textEditingValue) {
    if (textEditingValue.text == '') {
      return const Iterable<String>.empty().toList();
    }

    resultSuggestionsList = widget.suggestionsList.where((String option) {
      return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
    }).toList();

    return resultSuggestionsList;
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
}
