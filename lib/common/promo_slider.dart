import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:meet_my_app_buyer/common/circular_container.dart';
import 'package:meet_my_app_buyer/common/home_controller.dart';
import 'package:meet_my_app_buyer/common/rounded_images.dart';

class PromoSlider extends StatelessWidget {
  const PromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        SizedBox(
          width: double.infinity,

          child: CarouselSlider(
            items: [
              Rounded_image(
                imgURl:
                    "https://images.unsplash.com/photo-1554941426-a965fb2b9258?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8c2xpZGVyfGVufDB8fDB8fHww",
              ),
              Rounded_image(
                imgURl:
                    "https://images.unsplash.com/photo-1518972458649-b0f242a400ff?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHNsaWRlcnxlbnwwfHwwfHx8MA%3D%3D",
              ),
              Rounded_image(
                imgURl:
                    "https://images.unsplash.com/photo-1524591431555-cc7876d14adf?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8c2xpZGVyfGVufDB8fDB8fHww",
              ),
            ],
            options: CarouselOptions(
              // height: 180,
              viewportFraction: 1,
              onPageChanged: (index, _) =>
                  controller.updatePageIndicator(index),
            ),
          ),
        ),

        SizedBox(height: 8),

        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 3; i++)
                CircularContainer(
                  width: 20,
                  height: 4,
                  margin: const EdgeInsets.only(right: 4),
                  backgroundColor: controller.carousalCurrentIndex.value == i
                      ? Colors.blueGrey
                      : Colors.grey,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
