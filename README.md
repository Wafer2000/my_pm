# my_pm

A Flutter application for managing and viewing movies using The Movie Database (TMDb) API.

## Description

This project is built with Flutter and follows the principles of Clean Architecture and SOLID design patterns. It allows users to explore movies, check their details, view recommendations, and mark their favorite movies. The app utilizes a modern stack of packages and services to ensure a smooth user experience.

## Features

- View movie details, including title, release date, popularity, and overview.
- Check and manage favorite movies.
- Display recommendations and similar movies based on user preferences.
- Offline support with connectivity checks.
- State management using the BLoC pattern for a reactive UI.

## Getting Started

### Prerequisites

- Flutter SDK installed on your machine. You can find the installation instructions [here](https://flutter.dev/docs/get-started/install).
- An account on [The Movie Database (TMDb)](https://www.themoviedb.org/), and you will need your API key to access movie data.

### Installation

1. Clone the repository:

```bash
git clone https://github.com/Wafer2000/my_pm.git
cd my_pm
```

2. Install dependencies:

```bash
flutter pub get

```

3. Create a `.env` file in the root directory and add your TMDb API key:

```
ACCESS_TOKEN=your_access_token_here
```

4. Run the application:

```
flutter run
```

## Architecture

This application follows Clean Architecture principles, which separates concerns into different layers:

- Presentation Layer: UI components and widgets.
- Domain Layer: Business logic and use cases.
- Data Layer: Data sources and repository implementations.

## API Usage

### API Key Configuration

To use the TMDb API, ensure that you include your API key in the `Authorization` header for requests. For example, when adding a favorite movie:

```
final accessToken = dotenv.env['ACCESS_TOKEN'];
```

### Example Request to Add Favorite Movie

You can use the following example to add a movie to your favorites:

- URL:

  ```
  POST https://api.themoviedb.org/3/account/{account_id}/favorite
  ```

- Headers:

  ```
  Authorization: Bearer 84478c83aa796fcc7786975ad39ee29d
  accept: application/json
  content-type: application/json
  ```

- Body:
  ```
  {
    "media_type": "movie",
    "media_id": 519182,
    "favorite": true
  }
  ```

### Example cURL Command

You can test the above request using `curl`:

```
curl --request POST \
  --url https://api.themoviedb.org/3/account/13349688/favorite \
  --header 'Authorization: Bearer 84478c83aa796fcc7786975ad39ee29d' \
  --header 'accept: application/json' \
  --header 'content-type: application/json' \
  --data '{
    "media_type": "movie",
    "media_id": 519182,
    "favorite": true
  }'
```

### Response

If the request is successful, you should receive a `200 OK` or `201 Created` response.

## Packages Used

- `cached_network_image`: For caching images.
- `connectivity_plus`: To check internet connectivity.
- `flutter_bloc`: For state management.
- `dio`: For making network requests.
- `go_router`: For routing and navigation.
- `shared_preferences`: For storing user preferences.
- `sqflite`: For local database support.

## Resources

For help getting started with Flutter development, view the online documentation, which offers tutorials, samples, guidance on mobile development, and a full API reference.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Special thanks to The Movie Database (TMDb) for providing the movie data API.
- Inspired by best practices in Flutter development and the principles of Clean Architecture.
