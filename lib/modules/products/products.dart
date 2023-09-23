import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/HomeModel.dart';
import 'package:shop/models/cate.dart';
import 'package:shop/shared/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder: (context) => Scaffold(
            body: buildColumn(ShopCubit.get(context).homeModel,
                ShopCubit.get(context).categoriesModel, context),
          ),
          fallback: (BuildContext context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildColumn(
      HomeModel? homModel, CategoriesModel? categoriesModel, BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: homModel!.data?.banners
                  ?.map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 200,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              )),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: SizedBox(
              height: 100,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 10,
                ),
                itemBuilder: (context, index) => buildCategoriesPics(
                    categoriesModel!.data!.data![index]),
                itemCount:
                     categoriesModel!.data!.data!.length??0,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          const Text(
            'Products',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.grey,
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1.1 / 1.2,
              children: List.generate(
                homModel.data!.products!.length,
                (index) => buildGridProduct(homModel.data!.products?[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildCategoriesPics(ProductData productData) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: NetworkImage('${productData.image}'),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Container(
              width: double.infinity,
              color: Colors.black.withOpacity(0.6),
              child: Text(
                productData.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }

  Widget buildGridProduct(model) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child:
                Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
              ),
              if (model.discount != 0)
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.red,
                    child: Text(
                      'discount'.toUpperCase(),
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ))
            ]),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(height: 1.3),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style:
                            const TextStyle(color: defaultColor, fontSize: 16),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border_outlined,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
