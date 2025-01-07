## Upcoming

- Introduced `PagingWidgetBuilder` an abstract paging builder that can be used to build custom paging widgets such as Grid, List, or any other custom paging widget.
- Added `ItemPositionsNotifier` for tracking item positions in scrollable lists.

## 0.2.0

- [[#11]](https://github.com/xsahil03x/super_paging/issues/11) Fix generating prepend load trigger notification when `prefetchIndex` is bigger than the items visible on the screen.
- [[#7](https://github.com/xsahil03x/super_paging/issues/7)] Fix generating load trigger notification when `itemCount` is less than `prefetchIndex`.
- Added support for the `Pager.refresh` method to accept an optional `refreshKey` parameter.

## 0.1.0

- Initial Release.