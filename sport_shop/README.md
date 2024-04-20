## Sport Shop App

Welcome to the Sports Shop App — your one-stop mobile destination for all your sporting goods needs. This innovative and user-friendly application is designed to provide sports enthusiasts with a comprehensive shopping experience. Whether you're a seasoned athlete or a recreational player, our app caters to all your sports equipment and apparel needs with ease and efficiency

Custom Widget and UI Design:
•  The app customizes various Flutter widgets such as AppBar, ListView, BottomNavigationBar, and more to create a user-friendly interface tailored to the needs of sports enthusiasts.
It uses custom themes to maintain consistency in the visual design across different screens and components of the app. The theme data includes specific colors, font styles, and other UI properties centralized within the ThemeData object.

Cart Management:
•  The CartProvider class, derived from ChangeNotifier, manages the shopping cart's state. It provides methods to add and remove products, and it notifies listening widgets of changes using notifyListeners(), ensuring the cart’s UI is updated in real-time as items are added or removed.

Navigation and Routing:
•  Navigation between different screens is managed using the Navigator for pushing and popping routes. This includes transitions from product lists to detailed pages, and managing cart interactions.
The app uses MaterialPageRoute for route transitions, which adheres to the material design principles.
