import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo/controllers/ListController.dart';
import 'package:simple_todo/models/ListModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Todo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ListController listController = Get.put(ListController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ListController(),
        builder: (controller) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if (controller.isLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    if (controller.isLoadingAdd)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: controller.list.map((e) {
                        return Card(
                          child: ListTile(
                            title: Text(e.title),
                            subtitle: Text(e.desc),
                            trailing: PopupMenuButton(
                              itemBuilder: (BuildContext context) {
                                return const [
                                  PopupMenuItem(
                                    value: 'Edit',
                                    child: Text('Edit'),
                                  ),
                                  PopupMenuItem(
                                    value: 'Delete',
                                    child: Text('Delete'),
                                  ),
                                  // Add more options as needed
                                ];
                              },
                              onSelected: (value) async {
                                if (value == "Delete") {}

                                if (value == "Edit") {
                                  _modalEdit(controller, context, e);
                                }
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                // child: GetBuilder<ListController>(
                //     init: ListController(),
                //     builder: (controller) {
                //       if (controller.isLoading) {
                //         return const Center(
                //           child: CircularProgressIndicator(),
                //         );
                //       }
                //       return
                //     }),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _modalAdd(controller, context);
              },
              tooltip: 'Nambah Todo',
              child: const Icon(Icons.add),
            ),
          );
        });
  }

  Future<dynamic> _modalAdd(ListController controller, BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: listController.title,
                  decoration: const InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: listController.desc,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 50),
                      minimumSize: const Size(200, 50),
                      maximumSize: const Size(200, 50),
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () async {
                      controller.addList();
                      Navigator.pop(context);
                    },
                    child: const Text("Tambah",
                        style: TextStyle(color: Colors.white)))
              ],
            ),
          );
        });
  }

  Future<dynamic> _modalEdit(ListController controller, BuildContext context, ListModel e) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: controller.title,
                  decoration: const InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: TextEditingController(text: e.desc),
                  decoration: const InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 50),
                    minimumSize: const Size(200, 50),
                    maximumSize: const Size(200, 50),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    listController.editList(e.id);
                    Navigator.pop(context);
                  },
                  child:
                      const Text("Ubah", style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          );
        });
  }
}
