import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamsScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;

  const TeamsScreenAppBar({required this.tabController});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFFE5E5E5)),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: Color(0xff1B1B1B),
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(left: 50),
        child: Row(
          children: [
            Text(
              " TE",
              style: GoogleFonts.montserrat(
                fontStyle: FontStyle.italic,
                color: Color(0xffFFFFFF),
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.085,
              ),
            ),
            Text(
              "AMS",
              style: GoogleFonts.montserrat(
                fontStyle: FontStyle.italic,
                color: Color(0xff6ABE66),
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.085,
              ),
            ),
          ],
        ),
      ),
      bottom: TabBar(
        labelColor: Colors.white,
        indicatorColor: Color(0xff6ABE66),
        controller: tabController,
        tabs: const [
          Tab(text: 'Teams'),
          Tab(text: 'Top Scorers'),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
