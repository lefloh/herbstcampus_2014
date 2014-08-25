library checked_mode;

class Person {}

class Car {
  void drive() => print('brumm brumm');
}

main() {

  Object foo() => 'foo';
  String str = foo();
  print(str);

  Object bar() => 4711;
  String str2 = bar();
  print(str2);
  //  print(str2.split(','));

  //  Person p = new Car();
  //  p.drive();

}

/// convention
void publicMethod(String something) {
  var now = new DateTime.now();
}
