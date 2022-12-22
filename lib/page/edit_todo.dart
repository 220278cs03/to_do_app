import 'package:flutter/material.dart';

import '../model/todo_model.dart';
import '../store/store.dart';
import '../style/style.dart';

import 'home_page.dart';
import 'keyboard_diss.dart';

class EditTodoPage extends StatefulWidget {
  final TodoModel todoModel;
  final int index;

  const EditTodoPage({Key? key, required this.todoModel, required this.index})
      : super(key: key);

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  TextEditingController textEditingController = TextEditingController();
  String oldTitle = "";

  bool isEmpty = true;

  @override
  void initState() {
    textEditingController.text = widget.todoModel.title;
    oldTitle = widget.todoModel.title;
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Chiqishga ishinaszmi ???"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text("Ha")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Yoq"))
                ],
              );
            });
        return Future.value(false);
      },
      child: OnUnFocusTap(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Style.primaryColor,
            title: Text(
              "Edit Todo",
              style: Style.textStyleSemiBold(textColor: Style.whiteColor),
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextFormField(
                autofocus: true,
                controller: textEditingController,
                onChanged: (value) {
                  if (value.isEmpty || oldTitle == value) {
                    isEmpty = true;
                  } else {
                    isEmpty = false;
                  }
                  setState(() {});
                },
                decoration: const InputDecoration(
                  labelText: "Text",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  disabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
                gradient: isEmpty
                    ? Style.primaryDisableGradient
                    : Style.primaryGradient,
                borderRadius: BorderRadius.circular(100)),
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () async {
                if (!isEmpty) {
                  widget.todoModel.isDone
                      ? LocalStore.editLocalDone(
                      TodoModel(
                          title: textEditingController.text,
                          isDone: widget.todoModel.isDone,
                        time: ''
                      ),
                      widget.index)
                      : LocalStore.editLocal(
                      TodoModel(
                          title: textEditingController.text,
                          isDone: widget.todoModel.isDone,
                        time: ''
                      ),
                      widget.index);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                          (route) => false);
                }
              },
              child: Center(
                child: Text(
                  "Edit",
                  style: Style.textStyleNormal(textColor: Style.whiteColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
