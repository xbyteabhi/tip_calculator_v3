import 'package:flutter/material.dart';

class ElementWidget extends StatelessWidget {
  final String name;
  final FocusNode focusNode;
  final VoidCallback onTapMinus;
  final VoidCallback onTapPlus;
  final ValueChanged<String> onSubmitted;
  final TextEditingController? controller;

  const ElementWidget({
    super.key,
    required this.name,
    required this.focusNode,
    required this.onTapMinus,
    required this.controller,
    required this.onSubmitted,
    required this.onTapPlus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 80,
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(3),
          right: Radius.circular(4),
        ),
        color: Colors.amber,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 240, child: Text(name)),

          GestureDetector(
            onTap: onTapMinus,
            child: Container(
              decoration: BoxDecoration(color: Colors.black),
              child: Icon(Icons.remove, color: Colors.white, size: 35),
            ),
          ),

          SizedBox(
            height: 35,
            width: 120,
            child: TextField(
              focusNode: focusNode,
              onSubmitted: onSubmitted,
              controller: controller,

              keyboardType: TextInputType.number,
              showCursor: true,
              cursorWidth: 1.8,
              cursorHeight: 24,

              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),

              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.right,
            ),
          ),

          GestureDetector(
            onTap: onTapPlus,
            child: Container(
              decoration: BoxDecoration(color: Colors.black),
              child: Icon(Icons.add, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
