// ignore_for_file: must_be_immutable, always_declare_return_types, inference_failure_on_function_return_type, use_decorated_box, inference_failure_on_instance_creation, lines_longer_than_80_chars

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/injector/injector_support.dart';
import 'package:movie_app/common/l10n/l10n.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/presentation/dashboard/cubit/dashboard_cubit.dart';
import 'package:movie_app/presentation/dashboard/view/dashboard_view_constants.dart';
import 'package:movie_app/presentation/details/view/details_page.dart';
import 'package:movie_app/presentation/size_constants.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DashboardCubit dashboardCubit;
  TextEditingController searchTextFieldController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    dashboardCubit = InjectorSupport.resolve<DashboardCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        key: DashboardViewConstants.dashboardAppBarKey,
        title: Text(l10n.omdbAppBarTitle),
        elevation: SizeConstants.size_0,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(
              SizeConstants.size_24,
              SizeConstants.size_8,
              SizeConstants.size_24,
              SizeConstants.size_40,
            ),
            decoration: const BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(SizeConstants.size_30),
                bottomRight: Radius.circular(SizeConstants.size_30),
              ),
            ),
            child: TextField(
              key: DashboardViewConstants.searchFieldKey,
              controller: searchTextFieldController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(SizeConstants.size_10),
                ),
                suffixIcon: IconButton(
                  onPressed: searchTextFieldController.clear,
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: SizeConstants.size_20,
          ),
          BlocBuilder<DashboardCubit, DashboardState>(
            bloc: dashboardCubit,
            builder: (_, state) {
              if (state is MovieSearchOnError) {
                return _buildTextWidget(state.message);
              } else if (state is MovieSearchOnSuccess) {
                return _buildOnLoadedWidget(state.movieList);
              } else if (state is DashboardInitial) {
                return _buildTextWidget('Search movies');
              } else {
                return const Expanded(
                  key: DashboardViewConstants.onLoadingContainerKey,
                  child: Center(
                    child: CircularProgressIndicator(
                      key: DashboardViewConstants.onLoadingSpinnerKey,
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildTextWidget(dynamic msg) {
    return Expanded(
      child: Center(
        child: Text(
          msg.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: SizeConstants.size_18,
          ),
        ),
      ),
    );
  }

  Widget _buildOnLoadedWidget(List<MovieEntity> movieList) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: SizeConstants.size_2,
          mainAxisSpacing: SizeConstants.size_16,
          childAspectRatio: SizeConstants.size_0_9,
          crossAxisSpacing: SizeConstants.size_1,
        ),
        itemCount: movieList.length,
        itemBuilder: (_, i) {
          return _buildPosterWidget(movieList[i]);
        },
      ),
    );
  }

  Widget _buildPosterWidget(MovieEntity movie) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailsPage(movieEntity: movie),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              movie.poster,
            ),
          ),
        ),
      ),
    );
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () {
      if (query.length > 1) {
        dashboardCubit.getMovieBySearch(query);
      }
    });
  }
}
