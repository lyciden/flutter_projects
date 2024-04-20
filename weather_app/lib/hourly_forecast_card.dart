import "package:flutter/material.dart";

class HourlyForecastCard extends StatelessWidget {
  final String time;
  final IconData icon;
  final String value;
  const HourlyForecastCard({
    super.key,
    required this.time,
    required this.icon,
    required this.value,
    });

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 6,
            child: Container(
              width: 100,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  Text(time,
                    style : const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8,),
                  Icon(icon, size : 35),
                  const SizedBox(height: 8,),
                  Text(value + '˚C'),
                ],
              ),
            ),
          );
  }
}