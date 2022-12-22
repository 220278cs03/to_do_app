import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import '../main.dart';
import '../model/todo_model.dart';
import '../store/store.dart';
import '../style/style.dart';
import 'add_to_do.dart';
import 'edit_todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<TodoModel> listOfTodo = [];
  List<TodoModel> listOfDone = [];
  bool _value = false;
  bool isChangeTheme = true;
  GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  void initState() {
    getInfo();
    _tabController = TabController(length: 2, vsync: this);
    print(listOfTodo);
    super.initState();
  }

  Future getInfo() async {
    listOfTodo = await LocalStore.getListTodo();
    listOfDone = await LocalStore.getListDone();
    isChangeTheme = await LocalStore.getTheme();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 32, left: 24),
                color: Style.primaryColor,
                child: Column(
                  children: [
                    Text(
                      "Change theme: ",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Row(
                      children: [
                        Switch(
                          activeColor: Style.whiteColor,
                          inactiveThumbColor: Style.whiteColor,
                          value: isChangeTheme,
                          onChanged: (s) {
                            isChangeTheme = !isChangeTheme;
                            MyApp.of(context)!.change();
                            LocalStore.setTheme(isChangeTheme);
                            setState(() {});
                          },
                        ),
                        Text(
                          isChangeTheme ? "On" : "Of",
                          style: Theme.of(context).textTheme.headline2,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "TODO LIST",
        ),
        leading: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            key.currentState!.openDrawer();
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Style.blackColor,
          unselectedLabelColor: Style.whiteColor,
          labelColor: Style.blackColor,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("To Do"),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.done),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Done"),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.done_all),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              itemCount: listOfTodo.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text(
                              "Tanlang",
                              style: Style.textStyleSemiBold(),
                            ),
                            actions: [
                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      "Edit (o`zgartirish)",
                                      style: Style.textStyleNormal(),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => EditTodoPage(
                                        todoModel: listOfTodo[index],
                                        index: index,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      "Delete (o`chirish)",
                                      style: Style.textStyleNormal(),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  LocalStore.removeTodo(index);
                                  listOfTodo.removeAt(index);
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                              ),
                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      "Cancel ",
                                      style: Style.textStyleNormal(),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Checkbox(
                              value: listOfTodo[index].isDone,
                              onChanged: (value) {
                                listOfTodo[index].isDone =
                                    !listOfTodo[index].isDone;
                                listOfDone.add(listOfTodo[index]);
                                LocalStore.setDone(
                                  listOfTodo[index],
                                );
                                LocalStore.removeTodo(index);
                                listOfTodo.removeAt(index);
                                setState(() {});
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                listOfTodo[index].title,
                                style: Theme.of(context).textTheme.headline2,
                              ),

                              Text(
                                listOfTodo[index].time,
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ],
                          )
                        ],
                      ),
                      const Divider(
                        color: Style.greyColor,
                      )
                    ],
                  ),
                );
              }),
          ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              itemCount: listOfDone.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text(
                              "Tanlang",
                              style: Style.textStyleSemiBold(),
                            ),
                            actions: [
                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      "Edit (o`zgartirish)",
                                      style: Style.textStyleNormal(),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => EditTodoPage(
                                        todoModel: listOfDone[index],
                                        index: index,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      "Delete (o`chirish)",
                                      style: Style.textStyleNormal(),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  LocalStore.removeDone(index);
                                  listOfDone.removeAt(index);
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                              ),
                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      "Cancel ",
                                      style: Style.textStyleNormal(),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: listOfDone[index].isDone,
                              onChanged: (value) {
                                listOfDone[index].isDone =
                                    !listOfDone[index].isDone;
                                listOfTodo.add(listOfDone[index]);
                                LocalStore.setTodo(
                                  listOfDone[index],
                                );
                                LocalStore.removeDone(index);
                                listOfDone.removeAt(index);
                                setState(() {});
                              }),
                          Text(
                            listOfDone[index].title,
                            style: Theme.of(context).textTheme.headline2,
                          )
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                );
              }),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () {
          // _value = !_value;
          // if (_value)
          //   MyApp.of(context)!.changeTheme(ThemeMode.dark);
          // else
          //   MyApp.of(context)!.changeTheme(ThemeMode.light);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const AddTodoPage()));
        },
        child: Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, gradient: Style.primaryGradient),
          child: const Icon(
            Icons.add,
            color: Style.whiteColor,
          ),
        ),
      ),
    );
  }
}
