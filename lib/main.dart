import 'package:crud_sqlite/sqlhelper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'CRUD',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // All journals
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    sqfliteFfiInit();
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  final GlobalKey _globalKey = GlobalKey();

  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateofbirthController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _nrcController = TextEditingController();
  final TextEditingController _marriedController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
      _journals.firstWhere((element) => element['id'] == id);
      _jobController.text = existingJournal['job'];
      _salaryController.text = existingJournal['salary'];
      _nameController.text = existingJournal['name'];
      _dateofbirthController.text = existingJournal['dateofbirth'];
      _religionController.text = existingJournal['religion'];
      _nrcController.text = existingJournal['nrc'];
      _marriedController.text = existingJournal['married'];
      _emailController.text = existingJournal['email'];
      _addressController.text = existingJournal['address'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            // this will prevent the soft keyboard from covering the text fields
            bottom: MediaQuery.of(context).viewInsets.bottom + 120,
          ),
          child: Center(
            child: ListView(
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _jobController,
                  decoration: const InputDecoration(
                      fillColor: Colors.indigo,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(25),
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))
                      ),
                      label: Text('Position'),
                      hintText: 'Designer : Developer',
                      floatingLabelStyle: TextStyle(letterSpacing: 10,fontWeight: FontWeight.bold,fontSize: 17)
                  ),
                ),
                const SizedBox(
                  height: 5 ,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _salaryController,
                  decoration: const InputDecoration(
                      fillColor: Colors.indigo,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(25),
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))
                      ),
                      label: Text('Salary'),
                      hintText: '\$0000 : \$000',
                      floatingLabelStyle: TextStyle(letterSpacing: 10,fontWeight: FontWeight.bold,fontSize: 17)
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                  decoration: const InputDecoration(
                      fillColor: Colors.indigo,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(25),
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))
                      ),
                      hintText: 'Username',
                      floatingLabelStyle: TextStyle(letterSpacing: 10,fontWeight: FontWeight.bold,fontSize: 17)
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  keyboardType: TextInputType.datetime,
                  controller: _dateofbirthController,
                  decoration: const InputDecoration(
                      fillColor: Colors.indigo,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(25),
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))
                      ),
                      labelText: 'Date Of Birth',
                      hintText: '0000.00.00',
                      floatingLabelStyle: TextStyle(letterSpacing: 10,fontWeight: FontWeight.bold,fontSize: 17)
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _religionController,
                  decoration: const InputDecoration(
                      fillColor: Colors.indigo,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(25),
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))
                      ),
                      hintText: 'Religion',
                      floatingLabelStyle: TextStyle(letterSpacing: 10,fontWeight: FontWeight.bold,fontSize: 17)
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _nrcController,
                  decoration: const InputDecoration(
                      fillColor: Colors.indigo,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(25),
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))
                      ),
                      labelText: 'NRC NO.',
                      hintText: '**/AAA(N)******',
                      floatingLabelStyle: TextStyle(letterSpacing: 10,fontWeight: FontWeight.bold,fontSize: 17)
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _marriedController,
                  decoration: const InputDecoration(
                      fillColor: Colors.indigo,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(25),
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))
                      ),
                      label: Text('Marital Status'),
                      hintText: 'Married : Single',
                      floatingLabelStyle: TextStyle(letterSpacing: 10,fontWeight: FontWeight.bold,fontSize: 17)
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      fillColor: Colors.indigo,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(25),
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))
                      ),
                      hintText: 'Email@gmail.com',
                      floatingLabelStyle: TextStyle(letterSpacing: 10,fontWeight: FontWeight.bold,fontSize: 17)
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _addressController,
                  decoration: const InputDecoration(
                      fillColor: Colors.indigo,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(25),
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))
                      ),
                      label: Text('Address'),
                      floatingLabelStyle: TextStyle(letterSpacing: 10,fontWeight: FontWeight.bold,fontSize: 17)
                  ),
                ),
                SizedBox(
                  height: 5 ,
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))
                    )),
                    backgroundColor: MaterialStatePropertyAll(Colors.indigo),
                    overlayColor: MaterialStatePropertyAll(Colors.indigoAccent),
                  ),
                  onPressed: () async {
                    // Save new journal
                    if (id == null) {
                      await _addItem();
                    }

                    if (id != null) {
                      await _updateItem(id);
                    }

                    // Clear the text fields
                    _jobController.text = '';
                    _salaryController.text = '';
                    _nameController.text = '';
                    _dateofbirthController.text = '';
                    _religionController.text = '';
                    _nrcController.text = '';
                    _marriedController.text ='';
                    _emailController.text = '';
                    _addressController.text = '';

                    // Close the bottom sheet
                    Navigator.of(context).pop();
                  },
                  child: Text(id == null ? 'Create' : 'Update'),
                )
              ],
            ),
          ),
        ));
  }


  void _justShowForm(int? id) async {
    if (id != null) {
      final existingJournal =
      _journals.firstWhere((element) => element['id'] == id);
      _jobController.text = existingJournal['job'];
      _salaryController.text = existingJournal['salary'];
      _nameController.text = existingJournal['name'];
      _dateofbirthController.text = existingJournal['dateofbirth'];
      _religionController.text = existingJournal['religion'];
      _nrcController.text = existingJournal['nrc'];
      _marriedController.text = existingJournal['married'];
      _emailController.text = existingJournal['email'];
      _addressController.text = existingJournal['address'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            // this will prevent the soft keyboard from covering the text fields
            bottom: MediaQuery.of(context).viewInsets.bottom + 120,
          ),
          child: Container(
            child: Center(
              child: ListView(
                children: [
                  TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    controller: _jobController,
                    decoration: const InputDecoration(
                        fillColor: Colors.indigo,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(25),
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))
                        ),
                        label: Text('Position'),
                        hintText: 'Designer : Developer',
                        floatingLabelStyle: TextStyle(letterSpacing: 10,fontWeight: FontWeight.bold,fontSize: 17)
                    ),
                  ),
                  const SizedBox(
                    height: 1 ,
                  ),
                  TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    controller: _salaryController,
                    decoration: const InputDecoration(
                        fillColor: Colors.indigo,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(25),
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))
                        ),
                        label: Text('Salary'),
                        hintText: '\$0000 : \$000',
                        floatingLabelStyle: TextStyle(letterSpacing: 10,fontWeight: FontWeight.bold,fontSize: 17)
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.name,
                    controller: _nameController,
                    decoration: const InputDecoration(
                        fillColor: Colors.indigo,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(25),
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))
                        ),
                        hintText: 'Username',
                        floatingLabelStyle: TextStyle(letterSpacing: 10,fontWeight: FontWeight.bold,fontSize: 17)
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.datetime,
                    controller: _dateofbirthController,
                    decoration: const InputDecoration(
                        fillColor: Colors.indigo,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(25),
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))
                        ),
                        label: Text('Date Of Birth'),
                        hintText: '0000.00.00',
                        floatingLabelStyle: TextStyle(letterSpacing: 10,fontWeight: FontWeight.bold,fontSize: 17)
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    controller: _religionController,
                    decoration: const InputDecoration(
                        fillColor: Colors.indigo,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(25),
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))
                        ),
                        hintText: 'Religion',
                        floatingLabelStyle: TextStyle(letterSpacing: 10,fontWeight: FontWeight.bold,fontSize: 17)
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    controller: _nrcController,
                    decoration: const InputDecoration(
                        fillColor: Colors.indigo,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(25),
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))
                        ),
                        label: Text('NRC NO.'),
                        hintText: '**/AAA/(N)******',
                        floatingLabelStyle: TextStyle(letterSpacing: 10,fontWeight: FontWeight.bold,fontSize: 17)
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    controller: _marriedController,
                    decoration: const InputDecoration(
                        fillColor: Colors.indigo,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(25),
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))
                        ),
                        label: Text('Marital Status'),
                        hintText: 'Married : Single',
                        floatingLabelStyle: TextStyle(letterSpacing: 10,fontWeight: FontWeight.bold,fontSize: 17)
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: _emailController,
                    decoration: const InputDecoration(
                        fillColor: Colors.indigo,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(25),
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))
                        ),
                        hintText: 'Email@gmail.com',
                        floatingLabelStyle: TextStyle(letterSpacing: 10,fontWeight: FontWeight.bold,fontSize: 17)
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    controller: _addressController,
                    decoration: const InputDecoration(
                        fillColor: Colors.indigo,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(25),
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))
                        ),
                        label: Text('Address'),
                        floatingLabelStyle: TextStyle(letterSpacing: 10,fontWeight: FontWeight.bold,fontSize: 17)
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }


  Future<void> _errorNull() async{
    _jobController.text = '';
    _salaryController.text = '';
    _nameController.text = '';
    _dateofbirthController.text = '';
    _religionController.text = '';
    _nrcController.text = '';
    _marriedController.text = '';
    _emailController.text = '';
    _addressController.text = '';
    await ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Type In This Field')));
  }
