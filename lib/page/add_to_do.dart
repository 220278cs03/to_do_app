import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/todo_model.dart';
import '../store/store.dart';
import '../style/style.dart';
import 'home_page.dart';
import 'keyboard_diss.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController birthDate = TextEditingController();

  bool isBirthDateEmpty = true;
  bool isEmpty = true;

  String dateText = "";

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OnUnFocusTap(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Style.primaryColor,
          title: Text(
            "Add Todo",
            style: Style.textStyleSemiBold(textColor: Style.whiteColor),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: textEditingController,
                onChanged: (value) {
                  if (value.isEmpty) {
                    isEmpty = true;
                  } else {
                    isEmpty = false;
                  }

                  setState(() {});
                },
                decoration: const InputDecoration(
                  hintText: "Text",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      borderSide: BorderSide(color: Style.greyColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      borderSide: BorderSide(color: Style.greyColor)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      borderSide: BorderSide(color: Style.greyColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      borderSide: BorderSide(color: Style.greyColor)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                controller: birthDate,
                onChanged: (value) {
                  if (value.isEmpty) {
                    isBirthDateEmpty = true;
                  } else {
                    isBirthDateEmpty = false;
                  }
                  setState(() {

                  });
                },
                cursorColor: Colors.black,
                readOnly: true,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        borderSide: BorderSide(color: Style.greyColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        borderSide: BorderSide(color: Style.greyColor)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        borderSide: BorderSide(color: Style.greyColor)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        borderSide: BorderSide(color: Style.greyColor)),
                    hintText: 'dd/mm/yyyy',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_month),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now()
                                    .subtract(Duration(days: 50 * 365)),
                                lastDate: DateTime.now()
                                    .add(Duration(days: 50 * 365)))
                            .then((value) {
                          dateText = DateFormat("EE, MMM dd, yyyy")
                              .format(value ?? DateTime.now());
                          birthDate.text = dateText;
                          setState(() {});
                        });
                      },
                    )),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
              gradient: isEmpty && isBirthDateEmpty
                  ? Style.primaryDisableGradient
                  : Style.primaryGradient,
              borderRadius: BorderRadius.circular(100)),
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () async {
              if (textEditingController.text.isNotEmpty && birthDate.text.isNotEmpty) {
                LocalStore.setTodo(
                    TodoModel(title: textEditingController.text, time: birthDate.text));
                print(textEditingController.text );
                print(birthDate.text);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    (route) => false);
              }
            },
            child: Center(
              child: Text(
                "Add",
                style: Style.textStyleNormal(textColor: Style.whiteColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
