class Location {
String id;
String SiteName;
bool AutomaticIrrigation;
String Description;
List<double> Coordinates;
String Created_date;
List<String> Sensor_ids;


Location({this.id,this.SiteName, this.AutomaticIrrigation, this.Description,
    this.Coordinates, this.Created_date, this.Sensor_ids});

factory Location.fromJson(Map<String, dynamic> parsedJson){
  print('Location factory :' + parsedJson.toString());
  return Location(id : parsedJson['_id'], SiteName : parsedJson['SiteName'], AutomaticIrrigation : parsedJson['AutomaticIrrigation'],
      Description : parsedJson['Description'], Coordinates : parsedJson['Coordinates'], Sensor_ids : parsedJson['Sensor_ids']
  );
}

@override
String toString() {
  return 'Location{id: $id, SiteName: $SiteName, AutomaticIrrigation: $AutomaticIrrigation, Description: $Description, Coordinates: $Coordinates, Created_date: $Created_date, Sensor_ids: $Sensor_ids}';
}


}