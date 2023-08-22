// import 'dart:convert';
import 'dart:html';
import 'package:dio/dio.dart';

final InputElement toDoInput = querySelector('#to-do-input') as InputElement;
final UListElement toDoList = querySelector('#to-do-list') as UListElement;

final dio = Dio();
void get() async {
  Response response;
  response =
      await dio.get('http://localhost:3030/', options: Options(method: 'GET'));
  print(response.data.toString());
  // querySelector('#id')?.text = response.data[0]['Name'].toString();
  // querySelector('#name')?.text = response.data[0]['Age'].toString();
  final newToDo = LIElement()..text = response.data[0]['Name'].toString();
  toDoInput.value = '';
  toDoList.children.add(newToDo);
}

void post() async {
  Response response;
  response = await dio.post('http://localhost:3030/post',
      data: [
        {"Name": toDoInput.value, "Age": toDoInput.value}
      ],
      options: Options(
        method: 'POST',
      ));
  print(response.data.toString());
  // querySelector('#id-post')?.text = response.data[0]['Name'].toString();
  // querySelector('#name-post')?.text = response.data[0]['Age'].toString();
}

void main() {
  toDoInput.onChange.listen(addToDoItem);
}

void addToDoItem(Event e) {
  post();
  get();
}
