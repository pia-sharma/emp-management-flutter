import 'package:employee_management/core/constants/constants.dart';
import 'package:employee_management/core/data/entities/employee_data.dart';
import 'package:employee_management/core/theme/app_style.dart';
import 'package:employee_management/core/utils/date_time_ext.dart';
import 'package:employee_management/core/widgets/success_widget.dart';
import 'package:employee_management/core/widgets/toast_widget.dart';
import 'package:employee_management/features/add_edit_employee/presentation/bloc/add_edit_bloc.dart';
import 'package:employee_management/features/add_edit_employee/presentation/bloc/add_edit_event.dart';
import 'package:employee_management/features/add_edit_employee/presentation/bloc/add_edit_state.dart';
import 'package:employee_management/core/widgets/custom_button.dart';
import 'package:employee_management/core/widgets/text_field.dart';
import 'package:employee_management/core/widgets/undo_delete_widget.dart';
import 'package:employee_management/features/add_edit_employee/presentation/widgets/custom_date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kiwi/kiwi.dart';

class AddEditEmployeeRecord extends StatelessWidget {
  final EmployeeData? _employeeData;
  const AddEditEmployeeRecord(this._employeeData, {super.key});

  @override
  Widget build(BuildContext context) {
    FToast fToast = FToast().init(context);
    return BlocProvider(
      create: (context) => KiwiContainer().resolve<AddEditBloc>(),
      child: BlocBuilder<AddEditBloc, AddEditState>(
        builder: (context, state) {
          final provider = BlocProvider.of<AddEditBloc>(context);
          if (state is AddEditPageInitial) {
            provider.add(AddEditPageOpened(_employeeData));
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AddEditPageLoadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 60,
              automaticallyImplyLeading: false,
              actions: [
                provider.isInEditMode
                    ? IconButton(
                        icon: const Icon(
                          Icons.delete,
                          size: 24,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          provider.add(DelEmployeeButtonTapped());
                        },
                      )
                    : const SizedBox(
                        width: 1,
                      ),
              ],
              title: Text(
                "Add Employee Details",
                style: AppTextStyles().title,
              ),
              backgroundColor: const Color.fromRGBO(29, 161, 242, 1),
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFieldWidget(
                        provider.nameController,
                        AssetPaths.personIcon,
                        hintText: "Employee name",
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      GestureDetector(
                        child: CustomTextFieldWidget(
                          provider.roleController,
                          AssetPaths.roleIcon,
                          enable: false,
                          readOnly: true,
                          hintText: "Select role",
                          suffixPath: AssetPaths.downArrow,
                        ),
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 211,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: provider.roles.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      child: SizedBox(
                                        height: 52,
                                        child: Center(
                                          child: Text(
                                            provider.roles[index],
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        provider.roleController.text =
                                            provider.roles[index];
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      height: 0.5,
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: GestureDetector(
                              child: CustomTextFieldWidget(
                                provider.fromDateController,
                                AssetPaths.dateIcon,
                                readOnly: true,
                                enable: false,
                                hintText: "Today",
                                large: false,
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDatePickerDialog(
                                        provider.fromDateTime,
                                        provider.toDateTime,
                                        true);
                                  },
                                ).then((value) {
                                  if (value != null) {
                                    DateTime dateFound = value as DateTime;
                                    if (provider.toDateTime != null &&
                                        provider.toDateTime!
                                            .isBefore(dateFound)) {
                                      fToast.showToast(
                                        child: const ToastMessageWidget(
                                            "From date can't be greater than to date"),
                                      );
                                    } else {
                                      provider.fromDateTime = dateFound;
                                      provider.fromDateController.text =
                                          dateFound.formatDate();
                                    }
                                  }
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SvgPicture.asset(AssetPaths.forwardArrow,
                              semanticsLabel: ''),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                              flex: 1,
                              child: GestureDetector(
                                child: CustomTextFieldWidget(
                                  provider.toDateController,
                                  AssetPaths.dateIcon,
                                  readOnly: true,
                                  enable: false,
                                  hintText: "No date",
                                  large: false,
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomDatePickerDialog(
                                          provider.fromDateTime,
                                          provider.toDateTime,
                                          false);
                                    },
                                  ).then((value) {
                                    if (value != null) {
                                      value as DateTime;
                                      if (provider.fromDateTime != null &&
                                          value.isBefore(
                                              provider.fromDateTime!)) {
                                        fToast.showToast(
                                          child: const ToastMessageWidget(
                                              "To date can't be less than from date"),
                                        );
                                      } else {
                                        provider.toDateTime = value;
                                        provider.toDateController.text =
                                            value.formatDate();
                                      }
                                    } else {
                                      provider.toDateTime = null;
                                      provider.toDateController.text =
                                          "No date";
                                    }
                                  });
                                },
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: provider.canUndo || state is AddEmployeeSuccess
                        ? 104
                        : 64,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Divider(
                          height: 0.5,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 12, right: 24),
                                child: CustomButton(() {
                                  Navigator.pop(context);
                                }, "Cancel"),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 12, right: 24),
                                child: CustomButton(
                                  () {
                                    if (provider.isValidationSuccess) {
                                      provider.add(AddEmployeeButtonTapped());
                                    }
                                  },
                                  "Save",
                                  backgroundColor:
                                      const Color.fromRGBO(29, 161, 242, 1),
                                  textColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        provider.canUndo
                            ? Padding(
                                padding: const EdgeInsets.only(top: 11.5),
                                child: UndoDeletedRecordWidget(
                                  () {
                                    provider.add(UndoDelButtonTapped());
                                  },
                                ),
                              )
                            : Container(),
                        state is AddEmployeeSuccess
                            ? Padding(
                                padding: const EdgeInsets.only(top: 11.5),
                                child: MessageWidget(
                                    provider.isInEditMode
                                        ? "Employee updated successfully"
                                        : "Employee added successfully", () {
                                  Navigator.pop(context);
                                }),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
