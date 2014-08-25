library server;

import 'dart:convert' show JSON, UTF8;
import 'dart:io';

const String _PATH = '/votings/';

List<String> _votings = <String>[];

main() {
  HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 4040).then((HttpServer server) {
    print('server listening on port 4040');
    server.listen((HttpRequest request) {
      String path = request.uri.path.endsWith('/') ? request.uri.path : request.uri.path + '/';
      if (path != _PATH) {
        _send('Resource "${request.uri.path}" not found', HttpStatus.NOT_FOUND, ContentType.TEXT, request.response);
        return;
      } 
      switch (request.method) {
        case 'GET':
          _handleGet(request.response);
          break;
        case 'POST':
          _handlePost(request);
          break;
        default:
          _send('method "${request.method}"not allowed', HttpStatus.METHOD_NOT_ALLOWED, ContentType.TEXT, request.response);
      }
    }).onError((e) => print(e));
  });
}

void _handleGet(response) {
  var result = <String, int>{};
  for (var voting in _votings) {
    result[voting] = result.containsKey(voting) ? result[voting] + 1 : 1;
  }
  _send(JSON.encode(result), HttpStatus.OK, ContentType.JSON, response);
}

void _handlePost(HttpRequest request) {
  if (request.headers.contentType.mimeType != ContentType.parse('application/x-www-form-urlencoded').mimeType) {
    _send('please send form-data', HttpStatus.NOT_ACCEPTABLE, ContentType.TEXT, request.response);
    return;
  }
  UTF8.decodeStream(request).then((payload) {
    var vote = Uri.splitQueryString(payload)['voting'];
    if (vote == null || vote.trim().isEmpty) {
      _send('please send a vote', HttpStatus.BAD_REQUEST, ContentType.TEXT, request.response);
    } else {
      _votings.add(vote);
      _send('thanks for voting', HttpStatus.CREATED, ContentType.TEXT, request.response);    
    }
  });
}

void _send(Object msg, int status, ContentType contentType, HttpResponse response) {
  response.statusCode = status;
  response.headers.contentType = contentType;
  response.write(msg);
  response.close();
}