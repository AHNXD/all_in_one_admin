// ignore_for_file: file_names

import 'package:all_in_one_admin/constant.dart';
import 'package:all_in_one_admin/services/apiService.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

class CamScanner extends StatefulWidget {
  const CamScanner({super.key});
  static String id = "/CamScanner";
  @override
  State<CamScanner> createState() => _CamScannerState();
}

class _CamScannerState extends State<CamScanner> {
  bool _isloading = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  String audioasset = "audios/beep.mp3";
  final player = AudioPlayer();
  String errorMasseg = "";
  Color errorColor = Colors.black;
  bool camOn = true;
  Color camOncolor = Colors.blue;
  // ignore: prefer_typing_uninitialized_variables
  late var response;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future pay({required int cost}) async {
    setState(() {
      errorColor = cColor;
      errorMasseg = "Waiting";
    });
    if (cost >= 0) {
      response = await ApiService.pay(
          code: result!.code!, amount: "$cost", notes: note.text);
      errorColor = response != 200 ? Colors.red : Colors.green;
      errorMasseg = response != 200 ? "Try again" : "Done";
      if (response == 200) {
        userData = await ApiService.getUser(code: result!.code!);
      }
    } else if (userData[0]["balance"] >= cost * (-1)) {
      response = await ApiService.pay(
          code: result!.code!, amount: "$cost", notes: note.text);
      errorColor = response != 200 ? Colors.red : Colors.green;
      errorMasseg = response != 200 ? "Try again" : "Done";
      if (response == 200) {
        userData = await ApiService.getUser(code: result!.code!);
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text(
                  "This user does not have enough credit, are you sure you want to continue ?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      response = await ApiService.pay(
                          code: result!.code!,
                          amount: "$cost",
                          notes: note.text);
                      errorColor = response != 200 ? Colors.red : Colors.green;
                      errorMasseg = response != 200 ? "Try again" : "Done";
                      if (response == 200) {
                        userData =
                            await ApiService.getUser(code: result!.code!);
                      }
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.all(20),
                        elevation: 20,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                    child: const Text("Yes"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        errorColor = Colors.black;
                        errorMasseg = "";
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.all(20),
                        elevation: 20,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                    child: const Text("No"),
                  )
                ],
                backgroundColor: pColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ));
    }
    setState(() {});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          height: 55,
        ),
        backgroundColor: pColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: pColor,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(20))),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          camOn = !camOn;
                          camOncolor = camOn ? Colors.blue : Colors.red;
                          if (camOn) {
                            controller?.resumeCamera();
                          } else {
                            controller?.stopCamera();
                          }
                        });
                      },
                      icon: Icon(
                        Icons.camera_alt,
                        color: camOncolor,
                      )),
                ),
                Container(
                    decoration: const BoxDecoration(
                      color: pColor,
                    ),
                    child: IconButton(
                      onPressed: () async {
                        await controller?.toggleFlash();
                        setState(() {});
                      },
                      icon: FutureBuilder<bool?>(
                        future: controller?.getFlashStatus(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data != null) {
                            return snapshot.data!
                                ? const Icon(
                                    Icons.flash_on,
                                    color: Colors.blue,
                                  )
                                : const Icon(
                                    Icons.flash_off,
                                    color: Colors.red,
                                  );
                          } else {
                            return const Icon(
                              Icons.flash_off,
                              color: Colors.red,
                            );
                          }
                        },
                      ),
                    )),
                Container(
                  decoration: const BoxDecoration(
                      color: pColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(20))),
                  child: IconButton(
                      onPressed: () async {
                        await controller?.flipCamera();
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.switch_camera,
                        color: Colors.white,
                      )),
                )
              ],
            ),
            Container(
                decoration: const BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: cColor,
                        blurRadius: 15.0,
                        offset: Offset(0.0, 0.75))
                  ],
                ),
                padding: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                child: Stack(
                  children: [
                    QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                          borderWidth: 15,
                          borderColor: cColor,
                          borderLength: 20,
                          borderRadius: 10,
                          cutOutSize: MediaQuery.of(context).size.width * 0.8),
                    ),
                    !camOn
                        ? Container(
                            height: MediaQuery.of(context).size.height / 2,
                            width: double.infinity,
                            color: pColor)
                        : Container()
                  ],
                )),
            const Divider(
              thickness: 5,
              color: pColor,
            ),
            Center(
              child: _isloading
                  ? Text(
                      textAlign: TextAlign.center,
                      "ID : ${result!.code}\nName : ${userData[0]["name"]}\nCash : ${userData[0]["balance"]}",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  : const Text('Scan a code',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Center(
                child: Text(
              errorMasseg,
              style: TextStyle(color: errorColor),
            )),
            const Divider(
              thickness: 5,
              color: pColor,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: price,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(color: pColor),
                        labelText: "Price",
                        hintText: "Enter the Price",
                        prefixIcon: const Icon(
                          Icons.format_list_numbered_sharp,
                          color: cColor,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: DropdownButton(
                            underline: Container(),
                            iconEnabledColor: cColor,
                            items: items.map((String item) {
                              return DropdownMenuItem(
                                  value: item, child: Text(item));
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                price.text = newValue!;
                              });
                            },
                          ),
                        ),
                        fillColor: pColor,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: pColor, width: 5),
                            borderRadius: BorderRadius.circular(25)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: cColor, width: 5),
                            borderRadius: BorderRadius.circular(25)),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: note,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(color: pColor),
                        labelText: "Note",
                        hintText: "Enter the Note",
                        prefixIcon: const Icon(
                          Icons.format_list_numbered_sharp,
                          color: cColor,
                        ),
                        fillColor: pColor,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: pColor, width: 5),
                            borderRadius: BorderRadius.circular(25)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: cColor, width: 5),
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () async {
                      await pay(cost: int.parse(price.text));
                    },
                    child: const Icon(Icons.account_balance)),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () async {
                      String cost = "-${price.text}";
                      await pay(cost: int.parse(cost));
                    },
                    child: const Icon(Icons.payment))
              ],
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: pColor),
                onPressed: () {
                  _isloading = false;
                  result = null;
                  errorColor = Colors.black;
                  errorMasseg = "";
                  setState(() {});
                },
                child: const Icon(Icons.refresh))
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (result == null || result?.code != scanData.code) {
        result = scanData;
        setState(() {
          errorColor = cColor;
          errorMasseg = "Please wait...";
        });
        player.play(AssetSource(audioasset));
        userData = await ApiService.getUser(code: result!.code!);
        _isloading = true;
        setState(() {
          errorColor = Colors.black;
          errorMasseg = "";
        });
      }
    });
  }
}
