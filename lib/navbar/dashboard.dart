import 'package:flutter/material.dart ';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Proplant"),
      // ),
      // drawer: const Drawer(),
      body: Container(
        margin: const EdgeInsets.only(top: 8),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // children: [
                //   SvgPicture.asset("assets/images/onboard2.svg"),
                //   Container(
                //     height: 59,
                //     width: 59,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //   )
                // ],
              ),
            ),
            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
