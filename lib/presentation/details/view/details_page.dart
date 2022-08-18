// ignore_for_file: inference_failure_on_function_return_type

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/injector/injector_support.dart';
import 'package:movie_app/common/l10n/l10n.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/presentation/details/cubit/details_cubit.dart';
import 'package:movie_app/presentation/details/view/details_view_constants.dart';
import 'package:movie_app/presentation/size_constants.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.movieEntity});
  final MovieEntity movieEntity;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late DetailsCubit detailsCubit;
  late List<String> genres;

  @override
  void initState() {
    detailsCubit = InjectorSupport.resolve<DetailsCubit>()
      ..getMovieDetailsByImdbId(widget.movieEntity.imdbID);
    genres = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      key: DetailsViewConstants.detailsScaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            expandedHeight: SizeConstants.size_250,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                '${widget.movieEntity.title} (${widget.movieEntity.year})',
                textScaleFactor: SizeConstants.size_0_8,
              ),
              background: CachedNetworkImage(
                imageUrl: widget.movieEntity.poster,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ConstrainedBox(
              constraints: const BoxConstraints(),
              child: BlocBuilder<DetailsCubit, DetailsState>(
                bloc: detailsCubit,
                builder: (context, state) {
                  if (state is FetchDetailsOnSuccess) {
                    return Padding(
                      padding: const EdgeInsets.all(SizeConstants.size_10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          sectionWidget(
                            sectionTitle: state.movieDetailsData.rated,
                            sectionContent: '',
                            titleKey: DetailsViewConstants.ratedTitleKey,
                            contentKey: DetailsViewConstants.ratedContentKey,
                          ),
                          const SizedBox(
                            height: SizeConstants.size_8,
                          ),
                          Visibility(
                            visible: genres.isNotEmpty,
                            child:
                                genreWidget(key: DetailsViewConstants.genreKey),
                          ),
                          const SizedBox(
                            height: SizeConstants.size_16,
                          ),
                          Text(
                            state.movieDetailsData.plot,
                            key: DetailsViewConstants.plotKey,
                            style: const TextStyle(
                              fontSize: SizeConstants.size_16,
                              color: Colors.white,
                            ),
                          ),
                          sectionWidget(
                            sectionTitle: l10n.awardsSection,
                            sectionContent: state.movieDetailsData.awards,
                            titleKey: DetailsViewConstants.awardTitleKey,
                            contentKey: DetailsViewConstants.awardContentKey,
                          ),
                          sectionWidget(
                            sectionTitle: l10n.actorsSection,
                            sectionContent: state.movieDetailsData.actors,
                          ),
                          sectionWidget(
                            sectionTitle: l10n.directorSection,
                            sectionContent: state.movieDetailsData.director,
                          ),
                          sectionWidget(
                            sectionTitle: l10n.directorSection,
                            sectionContent: state.movieDetailsData.writer,
                          ),
                          sectionWidget(
                            sectionTitle: l10n.boxOfficeSection,
                            sectionContent: state.movieDetailsData.boxOffice,
                          ),
                        ],
                      ),
                    );
                  }
                  return const LinearProgressIndicator(
                    key: DetailsViewConstants.linearProgressKey,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget genreWidget({Key? key}) {
    return Row(
      key: key,
      children: genres
          .map(
            (e) => Container(
              margin: const EdgeInsets.only(
                right: SizeConstants.size_10,
              ),
              padding: const EdgeInsets.all(
                SizeConstants.size_8,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(
                  SizeConstants.size_14,
                ),
              ),
              child: Text(
                e,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: SizeConstants.size_16,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget sectionWidget({
    required String sectionTitle,
    required String sectionContent,
    Key? titleKey,
    Key? contentKey,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: SizeConstants.size_16,
        ),
        Text(
          sectionTitle,
          key: titleKey,
          style: const TextStyle(
            color: Colors.white,
            fontSize: SizeConstants.size_20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          sectionContent,
          key: contentKey,
          style: const TextStyle(
            color: Colors.white,
            fontSize: SizeConstants.size_14,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
