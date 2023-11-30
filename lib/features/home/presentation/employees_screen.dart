import 'package:employee_management/core/constants/constants.dart';
import 'package:employee_management/core/theme/app_style.dart';
import 'package:employee_management/features/add_edit_employee/presentation/add_edit_employee.dart';
import 'package:employee_management/core/widgets/undo_delete_widget.dart';
import 'package:employee_management/features/home/presentation/bloc/home_bloc.dart';
import 'package:employee_management/features/home/presentation/bloc/home_event.dart';
import 'package:employee_management/features/home/presentation/bloc/home_state.dart';
import 'package:employee_management/features/home/presentation/widgets/employee_list_page.dart';
import 'package:employee_management/features/home/presentation/widgets/no_employee_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kiwi/kiwi.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Text(
          "Employee List",
          style: AppTextStyles().title,
        ),
        backgroundColor: AppColors().primaryColor,
      ),
      body: BlocProvider(
        create: (context) => KiwiContainer().resolve<HomeBloc>(),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            final provider = BlocProvider.of<HomeBloc>(context);
            if (state is HomePageInitial || state is HomePageLoadInProgress) {
              provider.add(HomePageOpened());
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(242, 242, 242, 1)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  (provider.currentEmployees.isNotEmpty ||
                          provider.previousEmployees.isNotEmpty)
                      ? const EmployeeListPage()
                      : const NoEmployeePage(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Wrap(
                      alignment: WrapAlignment.end,
                      verticalDirection: VerticalDirection.down,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: GestureDetector(
                            child: SvgPicture.asset(AssetPaths.addEmployee,
                                semanticsLabel: ''),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AddEditEmployeeRecord(null)),
                              ).then((value) => provider.add(HomePageOpened()));
                            },
                          ),
                        ),
                        provider.canUndo
                            ? UndoDeletedRecordWidget(
                                () {
                                  provider.add(UndoDelEmployeeTapped());
                                },
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
