# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog],
and this project adheres to [Semantic Versioning].

## [0.3.1] - 2023-06-14

### Fixed

 - Fix Admob crash

## [0.3.0] - 2023-06-14

From this release and onwards, the CHANGELOG will only contain the changes for users, not the developers. Potentional contributors can check the commit history in order to get some ideas about the history of the project.

### Added

 - Banner ads to bottom
 - **Favorite system**: Now, users can add their favorite stations to favorites so that they can pick them easily from home page.

### Changed

 - Overall UI has changed to incorporate with new features.

## [0.2.1] - 2023-06-09

### For Users

#### Changed

 - The connection is faster now.

### For Developers

### Added

 - Cache for HTTP requests

## [0.2.0] - 2023-06-07

### For Users

#### Changed

 - Fixed bugs for links.
 - Changed UI from zero

### For Developers

#### Changed

 - Station location links now use Google Maps.
 - About page links now use external apps.

## [0.1.5] - 2023-06-06

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

## [0.1.4] - 2023-06-02

### For Users

#### Changed

 - Home page now shows icon instead of title
 - Station menus seem and behave better now

### For Devs

#### Added

 - Added about page

## [0.1.3] - 2023-05-25

### For Users

#### Changed

 - Better day selection

### For Developers

#### Changed

 - Changed days menu from dropdown to chips

## [0.1.2] - 2023-05-25

### For Users

#### Added

 - Location button around station dropdowns

#### Changed

 - Better dropdown

### For Developers

#### Changed

 - Refactor to `Station.backgroundAssetPath`
 - Use better `DropdownButton2`

## [0.1.1] - 2023-05-24

### Added

 - Now the app supports landscape layout.
