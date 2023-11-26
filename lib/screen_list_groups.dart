import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekday_selector/weekday_selector.dart';

import 'data.dart';
import 'the_drawer.dart';

class ScreenListGroups extends StatefulWidget {
  List<UserGroup> userGroups;

  ScreenListGroups({super.key, required this.userGroups});

  @override
  State<ScreenListGroups> createState() => _ScreenListGroupsState();
}

class _ScreenListGroupsState extends State<ScreenListGroups> {
  late List<UserGroup> userGroups;

  @override
  void initState() {
    super.initState();
    userGroups = widget.userGroups; // the userGroups of ScreenListGroups
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // TODO: assign names like New group 1, New group 2...
          UserGroup newUserGroup = UserGroup(
              Data.defaultName,
              Data.defaultDescription,
              Data.defaultAreas,
              Data.defaultSchedule,
              Data.defaultActions, <User>[]);
          userGroups.add(newUserGroup);
          setState(() {});
        },
      ),
      drawer: TheDrawer(context).drawer,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("User groups"),
      ),
      body: ListView.separated(
        // it's like ListView.builder() but better
        // because it includes a separator between items
        padding: const EdgeInsets.all(16.0),
        itemCount: userGroups.length,
        itemBuilder: (BuildContext context, int index) =>
            _buildRow(userGroups[index], index),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  Widget _buildRow(UserGroup userGroup, int index) {
    return ListTile(
      title: Text(userGroup.name),
      trailing: Text('${userGroup.users.length}'),
      onTap: () => Navigator.of(context)
          .push(
            MaterialPageRoute<void>(
                builder: (context) => ScreenGroup(userGroup: userGroup)),
          )
          .then((var v) => setState(() {})),
    );
  }
}

class ScreenGroup extends StatelessWidget {
  final UserGroup userGroup;

  ScreenGroup({Key? key, required this.userGroup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Group ${userGroup.name}"),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        body: Center(
            child: GridView.count(
          crossAxisCount: 2,
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                color: Theme.of(context).colorScheme.secondary,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.description_outlined,
                        size: 70,
                        color: Colors.white,
                      ),
                      onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute<void>(
                            builder: (context) =>
                                MyCreateInfo(userGroup: userGroup)))
                      },
                    ),
                    Text("info",
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                  ],
                ))),
            Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                color: Theme.of(context).colorScheme.secondary,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.schedule,
                        size: 70,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute<void>(
                            builder: (context) =>
                                MyCreateSchedule(userGroup: userGroup)));
                      },
                    ),
                    Text("schedule",
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                  ],
                ))),
            Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                color: Theme.of(context).colorScheme.secondary,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.room_preferences,
                        size: 70,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute<void>(
                            builder: (context) =>
                                MyCreateActions(userGroup: userGroup)));
                      },
                    ),
                    Text("actions",
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                  ],
                ))),
            Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                color: Theme.of(context).colorScheme.secondary,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.holiday_village,
                        size: 70,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Text("Places",
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                  ],
                ))),
            Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                color: Theme.of(context).colorScheme.secondary,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      color: Colors.white,
                      icon: Icon(
                        Icons.manage_accounts,
                        size: 70,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute<void>(
                            builder: (context) =>
                                MyCreateUsers(userGroup: userGroup)));
                      },
                    ),
                    Text("Users",
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                  ],
                ))),
          ],
        )));
  }
}

class MyCreateInfo extends StatefulWidget {
  final userGroup;

  const MyCreateInfo({super.key, required this.userGroup});

  @override
  _MyCreateInfoState createState() {
    return _MyCreateInfoState(userGroup);
  }
}

class _MyCreateInfoState extends State<MyCreateInfo> {
  late UserGroup userGroup;
  final _formKey = GlobalKey<FormState>();

  _MyCreateInfoState(userGroup) {
    this.userGroup = userGroup;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Info ${userGroup.name}"),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        body: Form(
            key: _formKey,
            child: Container(
                margin:
                    const EdgeInsets.only(top: 120.0, left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 80.0),
                        child: TextFormField(
                            initialValue: "${userGroup.name}",
                            decoration: InputDecoration(
                                labelText: "name group",
                                fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: BorderSide())))),
                    Padding(
                      padding: EdgeInsets.only(bottom: 50),
                      child: TextFormField(
                          maxLines: 5,
                          initialValue: "${userGroup.description}",
                          decoration: InputDecoration(
                              labelText: "description",
                              fillColor: Colors.transparent,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide()))),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Saved')));
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ))));
  }
}

class MyCreateSchedule extends StatefulWidget {
  final userGroup;

  const MyCreateSchedule({super.key, required this.userGroup});

  @override
  _MyCreateScheduleState createState() {
    return _MyCreateScheduleState(userGroup);
  }
}

class _MyCreateScheduleState extends State<MyCreateSchedule> {
  late UserGroup userGroup;
  final _formKey = GlobalKey<FormState>();

  late List<bool> values = List.filled(7, false);

