import 'package:agent_module/app_services/customer.app_service.dart';
import 'package:agent_module/repository/models/customer_navigator.output_model.dart';
import 'package:agent_module/screens/customers/add-customer.screen.dart';
import 'package:agent_module/screens/customers/customer-filters.widget.dart';
import 'package:agent_module/screens/customers/customer-status.widget.dart';
import 'package:agent_module/view-models/customer.view-model.dart';
import 'package:agent_module/view-models/customer_input.view_model.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_module/Widget/app_scaffold.dart';
import 'package:shared_module/Widget/first_page_error_indicator.widget.dart';
import 'package:shared_module/Widget/new_page_error_indicator.widget.dart';
import 'package:shared_module/Widget/no_items_found_indicator.wdiget.dart';
import 'package:shared_module/Widget/primary_container.widget.dart';
import 'package:shared_module/app_services/customer-category.app_service.dart';
import 'package:shared_module/app_services/settings.app_service.dart';
import 'package:shared_module/app_services/shared.app_service.dart';
import 'package:shared_module/localization/shared.localization.dart';
import 'package:shared_module/model/customer_category.output_model.dart';
import 'package:shared_module/service/input_formater.service.dart';
import 'package:shared_module/theme/app.theme.dart';
import 'package:shared_module/theme/shared.icons.dart';
import 'package:shared_module/Widget/CustomPage.Route.dart';

class SelectCustomerScreen extends StatefulWidget {
  const SelectCustomerScreen({super.key});

  @override
  State<SelectCustomerScreen> createState() => _SelectCustomerScreenState();
}

class _SelectCustomerScreenState extends State<SelectCustomerScreen> {
  late CustomerAppService _appService;
  final PagingController<int, CustomerNavigatorItemOutputModel>
  _pagingController = PagingController(firstPageKey: 0);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // Timer? _debounce;

  // String queryText = "";
  late Map<String?, String> categoryMap;
  String? groupKey;
  final CustomerInputViewModel _inputViewModel = CustomerInputViewModel();
  ValueNotifier<bool> isFiltering = ValueNotifier(false);

  _onFilterData() async {
    _appService.cancel();
    await Future.delayed(const Duration(milliseconds: 100));

    if (!context.mounted) return;
    final CustomerInputViewModel? input =
    await showModalBottomSheet<CustomerInputViewModel>(
        context: context,
        builder: (ctx) => CustomerFilterWidget(
          inputViewModel: _inputViewModel.clone(),
        ));

    if (input != null) {
      _inputViewModel.customerVerifiedStatusEnum =
          input.customerVerifiedStatusEnum;
      _inputViewModel.isIncludeNotAssignedToPlan =
          input.isIncludeNotAssignedToPlan;
      isFiltering.value = _inputViewModel.isFitlering;
      _pagingController.refresh();
    }
  }

  // _onSearchChanged(String query) {
  //   if (_debounce?.isActive ?? false) _debounce!.cancel();
  //   _debounce = Timer(const Duration(milliseconds: 500), () {
  //     queryText = query;
  //     _pagingController.refresh();
  //   });
  // }

