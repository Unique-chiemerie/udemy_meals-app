// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

enum Filter {
  glutenFree,
  lactosefree,
  vegetarian,
  vegan,
}

class Filterscreen extends StatefulWidget {
  const Filterscreen({super.key, required this.currentFilters});
  final Map<Filter, bool> currentFilters;

  @override
  State<Filterscreen> createState() => _FilterscreenState();
}

class _FilterscreenState extends State<Filterscreen> {
  var _gluttenfreeFilterset = false;
  var _Lactosefreefilterset = false;
  var _VegetarianfilterSet = false;
  var _VeganFilterSt = false;

  @override
  void initState() {
    super.initState();
    _gluttenfreeFilterset = widget.currentFilters[Filter.glutenFree]!;
    _Lactosefreefilterset = widget.currentFilters[Filter.lactosefree]!;
    _VegetarianfilterSet = widget.currentFilters[Filter.vegetarian]!;
    _VeganFilterSt = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('your Filters'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: _gluttenfreeFilterset,
            Filter.lactosefree: _Lactosefreefilterset,
            Filter.vegetarian: _VegetarianfilterSet,
            Filter.vegan: _VeganFilterSt,
          });
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _gluttenfreeFilterset,
              onChanged: (isChecked) {
                setState(() {
                  _gluttenfreeFilterset = isChecked;
                });
              },
              title: Text(
                'Glutten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'only include  Glutten - free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _Lactosefreefilterset,
              onChanged: (isChecked) {
                setState(() {
                  _Lactosefreefilterset = isChecked;
                });
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'only include lactose- free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _VegetarianfilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _VegetarianfilterSet = isChecked;
                });
              },
              title: Text(
                'vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'only include vegetarian meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _VeganFilterSt,
              onChanged: (isChecked) {
                setState(() {
                  _VeganFilterSt = isChecked;
                });
              },
              title: Text(
                'vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'only include vegan meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
