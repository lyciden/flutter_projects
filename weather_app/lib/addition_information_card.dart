import "package:flutter/material.dart";

class AdditionalInformationCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AdditionalInformationCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation : 0,
                child:  Column(
                  children: [
                    Icon(icon, size: 40),
                    const SizedBox(height: 8,),
                    Text(label, style : TextStyle(fontSize: 16)),
                    const SizedBox(height: 8,),
                    Text(value, style : TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                  ],
                ),
        );
  }
}