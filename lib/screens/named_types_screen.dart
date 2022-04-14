import 'package:flutter/material.dart';

class NamedTypesScreen extends StatefulWidget {
  const NamedTypesScreen({Key? key}) : super(key: key);

  @override
  State<NamedTypesScreen> createState() => _NamedTypesScreenState();
}

class _NamedTypesScreenState extends State<NamedTypesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text("Named types");
  }
}
