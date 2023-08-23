// import 'dart:convert';
import 'dart:html';
import 'package:dio/dio.dart';

final InputElement toDoInput = querySelector('#to-do-input') as InputElement;
final UListElement toDoList = querySelector('#to-do-list') as UListElement;
final ButtonElement deleteAll = querySelector('#delete-all') as ButtonElement;

final dio = Dio();
void get() async {
  Response response;
  response =
      await dio.get('http://localhost:3030/', options: Options(method: 'GET'));
  print(response.data.length.toString());
  int i = 0;
  for (i; i < response.data.length; i++) {
    final newToDo = LIElement()
      ..text = '${response.data[i]['id']} ${response.data[i]['Name']}';
    newToDo.onClick.listen((_) async {
      print(newToDo.innerText.split(' ')[0]);
      response = await dio.delete(
          'http://localhost:3030/p/${newToDo.innerText.split(' ')[0]}',
          data: [
            {"id": int.parse(newToDo.innerText.split(' ')[0])}
          ],
          options: Options(
            method: 'DELETE',
          ));
      newToDo.remove();
    });
    toDoList.children.add(newToDo);
    // print('ali');
  }
  // querySelector('#id')?.text = response.data[0]['Name'].toString();
  // querySelector('#name')?.text = response.data[0]['Age'].toString();
}

void post() async {
  Response response;
  response = await dio.post('http://localhost:3030/p',
      data: [
        {"Name": toDoInput.value, "Age": toDoInput.value, "id": null}
      ],
      options: Options(
        method: 'POST',
      ));
  print(response.data.toString());
  final newToDo = LIElement()
    ..text = '${response.data[0]['id']} ${response.data[0]['Name']}';
  newToDo.onClick.listen((_) async {
    print(newToDo.innerText.split(' ')[0]);
    response = await dio.delete(
        'http://localhost:3030/p/${newToDo.innerText.split(' ')[0]}',
        data: [
          {"id": int.parse(newToDo.innerText.split(' ')[0])}
        ],
        options: Options(
          method: 'DELETE',
        ));
    newToDo.remove();
  });
  toDoInput.value = '';
  toDoList.children.add(newToDo);
  // querySelector('#id-post')?.text = response.data[0]['Name'].toString();
  // querySelector('#name-post')?.text = response.data[0]['Age'].toString();
}

void main() {
  toDoInput.onChange.listen(addToDoItem);
  deleteAll.onClick.listen((_) => toDoList.children.clear());
  get();
}

void addToDoItem(Event e) {
  post();
}
