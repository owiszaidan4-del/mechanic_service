import 'package:flutter/material.dart';

class personInfo_card extends StatelessWidget {
  const personInfo_card({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.3,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          /// العنوان
          Row(
            children: [
              Icon(Icons.badge, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                'معلومات العميل',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          SizedBox(height: 16),

          /// الاسم
          Row(
            children: [
              Icon(Icons.person, color: Colors.blue),
              SizedBox(width: 10),
              Text('الاسم: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                'أويس ابو زيدان',
                style: TextStyle(fontSize: 10, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),

          SizedBox(height: 10),

          /// الهاتف
          Row(
            children: [
              Icon(Icons.phone, color: Colors.blue),
              SizedBox(width: 10),
              Text('الهاتف: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('0791234567', style: TextStyle(fontSize: 10)),
            ],
          ),

          SizedBox(height: 10),

          /// المشكلة
          Row(
            children: [
              Icon(Icons.car_repair, color: Colors.blue),
              SizedBox(width: 10),
              Text('المشكلة: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                'عطل بالمحرك',
                style: TextStyle(fontSize: 10, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
