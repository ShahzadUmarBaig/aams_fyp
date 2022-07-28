import 'package:aams_fyp/constants.dart';
import 'package:aams_fyp/services/firebase_service.dart';
import 'package:aams_fyp/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddClassScreen extends StatefulWidget {
  static const String id = "/add-class-screen";
  AddClassScreen({Key? key}) : super(key: key);

  @override
  State<AddClassScreen> createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {
  final TextEditingController _classNameController = TextEditingController();
  final TextEditingController _classStartDateController =
      TextEditingController();
  final TextEditingController _classStartTimeController =
      TextEditingController();
  final TextEditingController _classEndTimeController = TextEditingController();
  final TextEditingController _classEndDateController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  Duration duration = Duration(minutes: 30);

  bool _isLoading = false;

  bool _isValid() {
    return startDate != null &&
        endDate != null &&
        startTime != null &&
        endTime != null &&
        _classNameController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    print(_isValid());
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              CustomAppBar(name: "Add Class"),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: Constants.textFieldDecoration.copyWith(
                        hintText: "Class Name",
                        prefixIcon: Icon(
                          Icons.text_fields_outlined,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      controller: _classNameController,
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Text("Class Duration"),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]')),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (studentId) {},
                            decoration: Constants.textFieldDecoration.copyWith(
                              hintText: "In Minutes e.g: 90",
                              prefixIcon: Icon(
                                Icons.text_fields_outlined,
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                duration = Duration(minutes: int.parse(value));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      readOnly: true,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2025),
                        ).then((value) {
                          if (value != null) {
                            startDate = value;
                            _classStartDateController.text =
                                DateFormat("dd-MM-yyyy").format(value);
                          }
                        });
                      },
                      decoration: Constants.textFieldDecoration.copyWith(
                        hintText: "Start Date",
                        prefixIcon: Icon(
                          Icons.text_fields_outlined,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      controller: _classStartDateController,
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      readOnly: true,
                      onTap: () {
                        if (startDate != null)
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then(
                            (value) {
                              if (value != null) {
                                startTime = value;
                                _classStartTimeController.text =
                                    value.format(context);
                                DateTime manipulatedDate = DateTime(
                                  startDate!.year,
                                  startDate!.month,
                                  startDate!.day,
                                  value.hour,
                                  value.minute,
                                ).add(duration);

                                endTime =
                                    TimeOfDay.fromDateTime(manipulatedDate);
                                _classEndDateController.text =
                                    DateFormat("dd-MM-yyyy")
                                        .format(manipulatedDate);
                                endDate = manipulatedDate;
                                _classEndTimeController.text =
                                    TimeOfDay.fromDateTime(manipulatedDate)
                                        .format(context);
                              }
                              setState(() {});
                            },
                          );
                      },
                      decoration: Constants.textFieldDecoration.copyWith(
                        hintText: "Start Time",
                        prefixIcon: Icon(
                          Icons.text_fields_outlined,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      controller: _classStartTimeController,
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      readOnly: true,
                      decoration: Constants.textFieldDecoration.copyWith(
                        hintText: "End Date",
                        prefixIcon: Icon(
                          Icons.text_fields_outlined,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      controller: _classEndDateController,
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      readOnly: true,
                      decoration: Constants.textFieldDecoration.copyWith(
                        hintText: "End Time",
                        prefixIcon: Icon(
                          Icons.text_fields_outlined,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      controller: _classEndTimeController,
                    ),
                    SizedBox(height: 24),
                    _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : MaterialButton(
                            onPressed: _isValid()
                                ? () {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    DateTime startDateTime = DateTime(
                                      startDate!.year,
                                      startDate!.month,
                                      startDate!.day,
                                      startTime!.hour,
                                      startTime!.minute,
                                    );
                                    DateTime endDateTime = DateTime(
                                      endDate!.year,
                                      endDate!.month,
                                      endDate!.day,
                                      endTime!.hour,
                                      endTime!.minute,
                                    );

                                    FirebaseService()
                                        .addClass(
                                      duration: duration,
                                      className: _classNameController.text,
                                      endTime: endDateTime,
                                      startTime: startDateTime,
                                    )
                                        .then((value) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      Navigator.pop(context);
                                    });
                                  }
                                : null,
                            color: Constants.buttonColor,
                            minWidth: double.infinity,
                            height: 45,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              'Add',
                              style: Constants.buttonTextStyle,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
