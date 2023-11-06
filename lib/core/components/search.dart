import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/home/search/presentation/controller/search_cubit.dart';
import 'package:social_app/features/home/search/presentation/controller/search_states.dart';

class Search extends StatefulWidget {
  const Search({super.key, required this.title});
  final String title;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var searchController = TextEditingController(text: '');

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Form(
                key: formKey,
                child: Container(
                  padding:
                      const EdgeInsets.all(10).copyWith(bottom: 0, top: 18),
                  width: 250,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    onChanged: (value) {
                      setState(() {
                        searchController.text = value;
                        searchController.selection = TextSelection.fromPosition(
                            TextPosition(offset: searchController.text.length));
                      });
                    },
                    onFieldSubmitted: (value) {
                      if (formKey.currentState!.validate()) {}
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.title,
                    ),
                  ),
                ),
              ),
              actions: [
                if (searchController.text != '')
                  IconButton(
                      onPressed: () {
                        setState(() {
                          searchController.text = '';
                        });
                      },
                      icon: const Icon(Icons.close))
              ],
            ),
            body: ConditionalBuilder(
              condition: searchController.text != '',
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          searchController.text,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () async {},
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: SearchItem(),
                          ),
                        ),
                        separatorBuilder: (context, index) => const SizedBox(),
                        itemCount: 7,
                      )
                    ],
                  ),
                );
              },
              fallback: (BuildContext context) => Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Try searching for people, groups or messages',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget SearchItem() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/images/profile.jpg'),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text(
                  'Sameh Barakat',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      overflow: TextOverflow.ellipsis),
                ),
                Icon(
                  Icons.verified,
                  color: Colors.blue,
                  size: 15,
                ),
              ],
            ),
            Text(
              'samehelsayedbarakat',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ],
    );
  }
}
