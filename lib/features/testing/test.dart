import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard App',
      themeMode: ThemeMode.system,
      home: Scaffold(body: Center(child: SizedBox(child: Example2()))),
    );
  }
}

class TestingScreen extends StatelessWidget {
  const TestingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Example2());
          },
        );
      },
      icon: Icon(Icons.edit),
    );
  }
}

class Example1 extends StatelessWidget {
  const Example1({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      items: (f, cs) => ["Item 1", 'Item 2', 'Item 3', 'Item 4'],
      popupProps: PopupProps.menu(
        disabledItemFn: (item) => item == 'Item 3',
        fit: FlexFit.loose,
        showSearchBox: true,
      ),
    );
  }
}

class Example2 extends StatelessWidget {
  Example2({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    log("test");
    return Form(
      key: formKey,
      child: Column(
        children: [
          // DropdownSearch<String>.multiSelection(
          //   // mode: Mode.custom,
          //   items:
          //       (f, cs) => [
          //         "Monday",
          //         'Tuesday',
          //         'Wednesday',
          //         'Thursday',
          //         'Friday',
          //         'Saturday',
          //         'Sunday',
          //       ],
          //   dropdownBuilder:
          //       (ctx, selectedItem) =>
          //           Icon(Icons.calendar_month_outlined, size: 54),
          //   onSaved: (list) {
          //     log("0000000000");
          //     log(list.toString());
          //   },
          // ),
          Example4(),
        ],
      ),
    );
  }
}

class Example3 extends StatelessWidget {
  const Example3({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<(String, Color)>(
      clickProps: ClickProps(borderRadius: BorderRadius.circular(20)),
      mode: Mode.custom,
      items:
          (f, cs) => [
            ("Red", Colors.red),
            ("Black", Colors.black),
            ("Yellow", Colors.yellow),
            ('Blue', Colors.blue),
          ],
      compareFn: (item1, item2) => item1.$1 == item2.$1,
      popupProps: PopupProps.menu(
        // for dropped menu and items
        menuProps: MenuProps(
          // for the dropped menu as one object
          align: MenuAlign.bottomCenter,
          margin: EdgeInsets.only(top: 12),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        fit: FlexFit.loose,
        itemBuilder: // for each item
            (context, item, isDisabled, isSelected) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                item.$1,
                style: TextStyle(color: item.$2, fontSize: 16),
              ),
            ),
      ),
      dropdownBuilder: // for the button that you click to show the items menu
          (ctx, selectedItem) =>
              Icon(Icons.face, color: selectedItem?.$2, size: 54),
    );
  }
}

class Example4 extends StatefulWidget {
  Example4({super.key});

  @override
  State<Example4> createState() => _Example4State();
}

class _Example4State extends State<Example4> {
  final GlobalKey<DropdownSearchState<UserModel>> formKey =
      GlobalKey<DropdownSearchState<UserModel>>();

  late List<UserModel> items;
  late List<UserModel> selectedItems;

  int customCompare(UserModel a, UserModel b) {
    bool aIsSelected = selectedItems
        .map((item) {
          return item.id;
        })
        .contains(a.id);
    bool bIsSelected = selectedItems
        .map((item) {
          return item.id;
        })
        .contains(b.id);
    if (aIsSelected && !bIsSelected) return -1; // a comes first
    if (!aIsSelected && bIsSelected) return 1; // b comes first
    return 0; // maintain original order for items in same category
  }

  @override
  void initState() {
    items = getData();
    selectedItems = List.of([items[0], items[2], items[5]]);
    items.sort(customCompare);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownSearch<UserModel>.multiSelection(
          key: formKey,
          items: (filter, s) => items,
          compareFn: (i, s) => i.isEqual(s),
          filterFn: (user, text) {
            final newtext = text.toLowerCase();
            return user.name.toLowerCase().contains(newtext) ||
                user.createdAt.toString().contains(newtext);
          },
          selectedItems: selectedItems,
          onChanged: (a) {
            selectedItems = a;
            items.sort(customCompare);
          },
          popupProps: PopupPropsMultiSelection.menu(
            menuProps: MenuProps(),
            showSelectedItems: true,
            // containerBuilder: (context, widget) {
            //   return Container(
            //     color: Colors.blue.withValues(alpha: 0.2),
            //     margin: EdgeInsets.only(bottom: 16),
            //   );
            // },
            // bottomSheetProps: BottomSheetProps(
            //   backgroundColor: Colors.blueGrey[50],
            // ),
            // listViewProps: ListViewProps(),
            showSearchBox: true,
            itemBuilder: userModelPopupItem,
            // suggestedItemProps: SuggestedItemProps(
            //   showSuggestedItems: true,
            //   suggestedItems: (us) {
            //     return us.where((e) => e.name.contains("Mrs")).toList();
            //   },
            // ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            log("${formKey.currentState?.getSelectedItems}");
            formKey.currentState?.popupDeselectAllItems();
            // formKey.currentState?.clear();
            if (formKey.currentState?.getSelectedItems[0] != null) {
              formKey.currentState?.removeItem(
                formKey.currentState!.getSelectedItems[0],
              );
            }
          },
          child: Text("save"),
        ),
      ],
    );
  }

  Widget userModelPopupItem(
    BuildContext context,
    UserModel item,
    bool isDisabled,
    bool isSelected,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration:
          !isSelected
              ? null
              : BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.name),
        subtitle: Text(item.createdAt.toString()),
        leading: CircleAvatar(child: Text(item.name[0])),
      ),
    );
  }
}

