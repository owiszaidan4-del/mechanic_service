import 'package:flutter/material.dart';

class personInfo_card extends StatelessWidget {
  const personInfo_card({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.proplemVechel,
  });
  final String name;
  final String phoneNumber;
  final String proplemVechel;
  @override
  Widget build(BuildContext context) {
    final listStr = name.split(' ');
    final String nameDriver = '${listStr[0]} ${listStr[listStr.length - 1]}';
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// العنوان
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.badge, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                'معلومات العميل',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          SizedBox(height: 16),

          /// الاسم
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.person, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    'الاسم: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                ],
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(
                  nameDriver,
                  style: TextStyle(
                    fontSize: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          /// الهاتف
          Row(
            children: [
              Icon(Icons.phone, color: Colors.blue),
              SizedBox(width: 10),
              Text(
                'الهاتف: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
              Text(phoneNumber, style: TextStyle(fontSize: 10)),
            ],
          ),

          SizedBox(height: 10),

          /// المشكلة
          Row(
            spacing: 8,
            children: [
              Row(
                children: [
                  Icon(Icons.car_repair, color: Colors.blue),
                  Text(
                    'المشكلة: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                ],
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.34,
                child: Text(
                  proplemVechel,
                  style: TextStyle(
                    fontSize: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
