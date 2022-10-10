import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/providers/restaurant_providers.dart';
import 'package:restaurant_app/ui/main/home/detail/detail_page.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/custom_dialog.dart';

class AddReviewPage extends StatefulWidget {
  static const rootName = "/add_review_page";
  final String restaurantId;

  const AddReviewPage({super.key, required this.restaurantId});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppBar(context),
                  const SizedBox(height: 25),
                  _buildTextForm(),
                  _buildState()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundColor: Colors.blueGrey,
          child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigation.intentWithDataClearTop(DetailPage.rootName,
                    arguments: widget.restaurantId);
              }),
        ),
        Text("Add Review",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.w700)),
        IconButton(
          icon: const Icon(
            Icons.send,
            color: Colors.blueGrey,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Provider.of<AddReviewProvider>(context, listen: false)
                  .addReviewRestaurant(
                      id: widget.restaurantId,
                      name: _nameController.text,
                      review: _reviewController.text);
            }
          },
        )
      ],
    );
  }

  Widget _buildState() {
    return Consumer<AddReviewProvider>(
      builder: (context, state, _) {
        if (state.state == ResultStatePost.loading) {
          return Center(
            child: Lottie.asset("images/logo.json", width: 250, height: 250),
          );
        } else if (state.state == ResultStatePost.success) {
          Future.microtask(() {
            customDialogData(context,
                title: "Success",
                message: "Congratulations, your review has been successfully added",
                routeName: DetailPage.rootName,
                arguments: widget.restaurantId);
          });
          return Text("");
        } else if (state.state == ResultState.error) {
          Future.microtask((){
            customDialog(context, title: "Failed", message: state.message);
          });
          return Text("");
        } else {
          return const Center(
            child: Text(''),
          );
        }
      },
    );
  }

  Widget _buildTextForm() {
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          showCursor: true,
          decoration: InputDecoration(
              hintText: "Input your name here...",
              isCollapsed: true,
              contentPadding: const EdgeInsets.all(16),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.2),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10))),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please Input Your Name";
            }
          },
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          controller: _reviewController,
          showCursor: true,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: "Input your review here...",
            isCollapsed: true,
            contentPadding: const EdgeInsets.all(16),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.2),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please Input Your Review";
            }
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _reviewController.dispose();
  }
}
