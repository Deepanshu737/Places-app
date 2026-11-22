import 'dart:io';
import'package:uuid/uuid.dart';
const uuid=Uuid();
// class OnPreview{
//    OnPreview(this.result,this.latitiude,this.longitude,);
//  final String result;
//  final double latitiude;
//  final double longitude;
// }
class Blueprint {
 Blueprint(this.name,this.image,/*this.preview,*/[String? id]) : id = id ?? uuid.v4();
  final String name;
  final String id;
  final File image;
  //final OnPreview preview;
}