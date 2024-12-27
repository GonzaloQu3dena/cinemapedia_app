import 'package:flutter/material.dart';

/// ### Custom Appbar
/// It is a custom appbar that will be used in the home screen.
///
/// #### Author:
/// Gonzalo Quedena
class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Icon(
                    Icons.movie_outlined, color: colors.primary,
                  ),

                  const SizedBox(width: 5),
                  
                  Text(
                    'Cinemapedia',
                    style: titleStyle,
                  ),
                ],
              ),
            ),

            const Spacer(),

            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
          ],
        ),
      ),

    );
  }
}
