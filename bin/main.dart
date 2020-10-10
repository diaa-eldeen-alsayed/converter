import 'dart:io';
import 'package:prompter_sg/prompter_sg.dart';
import 'package:converter/src/converter.dart';

void main(List<String> args) {
  final prompter = new Prompter();
  final choice = prompter.askBinary('Are you here to convert an image ?');
  if (!choice) {
    exit(0);
  }
  final format = prompter.askMultiple('Select format:', buildFormatOption());
  final selectedFile =
      prompter.askMultiple('select an image to convert ', buildFileOption());
  final newPath = convertImage(selectedFile, format);
  final shouldOpen = prompter.askBinary('Open the image ?');
  if (shouldOpen) {
    Process.run('open', [newPath]);
  }
  //buildFileOption();
}

List<Option> buildFileOption() {
  return Directory.current.listSync().where((entity) {
    return FileSystemEntity.isFileSync(entity.path) &&
        entity.path.contains(new RegExp(r'\.(png|jpg|jpeg)'));
  }).map((entity) {
    final filename = entity.path.split(Platform.pathSeparator).last;
    return new Option(filename, entity);
  }).toList();
}

List<Option> buildFormatOption() {
  return [
    new Option('Convert to jpeg', 'jpeg'),
    new Option('Convert to png', 'png')
  ];
}
