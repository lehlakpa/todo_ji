import 'package:flutter/material.dart';
import 'package:todo_ji/screens/search_screen.dart';
import 'package:todo_ji/widgets/add_task_sheet.dart';
import 'package:todo_ji/widgets/custom_appbar.dart';

import 'done_screen.dart';
import 'home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const HomeScreen(),
    const SearchScreen(),
    const DoneScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),

      body: SafeArea(child: screens[currentIndex]),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: currentIndex,

        onTap: (index) {
          if (index == 1) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => const AddTaskSheet(),
            );
            return;
          }

          setState(() {
            currentIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 0 ? Icons.checklist : Icons.checklist_outlined,
            ),
            label: 'Todo',
          ),

          const BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'Create',
          ),

          const BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Search',
          ),

          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 3
                  ? Icons.check_circle
                  : Icons.check_circle_outline,
            ),
            label: 'Done',
          ),
        ],
      ),
    );
  }
}

// // import 'package:flutter/material.dart';
// // import 'package:todo_ji/screens/create_screen.dart';
// // import 'package:google_fonts/google_fonts.dart';
// import 'package:todo_ji/screens/search_screen.dart';
// import 'package:todo_ji/widgets/add_task_sheet.dart';
// // import 'package:planner/screens/search_screen.dart';
// import 'package:todo_ji/widgets/custom_appbar.dart';
// import 'done_screen.dart';
// import 'home_screen.dart';
// // import 'login_screen.dart';

// // class DashboardScreen extends StatefulWidget {
// //   const DashboardScreen({super.key});

// //   @override
// //   State<DashboardScreen> createState() => _DashboardScreenState();
// // }

// // class _DashboardScreenState extends State<DashboardScreen> {
// //   int currentIndex = 0;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: CustomAppbar(),
// //       bottomNavigationBar: BottomNavigationBar(
// //         onTap: (index) {
// //           currentIndex = index;
// //           setState(() {});
// //         },
// //         currentIndex: currentIndex,
// //         selectedItemColor: Colors.blue,
// //         unselectedItemColor: Colors.grey,
// //         items: [
// //           BottomNavigationBarItem(
// //             icon: Icon(
// //               Icons.list,
// //               color: currentIndex == 0 ? Colors.blue : Colors.grey,
// //             ),
// //             // icon: Image.asset(
// //             //   'assets/icons/todo_list.png',
// //             //   scale: 2,
// //             //   color: currentIndex == 0 ? Colors.blue : Colors.grey,
// //             // ),
// //             label: 'Todo',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(
// //               Icons.plus_one_outlined,
// //               color: currentIndex == 1 ? Colors.blue : Colors.grey,
// //             ),
// //             // icon: Image.asset(
// //             //   'assets/icons/plus_outlined.png',
// //             //   scale: 2,
// //             //   color: currentIndex == 1 ? Colors.blue : Colors.grey,
// //             // ),
// //             label: 'Create',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(
// //               Icons.search,
// //               color: currentIndex == 2 ? Colors.blue : Colors.grey,
// //             ),
// //             label: 'Search',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(
// //               Icons.done,
// //               color: currentIndex == 3 ? Colors.blue : Colors.grey,
// //             ),

// //             // icon: Image.asset(
// //             //   'assets/icons/checked_outlined.png',
// //             //   color: currentIndex == 3 ? Colors.blue : Colors.grey,
// //             // ),
// //             label: 'Done',
// //           ),
// //         ],
// //       ),
// //       body: IndexedStack(
// //         index: currentIndex,
// //         children: [HomeScreen(), CreateScreen(), SearchScreen(), DoneScreen()],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   int currentIndex = 0;

//   List screens = [HomeScreen(), HomeScreen(), SearchScreen(), DoneScreen()];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppbar(),
//       body: SafeArea(child: screens[currentIndex]),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.shifting,
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         showUnselectedLabels: true,
//         currentIndex: currentIndex,
//         onTap: (val) {
//           setState(() => currentIndex = val);
//           if (currentIndex == 1) {
//             showModalBottomSheet(
//               context: context,
//               builder: (context) => AddTaskSheet(),
//             );
//           }
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               'assets/icons/todo_list.png',
//               scale: 2,
//               color: currentIndex == 0 ? Colors.blue : Colors.grey,
//             ),
//             label: 'Todo',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               'assets/icons/plus_outlined.png',
//               scale: 2,
//               color: currentIndex == 1 ? Colors.blue : Colors.grey,
//             ),

//             label: 'Create',
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               'assets/icons/checked_outlined.png',

//               color: currentIndex == 3 ? Colors.blue : Colors.grey,
//             ),

//             label: 'Done',
//           ),
//         ],
//       ),
//     );
//   }
// }
