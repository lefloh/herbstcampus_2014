library basics;

const int THE_ANSWER = 42;

typedef String Concat(String a, String b);

// called by dart in webapp
main() {

  print('Hello Campus');
  print('The truth is $THE_ANSWER');
  print('${THE_ANSWER ~/ 2} is only half the truth');

  var list = [1, 2, 3];
  for (int i in list) {
    print(i);
  }

  list.reversed.forEach((i) => print(i));

  var map = {
    'foo': 12
  };

  map['bar'] = 13;
  map.forEach((k, v) => print('$k * 2 = ${v * 2}'));

  print(reverse('something'));

  print(repeat(' <3 '));
  print(repeat(' <3 <3 '));

  init();
  init(flag: true);

  String concat(String a, String b) => a + b;

  print(concat('foo', 'bar'));
  print(concat.runtimeType);
  print(concat is Concat);
  
  var foo = () => print('foo');
  foo();
  var bar = (s) => print(s);
  bar('foo');

  printFiltered([1, 2, 3, 4], (n) => n.isEven);
  
}

String reverse(String str) => str.split('').reversed.join('');

String repeat(String str, [times = 1]) {
  StringBuffer buffer = new StringBuffer(str);
  for (var i = 0; i < times; i++) {
    buffer.write(str);
  }
  return buffer.toString();
}

void init({flag}) {
  print('will init ${flag != null ? 'with flag: $flag' : ''}');
}

void printFiltered(List<int> items, bool filter(int n)) => items.where(filter).forEach(print);