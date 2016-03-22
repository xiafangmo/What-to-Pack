


**Installation**

To run the app, you might need to

- Download Cocoapods if you have not already installed it.
- Open Teminal and go to the root folder of the project, and run "pod install"
- wait till the installataion finishes, and then open "What to Pack.xcodeproj"


**API keys**

The app users Google Maps API and Open Weather API. The keys are not stored in the code, for securities concerns. 

- Google Maps API goes to AppDelegate
- Open Weather API goes to OpenWeatherConstant 

Please add the keys before you review


**Flow of the App**

"What to Pack" is an app generates a packing list based on travel type and the number of travelers (the latter has been implemented yet).

Users are asked to type in the destination. Google Maps AutoComplete helps them locate it fast. Users then choose among four travel types: Business, Vacation, Adventure and Beach, and three trave styles: Solo, Couple and Family. The default values are Business and Solo.

Users are required to fill in how many days they are traveling. And after that, the "What to Pack" button will display, and it leads users to a page where the weather forecast (up to 16 days) is provided. OpenWeatherAPI is implemented for this purpose. On this page, the lower bottom is the universal list, with some extra items specifically for a certain travel type.

Users could press "Check the Full List", or "redo the list". The former button leads to a page with all items listed without sections, the latter one leads to the first view.

On the view with the title "Edit Your List", users could swipe to delete. (And add items of their own (not implemented yet).) After editing, users save the list, and the view jumps back to the first view.

Users could press the blue envelope button on the right bottom, to check the list of lists saved. A list of saved lists are sorted in the order of destinations. Each destination row leads to its list, and users could update when it's packed (not implemented yet).


**Notes**

The development of the app is still ongoing. There are some features I would like to add, and some changes I would like to made.