  @override
  void initState() {
    _appService = CustomerAppService();

    categoryMap = {null: SharedLocalization.getLocalization!().all};
    groupKey = categoryMap.keys.first;

    Future.delayed(Duration.zero, () async {
      if (SettingsAppService.isGroupMode) {
        final userCategoriesAppService = CustomerCategoryAppService();
        final categories = await userCategoriesAppService.getCategories(0,
            maxResultCount: 1000,
            isAutoErrorMessage: false,
            isAutoLoader: false);
        categoryMap.addAll({for (var e in categories.items) e.id: e.name});
        setState(() {});
      }
    });

    _pagingController.addPageRequestListener((pageKey) {
      _appService
          .getCustomers(pageKey, _inputViewModel, groupKey: groupKey)
          .then((data) {
        final nextPageKey = pageKey + data.items.length;
        if (nextPageKey >= data.totalCount) {
          _pagingController.appendLastPage(data.items);
        } else {
          _pagingController.appendPage(data.items, nextPageKey);
        }
      }).catchError((error) {
        _pagingController.error = error;
      }).whenComplete(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    // _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scaffoldKey: _scaffoldKey,
      currentPageName: CurrentPageNameEnum.customerScreen,
      pageTitle: SharedLocalization.getLocalization!().selectClient,
      searchHintText: SharedLocalization.getLocalization!().searchAgent,
      onFilterFunction: _onFilterData,
      isFilteringListener: isFiltering,
      onSearchFunction: (query) async {
        _appService.cancel();
        await Future.delayed(const Duration(milliseconds: 100));
        _inputViewModel.filterText = query;
        _pagingController.refresh();
      },
      withDrawer: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (SettingsAppService.isGroupMode) ...[
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categoryMap.entries.map((group) {
                          return GestureDetector(
                              onTap: () async {
                                _appService.cancel();
                                await Future.delayed(
                                    const Duration(milliseconds: 100));
                                setState(() {
                                  groupKey = group.key;
                                });
                                _pagingController.refresh();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                margin:
                                const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(35)),
                                    color: group.key == groupKey
                                        ? AppTheme.accentColor
                                        : AppTheme.whiteColor),
                                child: Text(
                                  group.value,
                                  style: TextStyle(
                                      color: group.key == groupKey
                                          ? AppTheme.whiteColor
                                          : AppTheme.accentColor),
                                ),
                              ));
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
            Expanded(
              child: PagedListView<int, CustomerNavigatorItemOutputModel>(
                pagingController: _pagingController,
                builderDelegate:
                PagedChildBuilderDelegate<CustomerNavigatorItemOutputModel>(
                  animateTransitions: true,
                  firstPageErrorIndicatorBuilder: (_) =>
                      FirstPageErrorIndicatorWidget(
                        error: _pagingController.error,
                        onTryAgain: () {
                          _pagingController.refresh();
                        },
                      ),
                  newPageErrorIndicatorBuilder: (_) =>
                      NewPageErrorIndicatorWidget(
                        onTryAgain: () {
                          _pagingController.retryLastFailedRequest();
                        },
                      ),
                  noItemsFoundIndicatorBuilder: (_) =>
                  const NoItemsFoundIndicatorWidget(),
                  itemBuilder: (_, item, index) => GestureDetector(
                    onTap: () async {
                      if (!SharedAppService.myRoles.manageCustomerProfile) {
                        return;
                      }
                      Navigator.pop(context,item.customer);
                      // final customer =
                      // await _appService.getCustomerById(item.customer.id);
                      // if (!context.mounted) return;
                      // var isRefreshData =
                      // await Navigator.of(context).push(CustomPageRoute(
                      //     builder: (ctx) => AddCustomerScreen(
                      //       canOpenInvoice: true,
                      //       customerViewModel: customer,
                      //     )));
                      // if (isRefreshData != null &&
                      //     isRefreshData is CustomerViewModel) {
                      //   _pagingController.refresh();
                      // }
                    },
                    child: PrimaryContainer(
                      child: ListTile(
                        leading: Column(
                          children: [
                            Stack(
                              children: [
                                Icon(
                                  SharedIcons.customerIcon,
                                  size: 40,
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: item.customer.isVerified != null
                                        ? CustomerStatusWidget(
                                        withOpacity: false,
                                        borderRaduis: 100,
                                        padding: 0,
                                        isVerified:
                                        item.customer.isVerified!)
                                        : Container())
                              ],
                            ),
                          ],
                        ),
                        title: Wrap(
                          children: [
                            Text(item.customer.displayName),
                            if (item.customer.customerPhone?.trim() != '')
                              Text(item.customer.customerPhone!),
                          ],
                        ),
                        trailing: Column(
                          children: [
                            Text(
                              item.customer.isTajer
                                  ? SharedLocalization
                                  .getLocalization!().agentAsCompany
                                  : SharedLocalization
                                  .getLocalization!().agentAsPerson,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.secondaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            if (SharedAppService.myRoles.canViewCustomerBalance)
                              Text(InputFormatterService.getFormattedCurrency(
                                  item.customer.totalbalanceValue ?? 0))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),

    );
  }
}