class UserModel {
  final String id;
  final DateTime createdAt;
  final String name;
  final String avatar;

  UserModel({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      createdAt: DateTime.parse(json["createdAt"]),
      name: json["name"],
      avatar: json["avatar"],
    );
  }

  static List<UserModel> fromJsonList(List list) {
    return list.map((item) => UserModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#$id $name';
  }

  ///this method will prevent the override of toString
  bool userFilterByCreationDate(String filter) {
    return createdAt.toString().contains(filter);
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(UserModel model) {
    return id == model.id;
  }

  @override
  String toString() => name;
}

List<UserModel> getData() {
  // var response = await Dio().get(
  //   "https://63c1210999c0a15d28e1ec1d.mockapi.io/users",
  //   queryParameters: {"filter": filter},
  // );
  final json = [
    {
      "createdAt": "2023-02-11T23:49:34.239Z",
      "name": "Mona Carroll V",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/501.jpg",
      "id": "1",
    },
    {
      "createdAt": "2023-02-12T07:49:43.700Z",
      "name": "Alfredo Gusikowski",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1087.jpg",
      "id": "2",
    },
    {
      "createdAt": "2023-02-12T12:56:28.998Z",
      "name": "Jacob Kling IV",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/327.jpg",
      "id": "3",
    },
    {
      "createdAt": "2023-02-12T15:57:04.682Z",
      "name": "Amber Lesch",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/806.jpg",
      "id": "4",
    },
    {
      "createdAt": "2023-02-11T20:41:44.914Z",
      "name": "Ted Bernhard",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/735.jpg",
      "id": "5",
    },
    {
      "createdAt": "2023-02-12T01:51:51.245Z",
      "name": "Benny Durgan",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/261.jpg",
      "id": "6",
    },
    {
      "createdAt": "2023-02-12T00:01:29.861Z",
      "name": "Beulah Maggio DDS",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/556.jpg",
      "id": "7",
    },
    {
      "createdAt": "2023-02-12T04:49:58.602Z",
      "name": "Miss Ashley Bernier",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/517.jpg",
      "id": "8",
    },
    {
      "createdAt": "2023-02-12T15:53:42.089Z",
      "name": "Kerry Metz",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/696.jpg",
      "id": "9",
    },
    {
      "createdAt": "2023-02-12T10:01:25.545Z",
      "name": "Jo Satterfield",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/978.jpg",
      "id": "10",
    },
    {
      "createdAt": "2023-02-12T04:33:52.126Z",
      "name": "Clarence Bednar",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1025.jpg",
      "id": "11",
    },
    {
      "createdAt": "2023-02-12T13:51:06.183Z",
      "name": "Marion Mertz IV",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/704.jpg",
      "id": "12",
    },
    {
      "createdAt": "2023-02-11T20:20:44.989Z",
      "name": "Janet Douglas Jr.",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1211.jpg",
      "id": "13",
    },
    {
      "createdAt": "2023-02-12T15:18:49.172Z",
      "name": "Dianna Fisher DVM",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/196.jpg",
      "id": "14",
    },
    {
      "createdAt": "2023-02-12T15:40:47.471Z",
      "name": "Ruth Thiel",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/601.jpg",
      "id": "15",
    },
    {
      "createdAt": "2023-02-12T07:57:50.198Z",
      "name": "Mr. Judith Keebler",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/903.jpg",
      "id": "16",
    },
    {
      "createdAt": "2023-02-12T16:00:10.764Z",
      "name": "Lula Bednar",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1091.jpg",
      "id": "17",
    },
    {
      "createdAt": "2023-02-12T00:43:27.089Z",
      "name": "Gerard Satterfield",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/76.jpg",
      "id": "18",
    },
    {
      "createdAt": "2023-02-12T18:25:18.767Z",
      "name": "Luke Cummerata",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/965.jpg",
      "id": "19",
    },
    {
      "createdAt": "2023-02-12T10:08:23.506Z",
      "name": "Brenda Kreiger",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/719.jpg",
      "id": "20",
    },
    {
      "createdAt": "2023-02-12T05:42:45.627Z",
      "name": "Dominick Gleason",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1240.jpg",
      "id": "21",
    },
    {
      "createdAt": "2023-02-12T07:34:52.210Z",
      "name": "Tammy Zieme",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/614.jpg",
      "id": "22",
    },
    {
      "createdAt": "2023-02-12T01:09:44.328Z",
      "name": "Joel Sanford",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/643.jpg",
      "id": "23",
    },
    {
      "createdAt": "2023-02-12T06:31:22.622Z",
      "name": "Grady Zemlak",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/450.jpg",
      "id": "24",
    },
    {
      "createdAt": "2023-02-12T09:08:18.168Z",
      "name": "Ellis Rutherford",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/979.jpg",
      "id": "25",
    },
    {
      "createdAt": "2023-02-12T11:58:26.281Z",
      "name": "Harold Langworth",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1216.jpg",
      "id": "26",
    },
    {
      "createdAt": "2023-02-12T11:03:53.155Z",
      "name": "Miss Heather Mitchell",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/192.jpg",
      "id": "27",
    },
    {
      "createdAt": "2023-02-12T06:22:38.269Z",
      "name": "Clara Olson",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1030.jpg",
      "id": "28",
    },
    {
      "createdAt": "2023-02-11T23:18:05.823Z",
      "name": "Cecilia Robel",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/965.jpg",
      "id": "29",
    },
    {
      "createdAt": "2023-02-12T02:57:32.226Z",
      "name": "Frances Balistreri",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1179.jpg",
      "id": "30",
    },
    {
      "createdAt": "2023-02-12T02:18:21.826Z",
      "name": "Dixie Collier",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/98.jpg",
      "id": "31",
    },
    {
      "createdAt": "2023-02-12T10:29:59.316Z",
      "name": "Wilbur Sporer Sr.",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1006.jpg",
      "id": "32",
    },
    {
      "createdAt": "2023-02-12T02:47:02.669Z",
      "name": "Homer West II",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/473.jpg",
      "id": "33",
    },
    {
      "createdAt": "2023-02-12T14:49:20.448Z",
      "name": "Ginger Douglas",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/636.jpg",
      "id": "34",
    },
    {
      "createdAt": "2023-02-12T13:21:35.273Z",
      "name": "Jacqueline Koch",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/944.jpg",
      "id": "35",
    },
    {
      "createdAt": "2023-02-12T01:30:12.254Z",
      "name": "Mrs. Roy Greenholt",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/116.jpg",
      "id": "36",
    },
    {
      "createdAt": "2023-02-12T16:24:07.736Z",
      "name": "Erma Gottlieb",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/836.jpg",
      "id": "37",
    },
    {
      "createdAt": "2023-02-11T21:36:48.355Z",
      "name": "Stephen Doyle III",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1144.jpg",
      "id": "38",
    },
    {
      "createdAt": "2023-02-12T07:37:32.527Z",
      "name": "Nina Kuhlman",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/609.jpg",
      "id": "39",
    },
    {
      "createdAt": "2023-02-12T10:39:17.841Z",
      "name": "Herbert Cremin",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/324.jpg",
      "id": "40",
    },
    {
      "createdAt": "2023-02-12T08:56:27.071Z",
      "name": "Jessie Fay",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/534.jpg",
      "id": "41",
    },
    {
      "createdAt": "2023-02-12T14:32:39.991Z",
      "name": "Oscar Kreiger",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/869.jpg",
      "id": "42",
    },
    {
      "createdAt": "2023-02-12T17:57:04.710Z",
      "name": "Albert Dietrich",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/579.jpg",
      "id": "43",
    },
    {
      "createdAt": "2023-02-12T12:02:36.013Z",
      "name": "Chester Dibbert IV",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/43.jpg",
      "id": "44",
    },
    {
      "createdAt": "2023-02-12T06:37:52.995Z",
      "name": "Ora Zulauf",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1236.jpg",
      "id": "45",
    },
    {
      "createdAt": "2023-02-12T07:35:20.344Z",
      "name": "Ralph Paucek",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/404.jpg",
      "id": "46",
    },
    {
      "createdAt": "2023-02-12T14:20:50.032Z",
      "name": "Emanuel Hills",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1013.jpg",
      "id": "47",
    },
    {
      "createdAt": "2023-02-12T14:46:53.687Z",
      "name": "Jeremy Ankunding",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/223.jpg",
      "id": "48",
    },
    {
      "createdAt": "2023-02-12T02:21:09.757Z",
      "name": "Ronnie Ledner",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1162.jpg",
      "id": "49",
    },
    {
      "createdAt": "2023-02-12T12:25:16.055Z",
      "name": "Denise Romaguera",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/880.jpg",
      "id": "50",
    },
    {
      "createdAt": "2023-02-12T02:38:57.045Z",
      "name": "Miriam Orn",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/283.jpg",
      "id": "51",
    },
    {
      "createdAt": "2023-02-12T04:32:15.194Z",
      "name": "Phillip Kuhlman",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/977.jpg",
      "id": "52",
    },
    {
      "createdAt": "2023-02-12T09:50:19.638Z",
      "name": "Tasha Legros",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/196.jpg",
      "id": "53",
    },
    {
      "createdAt": "2023-02-12T00:33:54.007Z",
      "name": "Flora Fahey",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1096.jpg",
      "id": "54",
    },
    {
      "createdAt": "2023-02-12T08:25:05.676Z",
      "name": "Donald Bergstrom IV",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/623.jpg",
      "id": "55",
    },
    {
      "createdAt": "2023-02-12T16:03:03.112Z",
      "name": "Tabitha Walsh",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/818.jpg",
      "id": "56",
    },
    {
      "createdAt": "2023-02-12T01:48:03.213Z",
      "name": "Krystal Hayes",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/215.jpg",
      "id": "57",
    },
    {
      "createdAt": "2023-02-12T02:32:02.536Z",
      "name": "Earnest Denesik DVM",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/673.jpg",
      "id": "58",
    },
    {
      "createdAt": "2023-02-12T05:36:42.069Z",
      "name": "Gustavo Labadie",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/44.jpg",
      "id": "59",
    },
    {
      "createdAt": "2023-02-12T06:27:35.996Z",
      "name": "Camille Cassin",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/207.jpg",
      "id": "60",
    },
    {
      "createdAt": "2023-02-12T03:39:04.236Z",
      "name": "Al Renner",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/323.jpg",
      "id": "61",
    },
    {
      "createdAt": "2023-02-12T08:24:26.268Z",
      "name": "Margie Williamson V",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/176.jpg",
      "id": "62",
    },
    {
      "createdAt": "2023-02-12T09:59:44.471Z",
      "name": "Terrell Schmidt Jr.",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/937.jpg",
      "id": "63",
    },
    {
      "createdAt": "2023-02-12T10:03:33.118Z",
      "name": "Andy Gleason",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/620.jpg",
      "id": "64",
    },
    {
      "createdAt": "2023-02-11T21:31:42.713Z",
      "name": "Angie Littel",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/349.jpg",
      "id": "65",
    },
    {
      "createdAt": "2023-02-12T11:57:43.955Z",
      "name": "Tim Reilly",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1210.jpg",
      "id": "66",
    },
    {
      "createdAt": "2023-02-12T19:06:16.076Z",
      "name": "Kenny Leffler",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/453.jpg",
      "id": "67",
    },
    {
      "createdAt": "2023-02-12T11:07:53.898Z",
      "name": "Orlando Marks",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/855.jpg",
      "id": "68",
    },
    {
      "createdAt": "2023-02-12T04:02:04.110Z",
      "name": "Brenda Ratke",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/245.jpg",
      "id": "69",
    },
    {
      "createdAt": "2023-02-12T04:21:31.343Z",
      "name": "Megan Murphy Jr.",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/239.jpg",
      "id": "70",
    },
    {
      "createdAt": "2023-02-11T22:01:39.632Z",
      "name": "Dixie Cruickshank",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/320.jpg",
      "id": "71",
    },
    {
      "createdAt": "2023-02-11T22:13:43.627Z",
      "name": "Dr. Brett Dare",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1136.jpg",
      "id": "72",
    },
    {
      "createdAt": "2023-02-12T16:07:52.674Z",
      "name": "Kayla Legros PhD",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/438.jpg",
      "id": "73",
    },
    {
      "createdAt": "2023-02-12T14:36:04.402Z",
      "name": "Mr. Darrell Rath III",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/144.jpg",
      "id": "74",
    },
    {
      "createdAt": "2023-02-12T19:02:43.291Z",
      "name": "Yvonne Breitenberg",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/121.jpg",
      "id": "75",
    },
    {
      "createdAt": "2023-02-12T17:13:16.350Z",
      "name": "Ramiro Kuhlman",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/669.jpg",
      "id": "76",
    },
    {
      "createdAt": "2023-02-12T14:26:17.911Z",
      "name": "Nicholas Senger",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/690.jpg",
      "id": "77",
    },
    {
      "createdAt": "2023-02-12T10:37:12.945Z",
      "name": "Jay Kuhic",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/868.jpg",
      "id": "78",
    },
    {
      "createdAt": "2023-02-12T17:20:31.794Z",
      "name": "Christy Dibbert Sr.",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/722.jpg",
      "id": "79",
    },
    {
      "createdAt": "2023-02-12T17:16:15.373Z",
      "name": "Ms. Jennie Legros",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1016.jpg",
      "id": "80",
    },
    {
      "createdAt": "2023-02-12T07:48:08.043Z",
      "name": "Kristy Jenkins",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/682.jpg",
      "id": "81",
    },
    {
      "createdAt": "2023-02-12T00:27:15.251Z",
      "name": "Elbert Jaskolski",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/870.jpg",
      "id": "82",
    },
    {
      "createdAt": "2023-02-12T04:51:31.766Z",
      "name": "Mrs. Adam Jacobson",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/935.jpg",
      "id": "83",
    },
    {
      "createdAt": "2023-02-12T06:11:26.272Z",
      "name": "Charles Barrows Sr.",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/430.jpg",
      "id": "84",
    },
    {
      "createdAt": "2023-03-19T21:31:17.126Z",
      "name": "Greg Durgan",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/322.jpg",
      "id": "85",
    },
    {
      "createdAt": "2023-03-19T20:03:13.285Z",
      "name": "Hugh Wyman",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1208.jpg",
      "id": "86",
    },
    {
      "createdAt": "2023-04-07T09:09:34.395Z",
      "name": "Kerry Batz",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/559.jpg",
      "id": "87",
    },
    {
      "createdAt": "2023-04-08T02:14:58.348Z",
      "name": "Fernando Kris",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/707.jpg",
      "id": "88",
      "filter": "Nina",
    },
    {
      "createdAt": "2023-04-07T22:18:39.252Z",
      "name": "Ann Kuhn",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/858.jpg",
      "id": "89",
      "filter": "Nina",
    },
    {
      "createdAt": "2023-04-08T06:11:56.655Z",
      "name": "Nick Hickle DDS",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/387.jpg",
      "id": "90",
      "filter": "Nina",
    },
    {
      "createdAt": "2023-05-04T21:26:06.175Z",
      "name": "Ramiro Raynor",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/944.jpg",
      "id": "91",
    },
    {
      "createdAt": "2023-06-09T15:25:08.337Z",
      "name": "Edward O'Reilly",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/945.jpg",
      "id": "92",
    },
    {
      "createdAt": "2023-06-10T01:47:24.648Z",
      "name": "Elijah Considine",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/262.jpg",
      "id": "93",
    },
    {
      "createdAt": "2023-06-10T05:40:18.558Z",
      "name": "Hubert Haag",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/486.jpg",
      "id": "94",
    },
    {
      "createdAt": "2023-06-09T11:43:52.381Z",
      "name": "Derrick Conn",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/644.jpg",
      "id": "95",
    },
    {
      "createdAt": "2023-07-16T23:51:15.638Z",
      "name": "Phyllis Bernier",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1016.jpg",
      "id": "96",
    },
    {
      "createdAt": "2023-07-16T22:47:00.068Z",
      "name": "Duane Toy",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1187.jpg",
      "id": "97",
    },
    {
      "createdAt": "2023-08-14T02:04:39.062Z",
      "name": "Troy Schinner MD",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/900.jpg",
      "id": "98",
    },
    {
      "createdAt": "2023-08-28T04:38:46.929Z",
      "name": "Raymond Powlowski V",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/467.jpg",
      "id": "99",
    },
    {
      "createdAt": "2023-09-22T07:57:32.413Z",
      "name": "Jamie Jakubowski",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/10.jpg",
      "id": "100",
      "filter": "",
    },
  ];

  // final data = response.data;
  // if (data != null) {
  return UserModel.fromJsonList(json);
  // }

  // return [];
}