  late DateTime firstDate = DateTime.now();
  late DateTime lastDate = firstDate.add(const Duration(days: (365 * 5) + 2));
  final DateFormat _dateFormatter = DateFormat.yMd();

  late TimeOfDay initialTime = TimeOfDay(hour: 0, minute: 0);
  late TimeOfDay endTime = TimeOfDay(hour: 23, minute: 59);

  _MyCreateScheduleState(userGroup) {
    this.userGroup = userGroup;
    for (int i in userGroup.schedule.weekdays) {
      values[i - 1] = true;
    }
  }

  _pickStartDate() async {
    DateTime? newStartDate = await showDatePicker(
      context: context,
      firstDate: DateTime(firstDate.year),
      lastDate: DateTime(firstDate.year + 5),
      initialDate: firstDate,
    );
    firstDate = newStartDate!;
    setState(() {});
  }

  _pickLastDate() async {
    DateTime? newLastDate = await showDatePicker(
      context: context,
      firstDate: DateTime(firstDate.year),
      lastDate: DateTime(lastDate.year + 5),
      initialDate: lastDate,
    );
    lastDate = newLastDate!;
    setState(() {});
  }

  _pickStartTime() async {
    TimeOfDay? newStartTime =
        await showTimePicker(context: context, initialTime: this.initialTime);
    initialTime = newStartTime!;
    setState(() {});
  }

  _pickLastTime() async {
    TimeOfDay? newEndTime =
        await showTimePicker(context: context, initialTime: this.initialTime);
    endTime = newEndTime!;
    setState(() {});
  }

  _showAlert(String title, String message) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Accept'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Schedule ${userGroup.name}"),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        body: Container(
            margin: const EdgeInsets.only(top: 50, left: 30.0, right: 30.0),
            child: Column(
              children: [
                Row(children: [
                  Container(child: Text("From")),
                  Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: Row(children: [
                        Text(_dateFormatter.format(firstDate)),
                        IconButton(
                            onPressed: _pickStartDate,
                            icon: Icon(
                              Icons.date_range,
                              color: Colors.blue,
                            ))
                      ])),
                ]),
                Padding(padding: EdgeInsets.all(10)),
                Row(
                  children: [
                    Container(child: Text("To")),
                    Padding(
                      padding: EdgeInsets.only(left: 76),
                      child: Row(
                        children: [
                          Text(_dateFormatter.format(lastDate)),
                          IconButton(
                              onPressed: _pickLastDate,
                              icon: Icon(
                                Icons.date_range,
                                color: Colors.blue,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.all(10)),
                Row(
                  children: [Text("Weekdays")],
                ),
                WeekdaySelector(
                  onChanged: (v) {
                    setState(() {
                      values[(v - 1) % 7] = !values[(v - 1) % 7];
                    });
                  },
                  values: [
                    values[values.length - 1],
                    ...values.sublist(0, values.length - 1)
                  ],
                ),
                Padding(padding: EdgeInsets.all(10)),
                Row(children: [
                  Container(child: Text("From")),
                  Padding(
                    padding: EdgeInsets.only(left: 50),
                    child: Row(
                      children: [
                        Text(initialTime.format(context)),
                        IconButton(
                            onPressed: _pickStartTime,
                            icon: Icon(
                              Icons.schedule,
                              color: Colors.blue,
                            ))
                      ],
                    ),
                  ),
                ]),
                Padding(padding: EdgeInsets.all(10)),
                Row(
                  children: [
                    Container(child: Text("To")),
                    Padding(
                        padding: EdgeInsets.only(left: 77),
                        child: Row(children: [
                          Text(endTime.format(context)),
                          IconButton(
                              onPressed: _pickLastTime,
                              icon: Icon(
                                Icons.schedule,
                                color: Colors.blue,
                              ))
                        ]))
                  ],
                ),
                Padding(padding: EdgeInsets.all(10)),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (!lastDate.isAfter(firstDate)) {
                        _showAlert("Range dates",
                            "The Form date is after the To date. Please select a new date range.");
                      }
                      // Validate returns true if the form is valid, or false otherwise.
                      if (lastDate.isAfter(firstDate) &&
                          endTime.hour > initialTime.hour &&
                          endTime.minute > initialTime.minute) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Saved')));
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            )));
  }
}

class MyCreateActions extends StatefulWidget {
  final UserGroup userGroup;

  const MyCreateActions({super.key, required this.userGroup});

  @override
  State<MyCreateActions> createState() => _MyCreateActionsState(userGroup);
}

class _MyCreateActionsState extends State<MyCreateActions> {
  late UserGroup userGroup;
  final _formKey = GlobalKey<FormState>();
  late List<bool> checkboxValues = List.filled(5, false);

  actionToCheck(UserGroup userGroup) {
    List<String> actions = userGroup.actions;
    for (String action in actions) {
      if (action == "open") checkboxValues[0] = true;
      if (action == "close") checkboxValues[1] = true;
      if (action == "lock") checkboxValues[2] = true;
      if (action == "unlock") checkboxValues[3] = true;
      if (action == "unlock_shortly") checkboxValues[4] = true;
    }
  }

  CheckToAction(UserGroup userGroup) {
    List<String> tmpActions = List.filled(checkboxValues.length, "");
    for (int i = 0; i < checkboxValues.length; i++) {
      if (checkboxValues[i] == true) {
        if (i == 0) tmpActions[0] = "open";
        if (i == 1) tmpActions[1] = "close";
        if (i == 2) tmpActions[2] = "lock";
        if (i == 3) tmpActions[3] = "unlock";
        if (i == 4) tmpActions[4] = "unlock_shortly";
      }
    }
    userGroup.actions = tmpActions;
    print(userGroup.actions);
  }

  _MyCreateActionsState(UserGroup userGroup) {
    this.userGroup = userGroup;
    actionToCheck(userGroup);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Schedule ${userGroup.name}"),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        body: Column(
          children: <Widget>[
            CheckboxListTile(
              title: Text(
                "Open",
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                "opens an unlocked door",
                style: TextStyle(fontSize: 15),
              ),
              value: checkboxValues[0],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues[0] = value!;
                });
              },
            ),
            Divider(
              color: Colors.grey,
            ),
            CheckboxListTile(
              title: Text(
                "Close",
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                "closes an open door",
                style: TextStyle(fontSize: 15),
              ),
              value: checkboxValues[1],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues[1] = value!;
                });
              },
            ),
            Divider(
              color: Colors.grey,
            ),
            CheckboxListTile(
              title: Text(
                "Lock",
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                "Locks a door all the doors in a room or group of rooms, if closed",
                style: TextStyle(fontSize: 15),
              ),
              value: checkboxValues[2],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues[2] = value!;
                });
              },
            ),
            Divider(
              color: Colors.grey,
            ),
            CheckboxListTile(
              title: Text(
                "Unlock",
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                "Unlocks a locked door all the locked doors in an room",
                style: TextStyle(fontSize: 15),
              ),
              value: checkboxValues[3],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues[3] = value!;
                });
              },
            ),
            Divider(
              color: Colors.grey,
            ),
            CheckboxListTile(
              title: Text(
                "Unlock shortly",
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                "Unlocks a door during 10 seconds and the locks it if it is closed",
                style: TextStyle(fontSize: 15),
              ),
              value: checkboxValues[4],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues[4] = value!;
                });
              },
            ),
            Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  CheckToAction(userGroup);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Saved')));
                },
                child: Text("submit"),
              ),
            )
          ],
        ));
  }
}

