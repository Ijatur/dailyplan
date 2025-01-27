import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

class Agenda {
  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  Agenda({
    required this.title,
    required this.description,
    required this.dateTime,
    this.isDone = false,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Agenda',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Daily Agenda'),
      home: LoginScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<Agenda> agendas = [];
//   List<Agenda> _filteredAgendas = [];
//   String _searchQuery = "";
//   final TextEditingController _searchController = TextEditingController();
//   Timer? _reminderTimer;

//   @override
//   void initState() {
//     super.initState();
//     _filteredAgendas = agendas;
//     _searchController.addListener(_onSearchChanged);
//     _startReminderTimer();
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     _reminderTimer?.cancel();
//     super.dispose();
//   }

//   void _startReminderTimer() {
//     // Ganti waktu timer pengingat disini, misalnya setiap 1 menit
//     _reminderTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
//       _checkAgendasForReminders();
//     });
//   }

//   void _checkAgendasForReminders() {
//     final now = DateTime.now();
//     for (final agenda in agendas) {
//       final reminderTime = agenda.dateTime.subtract(const Duration(minutes: 1));
//       if (now.isAfter(reminderTime) && now.isBefore(agenda.dateTime)) {
//         _showReminderDialog(agenda);
//       }
//     }
//   }

//   void _showReminderDialog(Agenda agenda) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Reminder'),
//           content: Text('Your agenda "${agenda.title}" will start soon!'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _onSearchChanged() {
//     _updateSearchQuery(_searchController.text);
//   }

//   void _navigateToAddAgenda() async {
//     final newAgenda = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const AddAgendaScreen()),
//     );
//     if (newAgenda != null) {
//       setState(() {
//         agendas.add(newAgenda);
//         _filteredAgendas =
//             agendas
//                 .where(
//                   (agenda) => agenda.title.toLowerCase().contains(
//                     _searchQuery.toLowerCase(),
//                   ),
//                 )
//                 .toList();
//       });
//     }
//   }

//   void _showAgendaOptions(Agenda agenda) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Agenda Options'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.edit),
//                 title: const Text('Edit'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _navigateToEditAgenda(agenda);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.delete),
//                 title: const Text('Delete'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _deleteAgenda(agenda);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _navigateToEditAgenda(Agenda agenda) async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => EditAgendaScreen(agenda: agenda)),
//     );
//     if (result != null) {
//       if (result is String && result == 'delete') {
//         _deleteAgenda(agenda);
//       } else if (result is Agenda) {
//         setState(() {
//           final index = agendas.indexOf(agenda);
//           agendas[index] = result;
//           _filteredAgendas =
//               agendas
//                   .where(
//                     (agenda) => agenda.title.toLowerCase().contains(
//                       _searchQuery.toLowerCase(),
//                     ),
//                   )
//                   .toList();
//         });
//       }
//     }
//   }

//   void _deleteAgenda(Agenda agenda) {
//     setState(() {
//       agendas.remove(agenda);
//       _filteredAgendas =
//           agendas
//               .where(
//                 (agenda) => agenda.title.toLowerCase().contains(
//                   _searchQuery.toLowerCase(),
//                 ),
//               )
//               .toList();
//     });
//   }

//   void _updateSearchQuery(String query) {
//     setState(() {
//       _searchQuery = query;
//       _filteredAgendas =
//           agendas
//               .where(
//                 (agenda) =>
//                     agenda.title.toLowerCase().contains(query.toLowerCase()),
//               )
//               .toList();
//     });
//   }

//   void _toggleAgendaDone(Agenda agenda) {
//     setState(() {
//       agenda.isDone = !agenda.isDone;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: SizedBox(
//           height: 40,
//           child: TextField(
//             controller: _searchController,
//             decoration: InputDecoration(
//               hintText: 'Search by title',
//               prefixIcon: Icon(Icons.search),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: _filteredAgendas.length,
//         itemBuilder: (context, index) {
//           final agenda = _filteredAgendas[index];
//           return ListTile(
//             leading: Checkbox(
//               value: agenda.isDone,
//               onChanged: (value) {
//                 _toggleAgendaDone(agenda);
//               },
//             ),
//             title: Text(agenda.title),
//             subtitle: Text(agenda.description),
//             trailing: Text(agenda.dateTime.toString()),
//             onTap: () {
//               _showAgendaOptions(agenda);
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _navigateToAddAgenda,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class AddAgendaScreen extends StatefulWidget {
//   const AddAgendaScreen({super.key});

//   @override
//   _AddAgendaScreenState createState() => _AddAgendaScreenState();
// }

// class _AddAgendaScreenState extends State<AddAgendaScreen> {
//   final _titleController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   DateTime _selectedDateTime = DateTime.now();
//   bool _isDone = false;

//   Future<void> _selectDateTime(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _selectedDateTime,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//     if (pickedDate != null) {
//       final TimeOfDay? pickedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
//       );
//       if (pickedTime != null) {
//         setState(() {
//           _selectedDateTime = DateTime(
//             pickedDate.year,
//             pickedDate.month,
//             pickedDate.day,
//             pickedTime.hour,
//             pickedTime.minute,
//           );
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Add New Agenda')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _titleController,
//               decoration: const InputDecoration(labelText: 'Title'),
//             ),
//             TextField(
//               controller: _descriptionController,
//               decoration: const InputDecoration(labelText: 'Description'),
//             ),
//             Row(
//               children: [
//                 Text(
//                   'Date and Time: ${DateFormat('yyyy-MM-dd HH:mm').format(_selectedDateTime)}',
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.calendar_today),
//                   onPressed: () => _selectDateTime(context),
//                 ),
//               ],
//             ),
//             CheckboxListTile(
//               title: const Text('Done'),
//               value: _isDone,
//               onChanged: (newValue) {
//                 setState(() {
//                   _isDone = newValue!;
//                 });
//               },
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 final newAgenda = Agenda(
//                   title: _titleController.text,
//                   description: _descriptionController.text,
//                   dateTime: _selectedDateTime,
//                   isDone: _isDone,
//                 );
//                 Navigator.pop(context, newAgenda);
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class EditAgendaScreen extends StatefulWidget {
//   final Agenda agenda;

//   const EditAgendaScreen({super.key, required this.agenda});

//   @override
//   _EditAgendaScreenState createState() => _EditAgendaScreenState();
// }

// class _EditAgendaScreenState extends State<EditAgendaScreen> {
//   final _titleController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   DateTime _selectedDateTime = DateTime.now();
//   bool _isDone = false;

//   @override
//   void initState() {
//     super.initState();
//     _titleController.text = widget.agenda.title;
//     _descriptionController.text = widget.agenda.description;
//     _selectedDateTime = widget.agenda.dateTime;
//     _isDone = widget.agenda.isDone;
//   }

//   Future<void> _selectDateTime(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _selectedDateTime,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//     if (pickedDate != null) {
//       final TimeOfDay? pickedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
//       );
//       if (pickedTime != null) {
//         setState(() {
//           _selectedDateTime = DateTime(
//             pickedDate.year,
//             pickedDate.month,
//             pickedDate.day,
//             pickedTime.hour,
//             pickedTime.minute,
//           );
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Edit Agenda')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _titleController,
//               decoration: const InputDecoration(labelText: 'Title'),
//             ),
//             TextField(
//               controller: _descriptionController,
//               decoration: const InputDecoration(labelText: 'Description'),
//             ),
//             Row(
//               children: [
//                 Text(
//                   'Date and Time: ${DateFormat('yyyy-MM-dd HH:mm').format(_selectedDateTime)}',
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.calendar_today),
//                   onPressed: () => _selectDateTime(context),
//                 ),
//               ],
//             ),
//             CheckboxListTile(
//               title: const Text('Done'),
//               value: _isDone,
//               onChanged: (newValue) {
//                 setState(() {
//                   _isDone = newValue!;
//                 });
//               },
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 final updatedAgenda = Agenda(
//                   title: _titleController.text,
//                   description: _descriptionController.text,
//                   dateTime: _selectedDateTime,
//                   isDone: _isDone,
//                 );
//                 Navigator.pop(context, updatedAgenda);
//               },
//               child: const Text('Save'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context, 'delete'); // Send a 'delete' signal back
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red, // Make the delete button red
//               ),
//               child: const Text(
//                 'Delete',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
