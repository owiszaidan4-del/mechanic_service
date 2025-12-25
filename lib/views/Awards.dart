import 'package:flutter/material.dart';

class Awards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("حوافز", style: TextStyle(fontSize: 12)),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Image.asset("asset/trophy.png", width: 50, height: 50),
              ),
              SizedBox(height: 20),
              Awards_Statment2(),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  alignment: Alignment.center,

                  color: Colors.grey.withOpacity(0.2),
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Text(
                          "لايوجد حوافز لغاية الان",
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Awards_Statment2 extends StatefulWidget {
  const Awards_Statment2({super.key});

  @override
  State<Awards_Statment2> createState() => _Awards_Statment2State();
}

class _Awards_Statment2State extends State<Awards_Statment2> {
  List<Color> colors = [
    Colors.grey.withOpacity(0.3),
    Colors.grey.withOpacity(0.3),
    Colors.grey.withOpacity(0.3),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(fontSize: 10, color: Colors.black),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              resetColor(0);
              setState(() {
                colors[0] = Colors.blueAccent;
              });
            },
            child: AnimatedContainer(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.2,
              duration: Duration(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colors[0],
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text("جارية الان"),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              resetColor(1);
              setState(() {
                colors[1] = Colors.blueAccent;
              });
            },
            child: AnimatedContainer(
              width: MediaQuery.of(context).size.width * 0.2,
              alignment: Alignment.center,
              duration: Duration(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colors[1],
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text("قادمة"),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              resetColor(2);
              setState(() {
                colors[2] = Colors.blueAccent;
              });
            },
            child: AnimatedContainer(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.2,
              duration: Duration(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colors[2],
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text("ماضية"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  resetColor(int index) {
    for (var element in colors) {
      element = Colors.grey.withOpacity(0.3);
    }
  }
}
