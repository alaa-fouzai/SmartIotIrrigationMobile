class User {
  String id;
  String FirstName;
  String LastName;
  String email;
  String Created_date;
  List Location_ids;




  User({this.id,this.FirstName, this.LastName, this.email, this.Created_date,
      this.Location_ids});

  factory User.fromJson(Map<String, dynamic> parsedJson){
    print('factory :' + parsedJson.toString());
    return User(id : parsedJson['_id'], FirstName : parsedJson['FirstName'], LastName : parsedJson['FirstName'], email : parsedJson['email'], Created_date : parsedJson['Created_date'], Location_ids : parsedJson['Location_ids']
    );
  }
  factory User.fromSMem(Map<String, dynamic> parsedJson){
    print('factory :' + parsedJson.toString());
    return User(id : parsedJson['id'], FirstName : parsedJson['FirstName'], LastName : parsedJson['FirstName'], email : parsedJson['email'], Created_date : parsedJson['Created_date'], Location_ids : parsedJson['Location_ids']
    );
  }

  @override
  String toString() {
    return '{_id: $id, FirstName: $FirstName, LastName: $LastName, email: $email, Created_date: $Created_date, Location_ids: $Location_ids}';
  }
  Map<String, dynamic> toJson() => {
    '_id': id,
    'FirstName': FirstName,
    'LastName': LastName,
    'email': email,
    'Created_date': Created_date,
    'Location_ids': Location_ids,
  };

  Map<String, dynamic> toMap() => {
    'id': id,
    'FirstName': FirstName,
    'LastName': LastName,
    'email': email,
    'Created_date': Created_date,
    'Location_ids': Location_ids,
  };

}