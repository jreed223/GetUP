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

  static String filterSelection = 'All';

  String getFilterSelection() {
    return filterSelection;
  }

  void setFilterSelection(String value) {
    filterSelection = value;
  }

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, provider, child) {
      return Container(
        child: Row(
          children: [
            const Text(
              'Filter by: ',
              style: TextStyle(
                color: Color.fromARGB(129, 0, 0, 0),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 10,
              child: DropdownButton<String>(
                isDense: true,
                // TODO: Change this to the provider method that grabs the filter value
                value: widget.getFilterSelection(),
                icon: const Icon(Icons.arrow_downward, size: 15),
                elevation: 16,
                style: const TextStyle(color: Colors.orange),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    // TODO: Change this to the provider method that sets the filter value
                    widget.setFilterSelection(value!);
                    FilterState.mainInstance
                        .setFilterSelection(widget.getFilterSelection());
                    print(widget.getFilterSelection());
                  });
                },
                items: widget.filterOptionsList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
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

  String filterSelection = 'All';

  String getFilterSelection() {
    return filterSelection;
  }

  void setFilterSelection(String value) {
    filterSelection = value;
    notifyListeners();
  }
}
