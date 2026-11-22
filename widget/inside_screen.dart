import 'package:favourite_places/model/blueprint.dart';
import 'package:flutter/material.dart';

class InsideScreen extends StatelessWidget {
  const InsideScreen(this.value, {super.key});
  final Blueprint value;
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          value.name,
          style: Theme.of(ctx).textTheme.titleLarge!.copyWith(
            color: Theme.of(ctx).colorScheme.onSurface,
          ),
        ),
        backgroundColor: Theme.of(ctx).colorScheme.onPrimary,
      ),
      body: Stack(
        children: [
          Image.file(
            value.image,
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
