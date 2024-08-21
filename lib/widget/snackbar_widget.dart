import 'package:flutter/material.dart';

showSnackbar(BuildContext context) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text("Error")));
}
