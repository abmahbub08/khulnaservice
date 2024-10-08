import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/pages/search_page.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:provider/provider.dart';

class SearchBox extends StatelessWidget {
  SearchBox({
    Key key,
  }) : super(key: key);

  ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    return InkWell(
      onTap: () {
        Nav.route(context, SearchPage(true, true));
      },
      child: Container(
        margin: EdgeInsets.only(left: 18, right: 18, top: 14),
        padding: EdgeInsets.only(left: 18, right: 18),
        height: 44,
        decoration: BoxDecoration(
          border: Border.all(color: themeColor.getColor().withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
                color: Color(0xFFA1B1C2).withOpacity(0.2),
                blurRadius: 9.0,
                offset: Offset(0.0, 6))
          ],
          color: Theme.of(context).bottomAppBarColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              "assets/icons/ic_search.svg",
              color: Color(0xFFA1B1C2),
              height: 12,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "Product, category search..",
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Color(0xFFA1B1C2),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
