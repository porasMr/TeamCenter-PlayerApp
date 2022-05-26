import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppImages.dart';
import 'package:team_center/utils/AppTextSize.dart';

import '../../calendar_event.dart';
import '../../controllers/calendar_state_controller.dart';
import '../../controllers/cell_height_controller.dart';

/// Numbers to return accurate events in the cell.
const dayLabelContentHeight = 16;
const dayLabelVerticalMargin = 4;
const _dayLabelHeight = dayLabelContentHeight + (dayLabelVerticalMargin * 2);

const _eventLabelContentHeight = 13;
const _eventLabelBottomMargin = 3;
const _eventLabelHeight = _eventLabelContentHeight + _eventLabelBottomMargin;

/// Get events to be shown from [CalendarStateController]
///
/// Shows accurate number of [_EventLabel] by the height of the parent cell
/// notified from [CellHeightController]
class ViewLables extends StatelessWidget {
  ViewLables(this.date);

  final DateTime date;

  List<CalendarEvent> _eventsOnTheDay(
      DateTime date, List<CalendarEvent> events) {
    final res = events
        .where((event) =>
            event.eventDate.year == date.year &&
            event.eventDate.month == date.month &&
            event.eventDate.day == date.day)
        .toList();
    return res;
  }

  bool _hasEnoughSpace(double cellHeight, int eventsLength) {
    final eventsTotalHeight = _eventLabelHeight * eventsLength;
    final spaceForEvents = cellHeight - _dayLabelHeight;
    return spaceForEvents > eventsTotalHeight;
  }

  int _maxIndex(double cellHeight, int eventsLength) {
    final spaceForEvents = cellHeight - _dayLabelHeight;
    const indexing = 1;
    const indexForPlot = 1;
    return spaceForEvents ~/ _eventLabelHeight - (indexing + indexForPlot);
  }

  @override
  Widget build(BuildContext context) {
    final cellHeight = Provider.of<CellHeightController>(context).cellHeight;
    return Selector<CalendarStateController, List<CalendarEvent>>(
      builder: (context, events, _) {
        if (cellHeight == null) {
          return const SizedBox.shrink();
        }
        final eventsOnTheDay = _eventsOnTheDay(date, events);
        final hasEnoughSpace =
            _hasEnoughSpace(cellHeight, eventsOnTheDay.length);
        final maxIndex = _maxIndex(cellHeight, eventsOnTheDay.length);
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: eventsOnTheDay.length,
          itemBuilder: (context, index) {
            if (maxIndex > 0) {
              return Stack(
                children: [
                  Container(
                    height: cellHeight - 32,
                    alignment: Alignment.topCenter,
                    margin:
                        EdgeInsets.only(top: 4, bottom: 4, left: 2, right: 2),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: eventsOnTheDay[index].eventBackgroundColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            width: double.infinity,
                            child: AppTextSize.textSize10(
                                eventsOnTheDay[index].eventName,
                                Colors.white,
                                FontWeight.normal,
                                "rubikregular",
                                2),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.only(left: 3, right: 3),
                          child: AppTextSize.textSize8(
                              eventsOnTheDay[index].time,
                              Colors.black,
                              FontWeight.normal,
                              "rubikregular",
                              1),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              eventsOnTheDay[index].gameType == "Cup"
                                  ? Image.asset(
                                      AppImages.cup,
                                      width: 12,
                                      height: 12,
                                    )
                                  : eventsOnTheDay[index].gameType == "Friendly"
                                      ? Image.asset(
                                          AppImages.friendlyIcon,
                                          width: 12,
                                          height: 12,
                                        )
                                      : Image.asset(
                                          AppImages.leaguIcon,
                                          width: 12,
                                          height: 12,
                                        ),
                              eventsOnTheDay[index].keyGame == "true"
                                  ? Icon(
                                      Icons.star,
                                      size: 15,
                                      color: Colors.amber,
                                    )
                                  : Container(),
                              Image.asset(
                                eventsOnTheDay[index].gamePlace == "home game"
                                    ? AppImages.home
                                    : AppImages.awayIcon,
                                width: 12,
                                height: 12,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  eventsOnTheDay[index].clubComment == false
                      ? Container()
                      : Container(
                          alignment: Alignment.topRight,
                          height: cellHeight - 32,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.defaultAppColor[500]),
                          ),
                        ),
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          },
        );
      },
      selector: (context, controller) => controller.events,
    );
  }
}
