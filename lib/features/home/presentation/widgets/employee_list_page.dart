import 'package:employee_management/core/data/entities/employee_data.dart';
import 'package:employee_management/core/theme/app_style.dart';
import 'package:employee_management/features/add_edit_employee/presentation/add_edit_employee.dart';
import 'package:employee_management/features/home/presentation/bloc/home_bloc.dart';
import 'package:employee_management/features/home/presentation/bloc/home_event.dart';
import 'package:employee_management/features/home/presentation/bloc/home_state.dart';
import 'package:employee_management/features/home/presentation/widgets/no_employee_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:flutter_swipe_action_cell/core/controller.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EmployeeListPageState createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  late SwipeActionController controller;

  @override
  void initState() {
    super.initState();
    controller = SwipeActionController(selectedIndexPathsChangeCallback:
        (changedIndexPaths, selected, currentCount) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      final provider = BlocProvider.of<HomeBloc>(context);
      List<EmployeeData> currentEmployees = provider.currentEmployees;
      List<EmployeeData> previousEmployees = provider.previousEmployees;
      return Column(
        children: [
          SizedBox(
            height: 40,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Current employees", style: AppTextStyles().header),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1)),
              child: currentEmployees.isNotEmpty
                  ? ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: currentEmployees.length,
                      itemBuilder: (context, index) {
                        return _item(
                            context, index, currentEmployees, provider, true);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 0.5,
                        );
                      },
                    )
                  : const NoEmployeePage(),
            ),
          ),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child:
                    Text("Previous employees", style: AppTextStyles().header),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1)),
              child: previousEmployees.isNotEmpty
                  ? ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: previousEmployees.length,
                      itemBuilder: (context, index) {
                        return _item(
                            context, index, previousEmployees, provider, false);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 0.5,
                        );
                      },
                    )
                  : const NoEmployeePage(),
            ),
          ),
          SizedBox(
            height: 96,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 16),
                  child: Text(
                    "Swipe left to delete",
                    textAlign: TextAlign.start,
                    style: AppTextStyles().mediumGrey,
                  ),
                ),
              ],
            ),
          )
        ],
      );
    });
  }

  Widget _item(BuildContext ctx, int index, List<EmployeeData> employeeList,
      HomeBloc provider, bool currentEmployee) {
    return SwipeActionCell(
      controller: controller,
      index: index,

      // Required!
      key: ValueKey(employeeList[index].uuid),
      trailingActions: [
        SwipeAction(
          icon: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 25,
          ),
          performsFirstActionWithFullSwipe: false,
          onTap: (handler) {
            provider.add(DelEmployeeTapped(employeeList[index]));
          },
        ),
      ],
      child: Container(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddEditEmployeeRecord(employeeList[index])),
            ).then((_) => provider.add(HomePageOpened()));
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employeeList[index].name,
                  textAlign: TextAlign.start,
                  style: AppTextStyles()
                      .header
                      .copyWith(color: AppColors().appBlackColor),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  employeeList[index].role,
                  textAlign: TextAlign.start,
                  style: AppTextStyles().smallGrey,
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  currentEmployee
                      ? "From ${employeeList[index].formattedTime}"
                      : employeeList[index].formattedTime,
                  textAlign: TextAlign.start,
                  style: AppTextStyles().smallGrey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
