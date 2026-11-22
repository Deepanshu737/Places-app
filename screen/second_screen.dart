import 'dart:io';

import 'package:favourite_places/model/blueprint.dart';
import 'package:favourite_places/provider/consumer.dart';
import 'package:favourite_places/widget/image_input.dart';
// import 'package:favourite_places/widget/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecondScreen extends ConsumerStatefulWidget {
  const SecondScreen({super.key});
  @override
  ConsumerState<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends ConsumerState<SecondScreen> {
  String enteredPlace = '';
  final _formKey = GlobalKey<FormState>();
File? enteredImage;
// OnPreview?answer;

  void onSave() {
      if(enteredImage==null/*||answer==null*/){
        return ;
      }
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
ref.watch(screenProvider.notifier).getData(Blueprint(enteredPlace,enteredImage!,/*answer!*/));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(ctx) => Scaffold(
    appBar: AppBar(
      title: Text(
        'Add new places',
        style: Theme.of(ctx).textTheme.titleLarge!.copyWith(
          color: Theme.of(ctx).colorScheme.onSurface,
        ),
      ),
          backgroundColor: Theme.of(ctx).colorScheme.onPrimary,
),
    body: Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(23.0),
            child: TextFormField(
              decoration: InputDecoration(label: Text('Place')),
              maxLength: 50,
              onSaved: (value) => enteredPlace = value!,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(ctx).colorScheme.onSurface,
              ),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.length <= 1 ||
                    value.length >= 50) {
                  return 'Invalid data.Please try again';
                }
                return null;
              },
            ),
          ),
         TypeImage((image){
          enteredImage=image;
         }),
           SizedBox(height: 10,),
//            LocationInput((location){
// answer=location;
//            }),
         SizedBox(height: 10,),
          ElevatedButton.icon(
            onPressed: onSave,
            icon: Icon(Icons.add),
            label: Text('Add Places'),
          ),
        ],
      ),
    ),
  );
}