class MyCreateUsers extends StatefulWidget {
  final UserGroup userGroup;

  const MyCreateUsers({super.key, required this.userGroup});

  @override
  State<MyCreateUsers> createState() => _MyCreateUsersState(userGroup);
}

class _MyCreateUsersState extends State<MyCreateUsers> {
  late UserGroup userGroup;
  final _formKey = GlobalKey<FormState>();

  _MyCreateUsersState(UserGroup userGroup) {
    this.userGroup = userGroup;
  }

  Widget _buildRow(User user, int index) {
    return ListTile(
        leading: CircleAvatar(
            backgroundImage:
                NetworkImage(Data.images[user.name.toLowerCase()]!)),
        title: Row(
          children: <Widget>[
            Text(user.name),
            Spacer(),
            Text(
                style: TextStyle(
                  fontSize: 10,
                ),
                user.credential),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (context) => MyCreateSingleUser(user: user)));
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Users ${userGroup.name}"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: ListView.separated(
        // it's like ListView.builder() but better
        // because it includes a separator between items
        padding: const EdgeInsets.all(16.0),
        itemCount: userGroup.users.length,
        itemBuilder: (BuildContext context, int index) =>
            _buildRow(userGroup.users[index], index),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}

class MyCreateSingleUser extends StatefulWidget {
  final user;

  const MyCreateSingleUser({super.key, required this.user});

  @override
  _MyCreateSingleUserState createState() {
    return _MyCreateSingleUserState(user);
  }
}

class _MyCreateSingleUserState extends State<MyCreateSingleUser> {
  late User user;
  final _formKey = GlobalKey<FormState>();

  _MyCreateSingleUserState(user) {
    this.user = user;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("User"),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        body: Form(
            key: _formKey,
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 70, bottom: 40),
                        child: CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(
                                Data.images[user.name.toLowerCase()]!))),
                    Padding(
                        padding: EdgeInsets.only(bottom: 40),
                        child: TextFormField(
                            initialValue: "${user.name}",
                            decoration: InputDecoration(
                                labelText: "name",
                                fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: BorderSide())))),
                    Padding(
                      padding: EdgeInsets.only(bottom: 40),
                      child: TextFormField(
                          initialValue: "${user.credential}",
                          decoration: InputDecoration(
                              labelText: "credential",
                              fillColor: Colors.transparent,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide()))),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Saved')));
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ))));
  }
}
