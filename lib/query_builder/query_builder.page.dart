// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:crud_flutter_objectbox/main.dart';
import 'package:crud_flutter_objectbox/objectbox.g.dart';
import 'package:crud_flutter_objectbox/query_builder/entities/motor_cycle.dart';
import 'package:crud_flutter_objectbox/query_builder/entities/objectbox.dart';

class QueryBuilderPage extends StatefulWidget {
  QueryBuilderPage({super.key});

  @override
  State<QueryBuilderPage> createState() => _QueryBuilderPageState();
}

class _QueryBuilderPageState extends State<QueryBuilderPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  final TextEditingController editNameController = TextEditingController();
  final TextEditingController editYearController = TextEditingController();

  final Box<MotorCycle> motorCycleBox = storeMotorCycle.box();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Query Builder Page"),
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
                            controller: nameController,
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          TextFormField(
                            maxLength: 20,
                            decoration: const InputDecoration(
                              labelText: 'Year',
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
                              helperText: 'Enter your Release Year (2022)',
                            ),
                            controller: yearController,
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                            ),
                            onPressed: () {
                              motorCycleBox.put(
                                MotorCycle(
                                  serialNumber: DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString(),
                                  name: nameController.text,
                                  releaseYear: yearController.text,
                                ),
                              );
                              print(editYearController.text);
                              Navigator.pop(context);
                              nameController.clear();
                              yearController.clear();

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
        child: Column(
          children: [
            const Text(
              "List MotorCycle",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: motorCycleBox.getAll().map((e) {
                    return InkWell(
                      onTap: () async {
                        await showDialog<void>(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            editNameController.text = e.name;
                            editYearController.text = e.releaseYear;
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
                                      controller: editNameController,
                                    ),
                                    const SizedBox(
                                      height: 4.0,
                                    ),
                                    TextFormField(
                                      maxLength: 20,
                                      decoration: const InputDecoration(
                                        labelText: 'Year',
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
                                        helperText: 'Enter your Releas Year',
                                      ),
                                      controller: editYearController,
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blueGrey,
                                      ),
                                      onPressed: () {
                                        motorCycleBox.put(MotorCycle(
                                            motorcycleId: e.motorcycleId,
                                            serialNumber: e.serialNumber,
                                            name: editNameController.text,
                                            releaseYear:
                                                editYearController.text));
                                        Navigator.pop(context);
                                        editNameController.clear();
                                        editYearController.clear();
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
                            child: Text("${e.motorcycleId}"),
                          ),
                          title: Text(e.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.releaseYear,
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                ),
                              ),
                              Text(e.serialNumber),
                            ],
                          ),
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
                                          motorCycleBox.remove(e.motorcycleId);
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
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Wrap(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      QueryBuilder<MotorCycle> builder = motorCycleBox
                          .query(MotorCycle_.releaseYear.equals("2018"));

                      Query<MotorCycle> query = builder.build();
                      List<MotorCycle> motorCycles = query.find();

                      await showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Quey 2018'),
                                Text(
                                  query.describeParameters(),
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                  children: motorCycles
                                      .map((e) => CardMotorCycle(e: e))
                                      .toList()),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Ok"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text("Query 2018")),
                const SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                    onPressed: () async {
                      QueryBuilder<MotorCycle> builder = motorCycleBox
                          .query(MotorCycle_.releaseYear.equals("2021"));

                      Query<MotorCycle> query = builder.build();
                      List<MotorCycle> motorCycles = query.find();

                      await showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Quey 2021'),
                                Text(
                                  query.describeParameters(),
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                  children: motorCycles
                                      .map((e) => CardMotorCycle(e: e))
                                      .toList()),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Ok"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text("Query 2021")),
                const SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                    onPressed: () async {
                      QueryBuilder<MotorCycle> builder = motorCycleBox
                          .query()
                          .order(MotorCycle_.releaseYear,
                              flags: Order.descending);

                      Query<MotorCycle> query = builder.build();
                      List<MotorCycle> motorCycles = query.find();

                      await showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Query DSC Year'),
                                Text(
                                  query.describeParameters(),
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                  children: motorCycles
                                      .map((e) => CardMotorCycle(e: e))
                                      .toList()),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Ok"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text("Query DSC Year")),
                const SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    QueryBuilder<MotorCycle> builder = motorCycleBox.query(
                        MotorCycle_.name
                            .startsWith("v")
                            .and(MotorCycle_.releaseYear.equals("2018")));

                    Query<MotorCycle> query = builder.build();
                    List<MotorCycle> motorCycles = query.find();

                    await showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Query 2018 and v'),
                              Text(
                                query.describeParameters(),
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                                children: motorCycles
                                    .map((e) => CardMotorCycle(e: e))
                                    .toList()),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Ok"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("Query 2018 and b"),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                    onPressed: () async {
                      QueryBuilder<MotorCycle> builder = motorCycleBox.query(
                          MotorCycle_.name
                              .startsWith("v")
                              .or(MotorCycle_.releaseYear.equals("2018")));

                      Query<MotorCycle> query = builder.build();
                      List<MotorCycle> motorCycles = query.find();

                      await showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Query 2018 or V'),
                                Text(
                                  query.describeParameters(),
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                  children: motorCycles
                                      .map((e) => CardMotorCycle(e: e))
                                      .toList()),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Ok"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text("Query 2018 or v")),
                const SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                    onPressed: () async {
                      QueryBuilder<MotorCycle> builder = motorCycleBox
                          .query(MotorCycle_.name
                              .startsWith("v")
                              .or(MotorCycle_.releaseYear.equals("2018")))
                          .order(MotorCycle_.name, flags: Order.descending);

                      Query<MotorCycle> query = builder.build();
                      List<MotorCycle> motorCycles = query.find();

                      await showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Query 2018 or V DSC'),
                                Text(
                                  query.describeParameters(),
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                  children: motorCycles
                                      .map((e) => CardMotorCycle(e: e))
                                      .toList()),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Ok"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text("Query 2018 or v DSC")),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CardMotorCycle extends StatelessWidget {
  final MotorCycle e;
  const CardMotorCycle({
    Key? key,
    required this.e,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Text("${e.motorcycleId}"),
        ),
        title: Text(e.name),
        subtitle: Text(e.serialNumber),
        trailing: Text(
          e.releaseYear,
          style: TextStyle(
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}
