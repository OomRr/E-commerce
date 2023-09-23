import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/cubit/shop_cubit/shop_cubit.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var catModel = ShopCubit.get(context).categoriesModel;
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        children: [
          BlocConsumer<ShopCubit, ShopState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadows: const [
                          BoxShadow(
                            blurRadius: 6,
                            spreadRadius: 0,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Image(
                            image: NetworkImage(
                                catModel!.data!.data![index].image!),
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(width: 15,),
                          Text(catModel.data!.data![index].name,style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),),
                           const Spacer(),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_forward_ios_rounded))
                        ],
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
                itemCount: 5,
              );
            },
          ),
        ],
      ),
    );
  }
}
