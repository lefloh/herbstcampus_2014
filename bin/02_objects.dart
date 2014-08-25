library objects;

/// the Superhero class
class Superhero {
  
  final String name;
  
  String _realName;
    
  Superhero(this.name);
  
  Superhero.withRealName(this.name, this._realName);
  
  String get realName => _realName;
  
  set realName(realName) => _realName = realName is String ? realName : 'UNKNOWN'; 
  
  Team operator +(Superhero other) => new Team([this, other]);
  
  int get hashCode => name.hashCode;
  
  bool operator ==(Object other) => other.runtimeType == Superhero && (other as Superhero).name == name;
  
  toString() => '$name - alias: $realName';
  
}

class Team {
  
  List<Superhero> heros;
  
  Team(this.heros);
  
  toString() => 'TeamMembers: $heros';
  
}

class Cache {
  
  static final Cache _INSTANCE = new Cache._internal();
  
  static Map<String, String> _store;
  
  factory Cache() {
    if (_store == null) {
      _store = <String, String>{};
    }
    return _INSTANCE;
  }
  
  Cache._internal();
}

class Person extends Object with Persistence {
  
  String firstname;
  
  String lastname;
  
  DateTime birthdate;
  
  toString() => '$lastname, $firstname';
  
}

class Customer extends Person {
  
  int id;
  
  toString() => '$id: ${super.toString()}';
  
}

abstract class Vehicle {
  
  int get maxSpeed;
  
  void drive();
  
}

class Car extends Vehicle {
  
  int get maxSpeed => 300;
  
  void drive() {
    // 
  }
  
}

abstract class Persistence {
  
  void save() => print('saving "${toString()}" to Database');
  
  Object read() => this; // read from somewhere
  
}

main() {
  
  Superhero spiderman = new Superhero('Spiderman');
  spiderman.realName = 'Peter Parker';
  
  print(spiderman);
  
  Superhero batman = new Superhero.withRealName('Batman', 'Bruce Wayne');

  print(batman);
  
//  batman.name = 'Green Lantern'; 
  batman.realName = 47;
  
  print(batman);
  
  var team = batman + spiderman;
  print(team);
  
  print(batman == spiderman);
  
  Cache cache = new Cache();
  Cache cache2 = new Cache();
  print(identical(cache, cache2));
  print(cache == cache2);
  
  Person james = new Person()
                      ..firstname = 'James'
                      ..lastname = 'Bond'
                      ..birthdate = DateTime.parse('1978-04-12');
  
  print(james);
  
  Customer john = new Customer()
                      ..id = 4711
                      ..firstname = 'John'
                      ..lastname = 'Doe';
  
  print(john);
  
  james.save();
  john.save();
  
}

class Alert {
  
  var element;
  
  Alert(this.element);
  
}