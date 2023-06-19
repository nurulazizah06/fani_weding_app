import 'package:fani_wedding/util/XColors.dart';
import 'package:fani_wedding/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faq/flutter_faq.dart';

class AboutUsView extends StatelessWidget {
  static String? routeName = "/AboutUsView";
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tentang Kami',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(Constants.kPaddingL),
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.asset(
              "assets/images/about.png",
              fit: BoxFit.fitHeight,
            ),
          ),
          _faq(
            context,
            question: 'Mengapa Harus Kami?',
            answer:
                'Karena Anda tidak perlu khawatir, setiap detail tentang acara pernikahan Anda adalah perhatian dan tanggung jawab kami. Tim profesional kami siap melayani berbagai kebutuhan pernikahan impian Anda, mulai persiapan acara hingga saat acara berlangsung.',
          ),
          _faq(
            context,
            question: 'Langkah Order',
            answer:
                '1. Memilih produk yang di inginkan, kemudian  melakukan pemesanan. \n2. Admin akan mengkonfirmasi Anda melalui   status pemesanan  "Diterima". \n3. Ketika status pemesanan “Diterima” maka  Anda dapat melanjutkan pembayaran.',
          ),
          _faq(
            context,
            question: 'Syarat Dan Ketentuan',
            answer:
                '1. Kami berhak menggunakan foto Anda sebagai  bagian promosi kami. \n2. Diluar kecamatan Ambulu, Kab. Jember dikenakan   biaya transport. \n3. Uang yang telah ditransfer tidak dapat   dikembalikan kembali.',
          ),
          _faq(
            context,
            question: 'Kontak Kami',
            answer:
                'Email : Fannymanyun26@gmail.com \nInstagram : @fanny_makeupwedding \nTiktok : fanny_makeup \nWhatsapp : 082161171191 / 082244442422 \nAlamat : Jl. Mangga Karang Templek, Ambulu, Kabupaten Jember, Jawa Timur',
          ),
        ],
      ),
    );
  }

  FAQ _faq(
    BuildContext context, {
    required String question,
    required String answer,
  }) {
    return FAQ(
      ansPadding: const EdgeInsets.fromLTRB(
        Constants.kPaddingL,
        0,
        Constants.kPaddingL,
        Constants.kPaddingL,
      ),
      ansDecoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(
            Constants.kPaddingL,
          ),
          bottomRight: Radius.circular(
            Constants.kPaddingL,
          ),
        ),
        color: XColors.primary.withOpacity(0.3),
      ),
      queDecoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(
            Constants.kPaddingL,
          ),
          topRight: Radius.circular(
            Constants.kPaddingL,
          ),
        ),
        color: XColors.primary.withOpacity(0.3),
      ),
      question: question,
      answer: answer,
      ansStyle: Theme.of(context).textTheme.bodyText2,
      queStyle: Theme.of(context).textTheme.headline6,
    );
  }
}
