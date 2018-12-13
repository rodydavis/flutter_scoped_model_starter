import 'dart:async';
import 'dart:core';

import '../../constants.dart';
import '../../utils/date_formatter.dart';
import '../classes/unify/response.dart';
import '../models/auth_model.dart';
import '../../utils/null_or_empty.dart';
import '../web_client.dart';

class TaskRepository {
  final WebClient webClient;

  const TaskRepository({
    this.webClient = const WebClient(),
  });

  Future<ResponseMessage> loadList(AuthModel auth, DateTime date) async {
    final _date = formatDateCustom(date);
    print("Date: $_date");
    final response =
        await webClient.get(kApiUrl + '/calendar/$_date', auth: auth);
    print("Loaded Tasks $date => $response");

    // if (response.toString().contains("No Tasks Found")) {
    //   print("No Tasks => $response");
    //   var _list = BuiltList<Task>([]);
    //   return _list;
    // }

    // var list = new BuiltList<Task>(
    //   response.map((task) {
    //     return serializers.deserializeWith(Task.serializer, task);
    //   }),
    // );

    var list = ResponseMessage.fromJson(response);

    return list;
  }

  // Future saveData(AuthModel auth, Task task,
  //     [EntityAction action]) async {
  //   var data = serializers.serializeWith(Task.serializer, task);
  //   var response;

  //   if (task.isNew) {
  //     response =
  //         await webClient.post(kApiUrl + '/calendar/new', json.encode(data));
  //   } else {
  //     var url = kApiUrl + '/calendar/info/' + task.id.toString();
  //     response =
  //         await webClient.put(url, json.encode(data), token: auth?.token);
  //   }

  //   return serializers.deserializeWith(Task.serializer, response);
  // }
}
