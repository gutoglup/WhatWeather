# WhatWeather

## Structure

For this project was used MVVM with Clean Architecture, using Data Source, Repository, Use Cases, and ViewModel layers. It used SwiftUI to construct all views layers and components because view code is cleaner and faster than Storyboards and Xibs, specifically regarding the size of an XML file, and dependency injection.

## Mindset building

To construct all layers, I preferred to create all directories first. After, I write the domain layer, based on the onion reference, like the smallest and independent layer. Then I mapped all structs and wrote the data source layer, I used a strategy design pattern to do the Dependency Inversion based on SOLID principles. The data source, repository, and use cases have two files, one for protocol and one for implementation because it permits changes in implementation without changing the contract established. The data source has the responsibility to prepare the request using the router (pattern suggested by the Moya framework), and after response, it decodes the JSON to the WeatherData object.
Then I wrote the repository layer, it's an orchestration of data sources because we can call cached weather data, or from the server-side, or another database (local or remote).
The use case has the responsibility to prepare data and trait the negotiate rules, for this application I thought don't have any negotiate rules to send or was received.
Next, I wrote the view model layer with view together, to visualize the screen and link the objects and publishers. In the last part, I traited the error handling to show on the screen, and empty states. For this step, I tried to create visual components that permit future reusability.
After all, I wrote the unit tests, to guarantee expected results about the code and future maintenance.

## Setup

For this project was used SPM (Swift Package Manager) to dependency manager, and the following frameworks:
Moya+Combine (to use the route network pattern established by Moya).
Swinject (that permits the use of the dependency injection).
To build this application, only open the `WhatWeather.xcproject` and wait for SPM to download all dependencies, then run the application (Cmd+R).

## Roadmap

- [ ] Create view model tests.
- [x] Implement download weather icon and consult the database or fetch on remote.
- [ ] Cache the weather request based on specific timeout.
- [x] Create files to store mocks like JSON for stubs. (It was used fixture pattern to solve the problem).
- [ ] Localize the application.
- [ ] Improve tests with error cases.
- [x] List daily temperature.
- [x] List hourly temperature.
