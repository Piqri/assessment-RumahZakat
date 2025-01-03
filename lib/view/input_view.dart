import 'dart:developer';
import 'dart:io';
import 'package:assesment/view/weather_view.dart';
import 'package:assesment/view/widget/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:assesment/viewmodel/input_view_model.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class InputView extends StatelessWidget {
  const InputView({super.key});

  // Function to check for internet connectivity
  Future<bool> _isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InputViewModel(),
      child: Scaffold(
        body: Consumer<InputViewModel>(
          builder: (context, viewModel, _) {
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 20,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Selamat Datang',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      inputField(viewModel.nameController),
                      provinceDropdown(viewModel),
                      if (viewModel.selectedProvince != null)
                        cityDropdown(viewModel),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (viewModel.nameController.text.isEmpty) {
                              // Show error dialog if name is not filled
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.bottomSlide,
                                title: 'Nama Belum Diisi',
                                desc: 'Silahkan isi nama Anda terlebih dahulu.',
                                btnOkOnPress: () {},
                                btnOkColor: Colors.redAccent,
                              ).show();
                            } else if (viewModel.isValidInput()) {
                              // Check for network connectivity before submitting
                              bool isConnected = await _isConnected();
                              if (!isConnected) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.bottomSlide,
                                  title: 'Jaringan Tidak Tersedia',
                                  desc:
                                      'Tidak ada koneksi internet, silahkan cek kembali koneksi internet anda',
                                  btnOkOnPress: () {},
                                  btnOkColor: Colors.redAccent,
                                ).show();
                              } else {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return WeatherView(
                                    name: viewModel.getName(),
                                    city: viewModel.selectedCity!.name,
                                    province: viewModel.selectedProvince!.name
                                        .toString(),
                                  );
                                }));
                              }
                            } else {
                              log('Data Belum Lengkap');
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.info,
                                animType: AnimType.bottomSlide,
                                title: 'Data Belum Lengkap',
                                desc: 'Silahkan lengkapi data yang diperlukan',
                                btnOkOnPress: () {},
                                btnOkColor: Colors.blueAccent,
                              ).show();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
