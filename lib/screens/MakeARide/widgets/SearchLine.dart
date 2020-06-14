import 'package:flutter/material.dart';

class SearchLine extends StatefulWidget {
  final Function searchLines;
  SearchLine(this.searchLines);
  @override
  _SearchLineState createState() => _SearchLineState();
}

class _SearchLineState extends State<SearchLine> {
  TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      scrollPadding: EdgeInsets.all(0),
      maxLines: 1,
      cursorColor: Theme.of(context).primaryColor,
      controller: _searchController,
      style: TextStyle(color: Colors.black87),
      onChanged: widget.searchLines,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        counterText: '',
        filled: true,
        fillColor: Colors.black12,
        contentPadding: EdgeInsets.all(0),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        focusedBorder: OutlineInputBorder(
            gapPadding: 0,
            borderSide: BorderSide(color: Colors.transparent, width: 0),
            borderRadius: BorderRadius.circular(30)),
        enabledBorder: OutlineInputBorder(
            gapPadding: 0,
            borderSide: BorderSide(color: Colors.transparent, width: 0),
            borderRadius: BorderRadius.circular(30)),
        border: OutlineInputBorder(
            gapPadding: 0,
            borderSide: BorderSide(color: Colors.transparent, width: 0),
            borderRadius: BorderRadius.circular(30)),
        hintText: 'ابحث عن خط ...',
        hintStyle: TextStyle(color: Colors.black45),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.black45,
        ),
        suffixIcon: _searchController.text != ""
            ? IconButton(
                icon: Icon(Icons.close, color: Colors.black45),
                onPressed: () {
                  // searchResult = lines;
                  _searchController.clear();
                  setState(() {});
                },
              )
            : SizedBox(),
      ),
    );
  }
}
