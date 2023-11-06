import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app/features/authentication/register/presentation/view/create_account.dart';

Widget Footer(
  context,
  text1,
  text2, {
  bool? nxtInAuth,
  required bool inLogin,
  void Function()? nxtOnTap,
  required bool texted,
  bool firstTerm = true,
  required Widget navigatTo,
  void Function()? onsubmit,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Divider(),
      Padding(
        padding: const EdgeInsets.all(15).copyWith(top: 5),
        child: Row(
          mainAxisAlignment: firstTerm
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.end,
          children: [
            if (firstTerm)
              InkWell(
                onTap: () {
                  if (!inLogin) {
                    Navigator.pop(context);
                  } else if (inLogin) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateAccount(),
                      ),
                    );
                  }
                },
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 1,
                        )),
                    child: Text(
                      text1,
                      style: GoogleFonts.cairo(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    )),
              ),
            if (nxtInAuth == false && inLogin == true)
              InkWell(
                onTap: nxtOnTap,
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                    decoration: BoxDecoration(
                        color: texted == true
                            ? Colors.black
                            : Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 1,
                        )),
                    child: Text(
                      'Next',
                      style: GoogleFonts.cairo(
                          color: texted == true
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            if (nxtInAuth == true || inLogin == false)
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: texted == true
                    ? onsubmit
                    // () {

                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => navigatTo,
                    //       ),
                    //     );
                    //   }
                    : null,
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                    decoration: BoxDecoration(
                        color: texted == true
                            ? Colors.black
                            : Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 1,
                        )),
                    child: Text(
                      text2,
                      style: GoogleFonts.cairo(
                          color: texted == true
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
              ),
          ],
        ),
      ),
    ],
  );
}
