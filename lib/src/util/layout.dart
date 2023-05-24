import 'package:flutter/material.dart';

enum LayoutBreakpoint {
  phone(620),
  pad(1050);

  final int width;

  const LayoutBreakpoint(this.width);

  bool get isPhone => this == LayoutBreakpoint.phone;
}

typedef ResponsiveLayoutBuilder = Widget Function(
    BuildContext context, LayoutBreakpoint breakpoint);

/// A responsive layout widget that changes its layout based on the screen size.
///
/// See also:
/// - [LayoutBreakpoint]
/// - [ResponsiveLayoutBuilder]
class ResponsiveLayout extends StatelessWidget {
  final ResponsiveLayoutBuilder builder;

  const ResponsiveLayout({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= LayoutBreakpoint.phone.width) {
        return builder(context, LayoutBreakpoint.phone);
      } else {
        return builder(context, LayoutBreakpoint.pad);
      }
    });
  }
}
