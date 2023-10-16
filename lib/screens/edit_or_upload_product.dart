import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopsmart_admin/consts/app_constants.dart';
import 'package:shopsmart_admin/consts/my_validators.dart';
import 'package:shopsmart_admin/services/my_app_method.dart';
import 'package:shopsmart_admin/widgets/subtitle_text.dart';
import 'package:shopsmart_admin/widgets/title_text.dart';

class EditOrUploadProductScreen extends StatefulWidget {
  const EditOrUploadProductScreen({super.key});
  static const String routeName = '/EditOrUploadProductScreen';

  @override
  State<EditOrUploadProductScreen> createState() =>
      _EditOrUploadProductScreenState();
}

class _EditOrUploadProductScreenState extends State<EditOrUploadProductScreen> {
  final _formKey = GlobalKey<FormState>();
  XFile? _pickerImage;
  late TextEditingController _titleController,
      _priceController,
      _quantityController,
      _descriptionController;
  String? _categoryValue;
  @override
  void initState() {
    _titleController = TextEditingController();
    _priceController = TextEditingController();
    _quantityController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  void clearForm() {
    _titleController.clear();
    _priceController.clear();
    _quantityController.clear();
    _descriptionController.clear();
    removePickerImage();
  }

  void removePickerImage() {
    setState(() {
      _pickerImage = null;
    });
  }

  Future<void> _uploadProduct() async {
    if (_categoryValue == null) {
      MyAppMethods.showErrorORWarningDialog(
          context: context, subtitle: 'Category is empty', fct: () {});
      return;
    }

    final isVaild = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isVaild) {}
  }

  Future<void> _editProduct() async {
    final isVaild = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isVaild) {}
  }

  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await MyAppMethods.imagePickerDialog(
        context: context,
        cameraFCT: () async {
          _pickerImage = await picker.pickImage(source: ImageSource.camera);
          setState(() {});
        },
        galleryFCT: () async {
          _pickerImage = await picker.pickImage(source: ImageSource.gallery);
          setState(() {});
        },
        removeFCT: () async {
          setState(() {
            _pickerImage = null;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: kBottomNavigationBarHeight + 10,
          child: Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                    icon: const Icon(Icons.clear),
                    label: const Text(
                      "Clear",
                      style: TextStyle(fontSize: 22),
                    ),
                    onPressed: () {},
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                    icon: const Icon(Icons.upload),
                    label: const Text(
                      "Upload Product",
                      style: TextStyle(fontSize: 22),
                    ),
                    onPressed: () {
                      _uploadProduct();
                    },
                  ),
                ]),
          ),
        ),
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: const TitlesTextWidget(label: 'Upload a new Product')),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 25,
            ),
            DropdownButton(
                hint: const Text('Select a category'),
                value: _categoryValue,
                items: AppConstants.categoryIsDropDown,
                onChanged: (String? value) {
                  setState(() {
                    _categoryValue = value;
                  });
                }),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        key: const ValueKey('Title'),
                        maxLength: 80,
                        minLines: 1,
                        maxLines: 2,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        decoration:
                            const InputDecoration(hintText: 'Product Title'),
                        validator: (value) {
                          return MyValidators.uploadProdTexts(
                              value: value,
                              toBeReturnedString:
                                  "Please enter a vaild title ");
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: TextFormField(
                              controller: _priceController,
                              key: const ValueKey('Price\$'),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}'),
                                ),
                              ],
                              decoration: const InputDecoration(
                                  hintText: 'Price',
                                  prefix: SubtitleTextWidget(
                                    label: "\$",
                                    color: Colors.blue,
                                  )),
                              validator: (value) {
                                return MyValidators.uploadProdTexts(
                                    value: value,
                                    toBeReturnedString: "Price is Missing ");
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            flex: 1,
                            child: TextFormField(
                              controller: _quantityController,
                              key: const ValueKey('Quantity'),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                hintText: 'Qty',
                              ),
                              validator: (value) {
                                return MyValidators.uploadProdTexts(
                                    value: value,
                                    toBeReturnedString: "Qunatity is Missed ");
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        key: const ValueKey('Description'),
                        maxLength: 1000,
                        minLines: 3,
                        maxLines: 8,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                            hintText: 'Product description'),
                        validator: (value) {
                          return MyValidators.uploadProdTexts(
                              value: value,
                              toBeReturnedString: "Descriptionis Missed ");
                        },
                        onTap: () {},
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: kBottomNavigationBarHeight + 10,
            )
          ]),
        )));
  }
}