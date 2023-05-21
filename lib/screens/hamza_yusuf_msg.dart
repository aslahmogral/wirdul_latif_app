import 'package:flutter/material.dart';

class HamzaYusfMsg extends StatelessWidget {
  const HamzaYusfMsg({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 50,
        ),
        Center(
          child: Text(
            '"People are in need of the Prophetic du’ā’s now, more than ever, because there are shayateen everywhere. If we could see the unseen world, I’m telling you, we would all pass out. Because there are demons all over the place. What you’re doing whilst reciting invocations and litanies is creating a space around you, that if the Jinn and shaytaan see it, they have to back away. If you are consistent with this (Wird al Latif), I guarantee you will see a difference in your life. And if you miss it out you’ll feel horrible during the day – it’ll feel like going outside without brushing your teeth. Put yourself in the protection of Allāh through daily du’ā."',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        )
      ],
    );
  }
}

class BioOfHaddad extends StatelessWidget {
  const BioOfHaddad({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Column(
            children: const [

              Text('Brief Biography of Imam al-Haddad (may Allah have mercy on him)',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.center,),
              SizedBox(height: 18,),
              Text(
                'Imam Abdullah al-Haddad was the renewer of the twelfth Islamic century. He was renowned, and deservedly so, for the breadth of his knowledge and his manifest sanctity. The profundity of his influence on Muslims is reflected by the fact that his books are still in print through out the Islamic world.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              // Spacer(),
              SizedBox(height: 16,),
              Text(
                'He was born in Tarim, in the hills of Hadramaut, one of the southerly regions of the Arabian peninsula, and grew up in an environment where the accent was upon piety, frugality, erudition, and an uncompromising thirst for gnosis fma’rifal. His lineage is traced back to the Prophet (peace be upon him) through Imam al-Husayn. His illustrious ancestors, the ‘Alawi sadat, had for centuries produced generation after generation of great scholars, gnostics and summoners to the Straight Path.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 16,),

              Text(
                'Imam al-Haddad died on the eve of the 7th of Dhu’l Qa’da, 1132 A.H., having spent his life bringing people to their Lord through his oral and written teaching, and his exemplary life. For a more thorough biography of this great Imam, see “The Sufi Sage of Arabia” by Dr. Mostafa Badawi.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              )
            ],
          ),
        )
      ],
    );
  }
}
