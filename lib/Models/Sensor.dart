class Sensor {
  String id;
String Name;
String SensorType;
String Description;
List SensorCoordinates;
DateTime createdate;
List data;

  Sensor(this.id, this.Name, this.SensorType, this.Description,
      this.SensorCoordinates, this.createdate, this.data);

  @override
  String toString() {
    return 'Sensor{id: $id, Name: $Name, SensorType: $SensorType, Description: $Description, SensorCoordinates: $SensorCoordinates, createdate: $createdate, data: $data}';
  }


}