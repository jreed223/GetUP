import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// This is the filter widget that will be used to filter the goals
class Filter extends StatefulWidget {
  Filter({super.key});

  List<String> filterOptionsList = [
    'All',
    'Short Term',
    'Long Term',
    'Completed',
    'Incomplete',
  ];

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String selectedFilterOption = 'All';
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, provider, child) {
      return DropdownButton<String>(
        // TODO: Change this to the provider method that grabs the filter value
        value: selectedFilterOption,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            // TODO: Change this to the provider method that sets the filter value
            selectedFilterOption = value!;
          });
        },
        items: widget.filterOptionsList
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    });
  }
}

/// This will hold the state of the filter

class FilterState extends ChangeNotifier {
  /// This is the only instance of the GoalDataState class
  static final FilterState mainInstance = FilterState._mainInstanceCreator();

  /// This is the constructor for the GoalDataState class
  /// It is private so that it can only be called by the getInstance method
  /// This ensures that there is only one instance of the GoalDataState class
  FilterState._mainInstanceCreator();

  /// This method returns the only instance of the GoalDataState class
  /// If the instance has not been created yet, it will create the instance
  factory FilterState() {
    return mainInstance;
  }
}
