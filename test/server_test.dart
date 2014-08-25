import 'dart:async';
import 'dart:io';
import 'dart:convert' show UTF8, JSON;

import 'package:unittest/unittest.dart';
import 'package:unittest/vm_config.dart';

var _host = InternetAddress.LOOPBACK_IP_V4.host;
var _port = 4040;
HttpClient _client;

main() {
  
  useVMConfiguration();
    
  test('votes', () {
    _client = new HttpClient();
    return Future.wait([ _testPost('good'), _testPost('good'), _testPost('bad') ]).then((_) {
      _testGet();
    });
  });
  
}

Future _testPost(value) {
  return _client.post(_host, _port, '/votings/').then((request) {
    request.headers.contentType = ContentType.parse('application/x-www-form-urlencoded');
    request.write(Uri.decodeFull('voting=$value'));
    return request.close();
  }).then(expectAsync((HttpClientResponse response) {
    expect(response.statusCode, 201);
    return response.headers.value('Location');
  }));
}

_testGet() {
  _client.get(_host, _port, '/votings/').then(expectAsync((request) {
    return request.close();  
  })).then(expectAsync((HttpClientResponse response) {
    expect(response.statusCode, 200);
    return UTF8.decodeStream(response).then(expectAsync((payload) {
      var results = JSON.decode(payload);
      expect(results['good'], 2);
      expect(results['bad'], 1);
    }));     
  }));
}