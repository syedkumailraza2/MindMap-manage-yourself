import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mindmap/Theme/theme.dart';

class CustomButton extends StatefulWidget {
  final text;
  final onPress;
  const CustomButton({super.key, required this.text, required this.onPress});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),),
      width: screenWidth * 0.8,
      height: screenHeight * 0.07,
      child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary, // Background color
              foregroundColor: Colors.white, // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Set your desired border radius here
              ),
            ),
            onPressed: widget.onPress,
              
            child: Text(widget.text),
          ),
          
    );
  }
}