// Insert a new journal to the database
  Future<void> _addItem() async {
    SQLHelper.createItem(
        _jobController.text,
        _salaryController.text,
        _nameController.text,
        _dateofbirthController.text,
        _religionController.text,
        _nrcController.text,
        _marriedController.text,
        _emailController.text,
        _addressController.text
    );
    _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id,
        _jobController.text,
        _salaryController.text,
        _nameController.text,
        _dateofbirthController.text,
        _religionController.text,
        _nrcController.text,
        _marriedController.text,
        _emailController.text,
        _addressController.text
    );
    _refreshJournals();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Deleted an Employee!'),
    ));
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.indigo,
        title: TextLiquidFill(text: 'Employee List',
          waveColor: Colors.white,
          boxBackgroundColor: Colors.indigo,
          textStyle:
          TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,letterSpacing: 10),
          boxHeight: 49.7,
          loadDuration: Duration(minutes: 5),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: Colors.indigo,
        ),
      )
          : Container(
        color:Colors.white,
        child: ListView.builder(
          itemCount: _journals.length,
          itemBuilder: (context, index) => Card(
            color: Colors.indigo,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                )
            ),
            margin: const EdgeInsets.all(15),
            child: ListTile(
                tileColor: Colors.indigo,
                textColor: Colors.white,
                iconColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )
                ),
                onTap: () => _justShowForm(_journals[index]['id']),
                splashColor: Colors.black,
                dense: true,
                leading: Icon(Icons.person,size: 40,color: Colors.white,),
                style: ListTileStyle.drawer,
                title: Text(_journals[index]['name'],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                subtitle: Text(_journals[index]['dateofbirth'],
                  style: TextStyle(
                      color: Colors.white,
                      decorationStyle: TextDecorationStyle.dotted,
                      decoration: TextDecoration.underline
                  ),),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        color: Colors.white,
                        splashColor: Colors.indigoAccent,
                        hoverColor: Colors.indigoAccent,
                        splashRadius: 25,
                        onPressed: () => _showForm(_journals[index]['id']),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.white,
                        splashColor: Colors.indigoAccent,
                        hoverColor: Colors.indigoAccent,
                        splashRadius: 25,
                        onPressed: () =>
                            _deleteItem(_journals[index]['id']),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor:  Colors.indigo,
        hoverColor:Colors.indigoAccent,
        onPressed: () => _showForm(null),
      ),
    );
  }
}




