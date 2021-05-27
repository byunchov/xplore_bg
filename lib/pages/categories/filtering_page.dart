import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xplore_bg/bloc/subcategory_list_bloc.dart';
import 'package:xplore_bg/models/category_tile.dart';
import 'package:xplore_bg/models/helpers.dart';
import 'package:xplore_bg/widgets/ui_elements.dart';

import '../blank_page.dart';

class FilteringPage extends StatefulWidget {
  final CategoryItem category;
  Map filters;

  FilteringPage({Key key, this.category, this.filters}) : super(key: key);
  @override
  _FilteringPageState createState() => _FilteringPageState();
}

class _FilteringPageState extends State<FilteringPage> {
  bool _isLoading;

  List<OrderDirection> orderDirection;
  List<FilterCtiteria> criteria;
  var selectedSubcategories = <String>[];
  var _subcategories = <SubcategoryCheckBox>[];

  OrderDirection selectedOrderDirection;
  FilterCtiteria selectedCriteria;
  Color _selectedColor;
  Color _unselectedColor = Colors.black;

  String _locale;

  @override
  void initState() {
    super.initState();
    setState(() => _isLoading = true);
    Future.delayed(Duration(milliseconds: 20)).then((_) {
      _getSubcategoryList();
      _fillFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    _selectedColor = Theme.of(context).primaryColor;
    double _screenWidth = MediaQuery.of(context).size.width;
    _locale = context.locale.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name ?? "Filtering"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                ExpansionTile(
                  title: Text("Подкатегория"),
                  initiallyExpanded: true,
                  leading: Icon(Icons.access_time),
                  children: _isLoading
                      ? _showLoadingIndicator()
                      : _showSubcategoryList(),
                ),
                Divider(height: 1, indent: 0, endIndent: 0),
                ExpansionTile(
                  title: Text("Критерий"),
                  initiallyExpanded: true,
                  leading: Icon(Icons.access_time),
                  children: criteria != null
                      ? criteria.map(_radioBtnCriteria).toList()
                      : _showLoadingIndicator(),
                ),
                Divider(height: 1, indent: 0, endIndent: 0),
                ExpansionTile(
                  title: Text("Подредба"),
                  initiallyExpanded: true,
                  leading: Icon(Icons.access_time),
                  children: orderDirection != null
                      ? orderDirection.map(_radioBtnOrderBy).toList()
                      : _showLoadingIndicator(),
                ),
                Divider(height: 1, indent: 0, endIndent: 0),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Colors.grey[400],
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: PrimaryOutlinedButtonRg(
                    child: Text("Clear".toUpperCase()),
                    onPressed: () {
                      setState(() {
                        this.selectedCriteria = criteria.first;
                        this.selectedOrderDirection = orderDirection.last;
                        for (var i = 0; i < _subcategories.length; i++) {
                          _subcategories[i].value = false;
                        }
                        selectedSubcategories.clear();
                      });
                    },
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: PrimaryButtonRg(
                    child: Text("Aplly".toUpperCase()),
                    elevation: 0,
                    onPressed: () {
                      Map filterCriteria = Map();
                      filterCriteria['subcategories'] = selectedSubcategories;
                      filterCriteria['order_by'] =
                          (this.selectedOrderDirection.tag == 'asc')
                              ? false
                              : true;
                      filterCriteria['field'] = this.selectedCriteria.tag;
                      Navigator.pop(context, filterCriteria);
                      print(filterCriteria);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _showSubcategoryList() {
    return _subcategories.isNotEmpty
        ? _subcategories.map(_checkboxTile).toList()
        : [
            Padding(
              padding: EdgeInsets.all(15),
              child: BlankPage(
                heading: tr('no_favourites'),
                shortText: tr('no_favourites_desc'),
                icon: Icons.list_alt_rounded,
              ),
            ),
          ];
  }

  List<Widget> _showLoadingIndicator() {
    return [
      Container(
        height: 150,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ];
  }

  Widget _checkboxTile(SubcategoryCheckBox checkBox) {
    final color = checkBox.value ? _selectedColor : _unselectedColor;
    return CheckboxListTile(
      value: checkBox.value,
      title: Text(
        checkBox.name,
        style: TextStyle(color: color),
      ),
      activeColor: _selectedColor,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (value) {
        print("Checkbox '${checkBox.name}' value is: $value");
        print(_subcategories);
        if (value) {
          selectedSubcategories.add(checkBox.tag);
        } else {
          selectedSubcategories.removeWhere((item) => (item == checkBox.tag));
        }
        setState(() {
          checkBox.value = value;
        });
      },
    );
  }

  Widget _radioBtnOrderBy(OrderDirection direction) {
    final selected = (this.selectedOrderDirection.tag == direction.tag);
    final color = selected ? _selectedColor : _unselectedColor;

    return RadioListTile<OrderDirection>(
      value: direction,
      groupValue: this.selectedOrderDirection,
      title: Text(
        direction.name,
        style: TextStyle(color: color),
      ),
      activeColor: _selectedColor,
      onChanged: (value) {
        print("Radio btn value is: ${value.tag}");
        setState(() {
          this.selectedOrderDirection = value;
        });
      },
    );
  }

  Widget _radioBtnCriteria(FilterCtiteria criteria) {
    final selected = (this.selectedCriteria.tag == criteria.tag);
    final color = selected ? _selectedColor : _unselectedColor;

    return RadioListTile<FilterCtiteria>(
      value: criteria,
      groupValue: this.selectedCriteria,
      title: Text(
        criteria.name,
        style: TextStyle(color: color),
      ),
      activeColor: _selectedColor,
      onChanged: (value) {
        print("Radio btn value is: ${value.tag}");
        setState(() {
          this.selectedCriteria = value;
        });
      },
    );
  }

  void _fillFilters() {
    setState(() {
      criteria = <FilterCtiteria>[
        FilterCtiteria(name: "Харесвания", tag: "loves_count"),
        FilterCtiteria(name: "Рейтинг", tag: "rating"),
      ];

      orderDirection = <OrderDirection>[
        OrderDirection(name: "Ascending", tag: "asc"),
        OrderDirection(name: "Descending", tag: "desc"),
      ];

      if (widget.filters != null) {
        String od = (widget.filters['order_by'] as bool) ? 'desc' : 'asc';
        String cr = widget.filters['field'] as String;
        selectedOrderDirection =
            orderDirection.where((item) => item.tag == od).first;
        selectedCriteria = criteria.where((item) => item.tag == cr).first;
      } else {
        selectedOrderDirection = orderDirection.last;
        selectedCriteria = criteria.first;
      }
    });
  }

  Future<void> _getSubcategoryList() async {
    var data = await context
        .read<SubcategoryListBloc>()
        .getCategoryList(widget.category.tag, _locale);
    _isLoading = false;
    setState(() {
      _subcategories = data;
      if (widget.filters != null) {
        if (widget.filters['subcategories'] != null) {
          var subs = List<String>.from(widget.filters['subcategories']);
          if (subs.isNotEmpty) {
            for (var sub in subs) {
              int index = _subcategories.indexWhere((item) => item.tag == sub);
              if (index >= 0) {
                _subcategories[index].value = true;
              }
            }
          }
        }
      }
    });
  }
}
