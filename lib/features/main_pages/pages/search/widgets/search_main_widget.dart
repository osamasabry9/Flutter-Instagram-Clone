import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/constants_manager.dart';
import 'package:instagram_clone/core/utils/values_manager.dart';

import '../../../../../core/widgets/input_field.dart';
import '../../../../auth/presentation/widgets/profile_widget.dart';

class SearchMainWidget extends StatefulWidget {
  const SearchMainWidget({Key? key}) : super(key: key);

  @override
  State<SearchMainWidget> createState() => _SearchMainWidgetState();
}

class _SearchMainWidgetState extends State<SearchMainWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(
              textController: _searchController,
              label: "Search",
              hint: "Search",
              prefix: Icons.search,
              validate: (p0) {
                return null;
              },
            ),
            AppConstants.sizeVer(AppSize.s20),
            _searchController.text.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  width: 40,
                                  height: 40,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: profileWidget(imageUrl: ''),
                                  ),
                                ),
                                AppConstants.sizeHor(AppSize.s12),
                                const Text(
                                  "username",
                                )
                              ],
                            ),
                          );
                        }),
                  )
                : Expanded(
                    child: GridView.builder(
                        itemCount: 2,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: profileWidget(imageUrl: ''),
                            ),
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }
}
