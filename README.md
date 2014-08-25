# Herbstcampus 2014

Code examples for "Bullseye! Ein Blick auf Dart"

### Build and Run on the Command Line

Running a simple dart program:

    dart bin/01_basics.dart

Running a web application with pub (JavaScript):

    pub serve

Running a web application with pub (Dart):

    pub serve --no-dart2js

Compiling a web application to JavaScript:

    pub build

Creating and running a script snapshot:

    dart --snapshot=build/server.snapshot bin/server.dart
    dart build/server.snapshot

Running a Unit Test:

    dart test/server_test.dart
