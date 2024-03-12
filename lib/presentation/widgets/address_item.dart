import 'package:flutter/material.dart';

Widget addressItem(String long, String lat, String address) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Address :",
              style: TextStyle(fontSize: 14),
            ),
            Text(
              (address.isEmpty) ? '-' : address,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
         Column(
           mainAxisAlignment: MainAxisAlignment.end,
           crossAxisAlignment: CrossAxisAlignment.end,
           children: [
             const Text(
               "Latitude",
               style: TextStyle(fontSize: 10),
             ),
             (lat.isEmpty) ? const SizedBox(
               height: 12,
               width: 12,
               child: CircularProgressIndicator(
                 strokeWidth: 1,),
             ): Text(
               lat,
               style: const TextStyle(fontSize: 12),
             ),
             const SizedBox(height: 2,),
             const Text(
                 "Longitude",
                 style: TextStyle(fontSize: 10)
             ),
             (long.isEmpty) ? const SizedBox(
               height: 12,
               width: 12,
               child: CircularProgressIndicator(
                 strokeWidth: 1,
               ),
             ): Text(
                 long,
                 style: const TextStyle(fontSize: 12)
             ),
           ],
         )
      ],
    ),
  );
}