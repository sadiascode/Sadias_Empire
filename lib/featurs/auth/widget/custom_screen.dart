import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomScreen extends StatefulWidget {
  final String svgPath;
  final double svgHeight;
  final double svgWidth;
  final Widget child;

  const CustomScreen({
    super.key,
    required this.svgPath,
    required this.svgHeight,
    required this.svgWidth,
    required this.child,
  });

  @override
  State<CustomScreen> createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            color: const Color(0xffF7F7F7),
          ),

          // SVG Image
          Positioned(
            top: 110,
            left: 10,
            right: 10,
            child: Center(
              child: Image.asset(
                widget.svgPath,
                height: widget.svgHeight,
                width: widget.svgWidth,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Bottom Card UI
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: 0.6,
              widthFactor: 0.93,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                  ),
                ),
                child: widget.child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}