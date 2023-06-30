import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 312,
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Color(0xFF09648C)),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFEAF7FF),
          hintText: 'Search',
          hintStyle: const TextStyle(
            color: Color(0xBF606060),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF09648C)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear, color: Color(0xFF09648C)),
            onPressed: () {
              setState(() {
                _searchController.clear();
              });
            },
          ),
        ),
        onChanged: (value) {
          // Perform search operation with the entered value
          print('Search query: $value');
        },
      ),
    );
  }
}
