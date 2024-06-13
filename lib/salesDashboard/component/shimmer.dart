import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siddha_connect/utils/sizes.dart';
import '../../utils/common_style.dart';

class DashboardShimmerEffect extends StatelessWidget {
  const DashboardShimmerEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ShimmerComp(),
              ShimmerComp(),
              ShimmerComp(),
            ],
          ),
          heightSizedBox(10.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ShimmerComp(),
              ShimmerComp(),
              ShimmerComp(),
            ],
          ),
        ],
      ),
    );
  }
}

class ShimmerComp extends StatelessWidget {
  const ShimmerComp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: width(context) * 0.3,
      decoration: BoxDecoration(
          color: const Color(0xffF8F5F5),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade100,
          highlightColor: Colors.grey.shade300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 15,
                width: width(context),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4)),
              ),
              heightSizedBox(10.0),
              Container(
                height: 10,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4)),
              ),
              heightSizedBox(10.0),
              Container(
                height: 20,
                width: width(context),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardComp extends StatelessWidget {
  final String title, value;
  final Color? valueColor;
  final double? titleSize;
  const DashboardComp(
      {super.key,
      required this.title,
      required this.value,
      this.valueColor,
      this.titleSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding:
              EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w, bottom: 5.h),
          width: width(context) * 0.3,
          decoration: BoxDecoration(
              color: const Color(0xffF8F5F5),
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: titleSize ?? 13.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xffA8A8A8),
                  ),
                ),
              ),
              Text(
                value,
                style: GoogleFonts.leagueSpartan(
                  textStyle: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w300,
                    color: valueColor ?? AppColor.primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
