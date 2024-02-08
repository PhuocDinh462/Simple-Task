import 'package:flutter/material.dart';
import 'package:to_do_list/utils/colors.dart';
import 'package:to_do_list/widgets/custom_search_bar.dart';
import 'package:to_do_list/widgets/filter_menu.dart';
import 'package:to_do_list/widgets/task_item.dart';

class ToDo extends StatefulWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ToDoState();
}

class ToDoState extends State<ToDo> {
  bool searchOpen = false;
  FilterItem selectedMenu = FilterItem.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        foregroundColor: TextColors.color_50,
        backgroundColor: MainColors.primary_300,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Header
          Container(
            color: MainColors.primary_300,
            height: 60,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: searchOpen
                        ? const CustomSearchBar(
                            textColor: TextColors.color_50, hintText: 'Search')
                        : const Text(
                            'ToDo',
                            style: TextStyle(
                              fontSize: 26,
                              color: TextColors.color_50,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () =>
                              setState(() => searchOpen = !searchOpen),
                          icon: Icon(
                              searchOpen ? Icons.clear_sharp : Icons.search),
                          iconSize: 32,
                          color: TextColors.color_50,
                        ),
                        FilterMenu(
                          selectedMenu: selectedMenu,
                          onItemSelected: (item) =>
                              setState(() => selectedMenu = item),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Body
          const Column(
            children: [
              SizedBox(height: 15),
              TaskItem(),
              SizedBox(height: 15),
              Divider(
                height: .5,
                thickness: .5,
                indent: 15,
                endIndent: 15,
                color: TextColors.color_600,
              ),
            ],
          )
        ],
      ),
    );
  }
}
