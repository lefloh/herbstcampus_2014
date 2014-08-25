import 'dart:convert' show JSON;
import 'dart:html';
import 'package:bootjack/bootjack.dart';

void main() {
  Alert.use();
  querySelector('form').onSubmit.listen(_vote);
}

void _vote(event) {
  event.preventDefault();
  _hideError();
  var radio = event.target.query('[name=voting]:checked');
  if (radio == null) {
    _showError();
    return;
  }
  var formData = { 'voting' : radio.value };
  HttpRequest.postFormData(event.target.action, formData).then((request) {
    if (request.status != 201) {
      _showError();
      return;
    }
    _updateResults();
  });
}

void _updateResults() {
  HttpRequest.getString((querySelector('form') as FormElement).action).then((response) {
    var votings = JSON.decode(response);
    var sum = votings.values.reduce((val, element) => val + element);
    votings.forEach((vote, cnt) {
      var percentage = (cnt / sum * 100).toStringAsFixed(2);
      querySelector('#$vote')
        ..text = '$percentage %'
        ..attributes['aria-valuenow'] = percentage
        ..style.width = '${percentage}%';

    });
    querySelector('#results').classes.remove('hidden');
  });
}

_hideError() => querySelector('#error').classes.add('hidden');

_showError() => querySelector('#error').classes.remove('hidden');
