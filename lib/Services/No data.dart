import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Services/tools.dart';

class PageIsEmpty extends StatelessWidget {
  const PageIsEmpty({Key? key, required this.isOnSolde}) : super(key: key);
  final bool isOnSolde;
  @override
  Widget build(BuildContext context) {
    final Color couleur = MyTools(context).color;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(60.0),
              child: Image.asset('assets/images/ensembleVide.png'),
            ),
            const SizedBox(height: 20),
            isOnSolde ?
            Text(
              'Aucun produit en solde pour le moment !\n\n<<Restez à l\'écoute>>',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: couleur, fontSize: 28, fontWeight: FontWeight.w800),
            ) :
            Text(
                    'Aucun produit pour le moment !\n\n<<Restez à l\'écoute>>',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: couleur,
                        fontSize: 28,
                        fontWeight: FontWeight.w800),
                  )
          ],
        ),
      ),
    );
  }
}
