part of 'package:homemakers_merchant/app/features/payment/index.dart';

class AllTranscationsWidget extends StatefulWidget {
  const AllTranscationsWidget({
    super.key,
    this.hasShownInWalletDashboard = false,
  });

  final bool hasShownInWalletDashboard;

  @override
  _AllTranscationsWidgetController createState() => _AllTranscationsWidgetController();
}

class _AllTranscationsWidgetController extends State<AllTranscationsWidget> {
  late final ScrollController listViewBuilderScrollController;
  WidgetState<TranscationEntity> widgetState = const WidgetState<TranscationEntity>.none();

  // Pagination
  int pageSize = 20;
  int pageKey = 0;
  String? searchText;
  String? sorting;
  String? filtering;
  final PagingController<int, TranscationEntity> _pagingController = PagingController(firstPageKey: 0);
  List<TranscationEntity> _allAvailableTranscations = [];
  String? _searchTerm;
  String activeLocale = 'en_US';
  final Map<String, moment.MomentLocalization> locales = moment.MomentLocalizations.locales.map((key, value) => MapEntry(key, value()));

  @override
  void initState() {
    super.initState();

    listViewBuilderScrollController = ScrollController();
    activeLocale = serviceLocator<LanguageController>().targetAppLanguage.value.toString();
    _allAvailableTranscations = [];
    _allAvailableTranscations.clear();
    _pagingController.nextPageKey = 0;
    _pagingController.addPageRequestListener((pageKey) {
      this.pageKey = pageKey;
      _fetchPage(pageKey);
    });

    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching a all orders.',
            ),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => _pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });
  }

  Future<void> _fetchPage(int pageKey, {int pageSize = 10, String? searchItem, String? filter, String? sort}) async {
    try {
      final newItems = await readTrackingData();
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        if(widget.hasShownInWalletDashboard){
          // No update in pageKey
          final nextPageKey = pageKey;
          _pagingController.appendPage(newItems, nextPageKey);
        }else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(newItems, nextPageKey);
        }
      }
    } catch (error) {
      _pagingController.error = error;
    }
    return;
  }

  void _updateSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    _pagingController.refresh();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    listViewBuilderScrollController.dispose();
    _allAvailableTranscations = [];
    _allAvailableTranscations.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _AllTranscationsWidgetView(this);
}

class _AllTranscationsWidgetView extends WidgetView<AllTranscationsWidget, _AllTranscationsWidgetController> {
  const _AllTranscationsWidgetView(super.state);

  @override
  Widget build(BuildContext context) {
    moment.Moment.setGlobalLocalization(moment.MomentLocalizations.byLocale(state.activeLocale)!);
    final moment.Moment now = moment.Moment.now();
    return SizedBox(
      child: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => state._pagingController.refresh(),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            TranscationSearchInputSliver(
              onChanged: (searchTerm) => state._updateSearchTerm(searchTerm),
              isEnabled: !widget.hasShownInWalletDashboard,
            ),
            PagedSliverList<int, TranscationEntity>(
              pagingController: state._pagingController,
              builderDelegate: PagedChildBuilderDelegate<TranscationEntity>(
                animateTransitions: true,
                itemBuilder: (context, item, index) => Card(
                  key: ValueKey(index),
                  color: Colors.white,
                  margin: EdgeInsetsDirectional.only(bottom: 8),
                  child: Padding(
                    padding: EdgeInsetsDirectional.zero,
                    child: ListTile(
                      minVerticalPadding: 0,
                      leading: CircleAvatar(
                        backgroundColor: context.colorScheme.primaryContainer.withOpacity(0.9),
                        radius: 20,
                        child: ImageHelper(
                          image: getTranscationUserProfileName(item),
                          filterQuality: FilterQuality.high,
                          borderRadius: BorderRadiusDirectional.circular(10),
                          imageType: findImageType(getTranscationUserProfileName(item)),
                          imageShape: ImageShape.rectangle,
                          boxFit: BoxFit.cover,
                          defaultErrorBuilderColor: Colors.blueGrey,
                          errorBuilder: const Icon(
                            Icons.image_not_supported,
                            size: 10000,
                          ),
                          loaderBuilder: const CircularProgressIndicator(),
                          matchTextDirection: true,
                          placeholderText: getTranscationUserProfileName(item),
                          placeholderTextStyle: context.labelLarge!.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      title: Text(
                        getTranscationUserProfileName(item),
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: context.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        getRecord(item, now).$1,
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: context.labelMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: SizedBox(
                        width: 66,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              children: [
                                Icon(
                                  (item.hasIncome) ? Icons.arrow_upward : Icons.arrow_downward,
                                  size: 18,
                                  color: (item.hasIncome) ? '#38b000'.toColor : '#f95738'.toColor,
                                ),
                                /*Text(
                                  (item.hasIncome) ? '+' : '-',
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: context.bodyMedium!.copyWith(
                                    color: (item.hasIncome) ? '#38b000'.toColor : '#f95738'.toColor,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  textAlign: TextAlign.center,
                                ),*/
                                const AnimatedGap(2, duration: Duration(milliseconds: 200)),
                                Text(
                                  getRecord(item, now).$2,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: context.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              children: [
                                Center(
                                  child: Text(
                                    'SAR',
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: context.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getTranscationUserProfileName(TranscationEntity transcationEntity) {
  String defaultAssetPath = 'assets/svg/user_avatar.svg';
  if (transcationEntity.hasIncome) {
    return transcationEntity.summary.receive.senderName;
  } else {
    return transcationEntity.summary.transfer.receiverName;
  }
}

(String transcationDate, String paymentAmount) getRecord(TranscationEntity transcationEntity, moment.Moment now) {
  String paymentDateTime = '';
  String paymentAmountValue = '';
  if (transcationEntity.hasIncome) {
    paymentDateTime = convertDateTimeToHumanReadable(now, transcationEntity.summary.receive.paymentTransferDateTime);
    paymentAmountValue = transcationEntity.summary.receive.transcationAmount.toString();
    return (paymentDateTime, paymentAmountValue);
  } else {
    paymentDateTime = convertDateTimeToHumanReadable(now, transcationEntity.summary.transfer.paymentTransferDateTime);
    paymentAmountValue = transcationEntity.summary.transfer.transcationAmount.toString();
    return (paymentDateTime, paymentAmountValue);
  }
}
