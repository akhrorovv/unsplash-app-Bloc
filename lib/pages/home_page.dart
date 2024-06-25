import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_app/pages/search_page.dart';

import '../cubit/collections/collection_cubit.dart';
import '../cubit/home/home_cubit.dart';
import '../cubit/search/search_cubit.dart';
import 'collections_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<HomeCubit>(context);
    cubit.controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext, HomeState) {
        return Scaffold(
          body: PageView(
            controller: cubit.controller,
            onPageChanged: (int index) {
              cubit.onPageChange(index);
            },
            children: [
              BlocProvider(
                create: (context) => SearchCubit(),
                child: SearchPage(),
              ),
              BlocProvider(
                create: (context) => CollectionCubit(),
                child: CollectionPage(),
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black,
            currentIndex: cubit.selectedIndex,
            selectedItemColor: Colors.white,
            selectedLabelStyle: TextStyle(color: Colors.white),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  label: "Search"),
              BottomNavigationBarItem(
                icon: Icon(Icons.collections, color: Colors.white),
                label: "Collection",
              )
            ],
            onTap: (int index) {
              cubit.onTabChange(index);
            },
          ),
        );
      },
    );
  }
}
