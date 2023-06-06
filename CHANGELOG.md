# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog],
and this project adheres to [Semantic Versioning].

## [Unreleased]

### For Users

#### Changed

 - Fixed bugs for links.

### For Developers

#### Changed

 - Station location links now use Google Maps.
 - About page links now use external apps.

## [0.1.5] - 06.06.2023

### For Users

#### Changed

 - Now the default day automatically switches to current day.
 - Now the list of hours scrolls to the next hour automatically on the current day.

### For Devs

#### Added

 - Added `Day DateTime.dayValue` with `DateTimeDayExtension`

#### Changed

 - Separated `getEndStations` to `StationProvider` and `StationRepository`
 - Renamed and refactored `Days` enum to `Day`
 - Renamed `DaysExtension` to `DayExtension`
 - Changed `ListView` to `ScrollablePositionedList` in `SchedulesListComponent`

## [0.1.4] - 02.06.2023

### For Users

#### Changed

 - Home page now shows icon instead of title
 - Station menus seem and behave better now

### For Devs

#### Added

 - Added about page

## [0.1.3] - 25.05.2023

### For Users

#### Changed

 - Better day selection

### For Developers

#### Changed

 - Changed days menu from dropdown to chips

## [0.1.2] - 25.05.2023

### For Users

#### Added

 - Location button around station dropdowns

#### Changed

 - Better dropdown

### For Developers

#### Changed

 - Refactor to `Station.backgroundAssetPath`
 - Use better `DropdownButton2`

## [0.1.1] - 24.05.2023

### Added

 - Now the app supports landscape layout.
