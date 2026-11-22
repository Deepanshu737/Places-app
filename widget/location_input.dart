/*import 'dart:convert';
import 'package:favourite_places/model/blueprint.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput(this.onGettingLocation,{super.key});
  final void Function(OnPreview location) onGettingLocation;

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  OnPreview? _onLocation;
  var isGettingLocation = false;
String get location{//this is for location snapshots
  final lat=_onLocation!.latitiude;
  final lon=_onLocation!.longitude;

  return'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lon&zoom=16&size=600x300&mapt&markers=color:green%7Clabel:G%7C$lat,$lon&key=bdc_512acc824b044a1ab1b722849ddc1f74';
}
  void getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      isGettingLocation = true;
    });
    locationData = await location.getLocation();

    final lat = locationData.latitude; 
    final long = locationData.longitude;
    final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latIng=$lat,$long&key=bdc_512acc824b044a1ab1b722849ddc1f74');
    final response = await http.get(url);
    final onGetResponse = json.decode(response.body);
    final result = onGetResponse['results'][0]['formated_address'];
if(result==null){
  return;
}
// bdc_512acc824b044a1ab1b722849ddc1f74
    setState(() {
      _onLocation=result;
      
widget.onGettingLocation(_onLocation!);
      isGettingLocation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget onLocation = Text(
      'No Location Found!',
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
    if(_onLocation!=null){
   onLocation=Image.network(location);
    }
    if (isGettingLocation == true) {
      onLocation = CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.3),
            ),
          ),
          alignment: Alignment.center,
          child: onLocation,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: getLocation,
              icon: Icon(Icons.location_on),
              label: Text('Get Current Location'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map),
              label: Text('Select Location'),
            ),
          ],
        ),
      ],
    );
  }
}
*/