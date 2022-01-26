import 'dart:io';

import 'package:demo_firebase/core/constant/firebase_storage.dart';
import 'package:demo_firebase/core/enum/transaction_enum.dart';
import 'package:demo_firebase/data/model/customer_model.dart';
import 'package:demo_firebase/presentation/controller/customer_controller.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class CustomerForm extends StatefulWidget {
  final TransactionMode transactionMode;

  const CustomerForm({
    Key? key,
    required this.transactionMode,
  }) : super(key: key);

  @override
  _CustomerFormState createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final CustomerController customerController = Get.find();
  late TextEditingController tecName;

  File? pictureFile;

  @override
  void initState() {
    tecName = TextEditingController();
    if (widget.transactionMode == TransactionMode.edit) {
      tecName.text = customerController.selectedCustomer.name;
    }
    super.initState();
  }

  @override
  void dispose() {
    tecName.dispose();
    super.dispose();
  }

  getImage(ImageSource imageSource) async {
    var picker = ImagePicker();

    try {
      var imageFile = await picker.pickImage(source: imageSource);
      if (imageFile != null) {
        var crop = await ImageCropper.cropImage(
          sourcePath: imageFile.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 100,
          maxHeight: 100,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarTitle: '',
            toolbarColor: Theme.of(context).scaffoldBackgroundColor,
            statusBarColor: Theme.of(context).scaffoldBackgroundColor,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            cropFrameColor: Theme.of(context).colorScheme.secondary,
            cropGridColor: Theme.of(context).colorScheme.secondary,
            dimmedLayerColor: Colors.transparent,
            toolbarWidgetColor: Theme.of(context).colorScheme.secondary,
            hideBottomControls: true,
          ),
          iosUiSettings: const IOSUiSettings(
            cancelButtonTitle: 'ចាកចេញ',
            doneButtonTitle: 'យល់ព្រម',
            rotateButtonsHidden: true,
            resetButtonHidden: true,
            rotateClockwiseButtonHidden: true,
          ),
        );

        setState(() {
          pictureFile = crop;
        });
      }
    } catch (e) {
      Get.snackbar('Error', 'Can not use picture');
    }
  }

  removeImage() {
    setState(() {
      pictureFile = null;
    });
  }

  saveCustomer(CustomerModel model) async {
    if (pictureFile != null) {
      firebase_storage.TaskSnapshot snapshot = await FirebaseStorageReference
          .customerProfile
          .child(model.id + '.jpg')
          .putFile(
            pictureFile!,
            firebase_storage.SettableMetadata(contentType: 'image/jpg'),
          );
      if (snapshot.state == firebase_storage.TaskState.success) {
        final String downloadUrl = await snapshot.ref.getDownloadURL();
        model = model.copyWith(profilePicture: downloadUrl);
      } else if (snapshot.state == firebase_storage.TaskState.error) {
        Get.snackbar('Error', 'Upload profile picture problem');
        return;
      }
    }

    customerController.saveCustomer(model);
  }

  updateCustomer(CustomerModel model) async {
    if (pictureFile != null) {
      firebase_storage.TaskSnapshot snapshot = await FirebaseStorageReference
          .customerProfile
          .child(model.id + '.jpg')
          .putFile(
            pictureFile!,
            firebase_storage.SettableMetadata(contentType: 'image/jpg'),
          );
      if (snapshot.state == firebase_storage.TaskState.success) {
        final String downloadUrl = await snapshot.ref.getDownloadURL();
        model = model.copyWith(profilePicture: downloadUrl);
      } else if (snapshot.state == firebase_storage.TaskState.error) {
        Get.snackbar('Error', 'Upload profile picture problem');
        return;
      }
    }

    customerController.updateCustomer(model);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.transactionMode == TransactionMode.add
            ? const Text('Add Customer')
            : const Text('Edit Customer'),
        actions: [
          IconButton(
            onPressed: () {
              if (widget.transactionMode == TransactionMode.add) {
                var id = const Uuid().v1();
                var model = CustomerModel(
                  id: id,
                  name: tecName.text,
                );
                saveCustomer(model);
              } else {
                var model = CustomerModel(
                    id: customerController.selectedCustomer.id,
                    name: tecName.text,
                    profilePicture:
                        customerController.selectedCustomer.profilePicture);
                updateCustomer(model);
              }
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: tecName,
            decoration: const InputDecoration(
              labelText: 'Customer Name',
            ),
          ),
          Row(
            children: [
              pictureFile == null
                  ? customerController.selectedCustomer.profilePicture == null
                      ? Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey.shade300,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person_add,
                              color: Colors.grey,
                              size: 40,
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            customerController.selectedCustomer.profilePicture!,
                            fit: BoxFit.fill,
                            width: 100,
                            height: 100,
                          ),
                        )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.file(
                        pictureFile!,
                        fit: BoxFit.fill,
                        width: 100,
                        height: 100,
                      ),
                    ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                width: 52,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => getImage(ImageSource.gallery),
                  child: const Icon(
                    Icons.photo_library,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 52,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => getImage(ImageSource.camera),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 52,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => removeImage(),
                  child: const Icon(
                    Icons.highlight_off,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
