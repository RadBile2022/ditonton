import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test/test_tv')) {
    dir = dir.replaceAll('/test/test_tv', '');
  }
  return File('$dir/test/test_tv/$name').readAsStringSync();
}
