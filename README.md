
Weather App

This Flutter application integrates with the OpenWeatherMap API to provide real-time weather updates based on the user’s location. The application is designed with a focus on clean architecture principles, ensuring that the codebase remains modular, scalable, and maintainable.

Key features and architectural decisions include:

	•	BLoC Pattern for State Management: The app utilizes the BLoC (Business Logic Component) pattern to manage state efficiently. This pattern separates business logic from UI code, making the application easier to test and maintain.
	•	Dio for Network Requests: Dio is used for making network requests to the OpenWeatherMap API. It provides powerful features such as request cancellation, interception, and error handling, making it a robust choice for managing HTTP requests.
	•	Dependency Injection with get_it: The get_it package is employed for dependency injection. This allows for easy management of dependencies and promotes better code organization. The dependency injection setup includes:
	•	BLoC: Registered as a factory to ensure a new instance is created each time it is needed.
	•	Use Cases: Registered as a lazy singleton to manage the application’s business logic.
	•	Repository and Data Source: Registered as lazy singletons to handle data operations and API interactions.
	•	Dio: Configured with a base timeout for network requests.
	•	Testing with mocktail and bloc_test: Comprehensive testing is integrated into the development process using mocktail and bloc_test. These tools facilitate the creation of mock objects and the testing of BLoC components, ensuring that the application behaves as expected under various conditions.
	•	User Interface Improvements: The app features a user-friendly interface with responsive design elements, such as dynamic weather icon sizes and temperature formatting options. Users can toggle between Fahrenheit and Celsius for temperature display, enhancing the overall user experience.

The clean Archtecture Used in this project looks as follows


```plaintext
lib
├── core
│   ├── constants.dart
│   ├── dependency_injection.dart
│   └── network_exception_handler.dart
├── data
│   ├── data_sources
│   │   └── weather_remote_data_source.dart
│   ├── models
│   │   └── weather_model.dart
│   └── repositories
│       └── weather_repository_impl.dart
├── domain
│   ├── entities
│   │   └── weather.dart
│   ├── repositories
│   │   └── weather_repository.dart
│   └── usecases
│       └── get_weather.dart
├── presentation
│   ├── bloc
│   │   ├── weather_bloc.dart
│   │   ├── weather_event.dart
│   │   └── weather_state.dart
│   └── pages
│       └── weather_page.dart
└── main.dart
```
Features:

	•	Fetch and display current weather data (temperature and location name)
	•	Responsive design with adaptive image aspect ratios
	•	Clean architecture and BLoC for state management

API Endpoint:

	•	[OpenWeatherMap API](https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key})


Design Reference:

	•	Figma Design : https://www.figma.com/design/KwcXnRh3CWDL3SSkq39ZaM/Untitled?node-id=0-1&t=7QUk56oHLD6GbP6w-1
