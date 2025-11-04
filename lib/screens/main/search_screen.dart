import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';
import 'package:lelang_app/widgets/wrapper/bottom_sheet_fit_content_wrapper.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  void _showSortFilterBottomSheet(BuildContext context) {
    bottomSheetFitContentWrapper(
      context: context,
      content: SortFilter(),
      isHorizontalPaddingActive: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _searchInput(context),
              _searchHistory(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchInput(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.white,
      child: Column(
        children: [
          TextField(
            autofocus: true,
            style: TextStyle(color: Colors.black),
            cursorColor: ColorPlanet.primary,
            decoration: InputDecoration(
              filled: true,
              hintText: 'Search products skibidi ...',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              fillColor: Colors.grey.shade100,
              prefixIcon: Icon(CupertinoIcons.search, color: Colors.grey),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              suffixIcon: IconButton(
                onPressed: () => _showSortFilterBottomSheet(context),
                icon: Icon(
                  CupertinoIcons.slider_horizontal_3,
                  color: Colors.black,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchHistory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                onPressed: () {},
                child: Text(
                  'Clear all',
                ),
              )
            ],
          ),
          Divider(color: Colors.grey.shade300),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Majogari $index'),
                trailing: Icon(CupertinoIcons.xmark, color: Colors.black54),
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity(vertical: -2),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SortFilter extends StatefulWidget {
  SortFilter({super.key});

  @override
  State<SortFilter> createState() => _SortFilterState();
}

class _SortFilterState extends State<SortFilter> {
  SfRangeValues _values = SfRangeValues(40.0, 80.0);

  List<String> categories = ['All', 'T-Shirt', 'Shoes', 'Pants', 'Hat'];
  List<String> genders = ['All', 'Men', 'Women'];
  List<String> sortBy = [
    'Newest',
    'Popular',
    'Price: Low to High',
    'Price: High to Low'
  ];
  List<String> retings = ['⭐All', '⭐5', '⭐4', '⭐3', '⭐2', '⭐1'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text('Sort & Filter',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 5),
        Divider(color: Colors.grey.shade300),
        SizedBox(height: 10),
        _sortFilterText('Category'),
        SizedBox(height: 10),
        _sortFilterButtons(categories, 0),
        SizedBox(height: 10),
        _sortFilterText('Gender'),
        SizedBox(height: 10),
        _sortFilterButtons(genders, 0),
        SizedBox(height: 10),
        _sortFilterText('Price Range'),
        SfRangeSlider(
          min: 0.0,
          max: 100.0,
          values: _values,
          interval: 20,
          showTicks: true,
          showLabels: true,
          enableTooltip: true,
          minorTicksPerInterval: 1,
          onChanged: (SfRangeValues values) {
            setState(() {
              _values = values;
            });
          },
        ),
        SizedBox(height: 10),
        _sortFilterText('Sort By'),
        SizedBox(height: 10),
        _sortFilterButtons(sortBy, 0),
        SizedBox(height: 10),
        _sortFilterText('Rating'),
        SizedBox(height: 10),
        _sortFilterButtons(retings, 0)
      ],
    );
  }

  Padding _sortFilterText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Container _sortFilterButtons(List<String> items, int activeIndex) {
    return Container(
      height: 35,
      child: ListView.separated(
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (context, index) => SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = items[index];
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  activeIndex == index ? ColorPlanet.primary : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: ColorPlanet.primary, width: 2),
              ),
            ),
            onPressed: () {},
            child: Text(
              item,
              style: TextStyle(
                color:
                    activeIndex == index ? Colors.white : ColorPlanet.primary,
                fontSize: 16,
              ),
            ),
          );
        },
      ),
    );
  }
}
