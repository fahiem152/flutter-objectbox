import 'package:crud_flutter_objectbox/main.dart';
import 'package:crud_flutter_objectbox/objectbox.g.dart';
import 'package:flutter/material.dart';

import 'entities/person.dart';

class CrudObjectBox extends StatefulWidget {
  CrudObjectBox({super.key});

  @override
  State<CrudObjectBox> createState() => _CrudObjectBoxState();
}

class _CrudObjectBoxState extends State<CrudObjectBox> {
  final TextEditingController controller = TextEditingController();

  final TextEditingController editController = TextEditingController();

  final Box<Person> personBox = store.box();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD Object Box Person"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: () async {
              await showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Create'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          const SizedBox(
                            height: 4.0,
                          ),
                          TextFormField(
                            maxLength: 20,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                color: Colors.blueGrey,
                              ),
                              suffixIcon: Icon(
                                Icons.person,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueGrey,
                                ),
                              ),
                              helperText: 'Enter your Name',
                            ),
                            controller: controller,
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                            ),
                            onPressed: () {
                              personBox.put(Person(name: controller.text));
                              Navigator.pop(context);
                              controller.clear();
                              setState(() {});
                            },
                            child: const Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "List Person",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Column(
                children: personBox.getAll().map((e) {
                  return InkWell(
                    onTap: () async {
                      await showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          editController.text = e.name;
                          return AlertDialog(
                            title: const Text('Update'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                  TextFormField(
                                    maxLength: 20,
                                    decoration: const InputDecoration(
                                      labelText: 'Name',
                                      labelStyle: TextStyle(
                                        color: Colors.blueGrey,
                                      ),
                                      suffixIcon: Icon(
                                        Icons.person,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                      helperText: 'Enter your Name',
                                    ),
                                    controller: editController,
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueGrey,
                                    ),
                                    onPressed: () {
                                      personBox.put(Person(
                                          id: e.id, name: editController.text));
                                      Navigator.pop(context);
                                      editController.clear();
                                      setState(() {});
                                    },
                                    child: const Text(
                                      "Save",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          child: Text("${e.id}"),
                        ),
                        title: Text(e.name),
                        trailing: IconButton(
                          onPressed: () async {
                            await showDialog<void>(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirm'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                            'Are you sure you want to delete this item ${e.name}?'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey[600],
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("No"),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blueGrey,
                                      ),
                                      onPressed: () {
                                        personBox.remove(e.id);
                                        Navigator.pop(context);
                                        setState(() {});
                                      },
                                      child: const Text("Yes"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
