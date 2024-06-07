# Moon App

## Overview

Moon App is a SwiftUI-based iOS application designed to manage client information, including the ability to attach images to client profiles. The app uses GraphQL for data fetching and mutation, supports image capture from the camera and photo library, and stores client images locally on the device.

## Features

- List and search clients.
- View detailed client information.
- Edit client details, including attaching an image from the camera or photo library.
- Delete clients.
- Persist authentication across app restarts.
- Store client images locally on the device.

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.0+

## Installation

1. Clone the repository:

```bash
git clone https://github.com/yourusername/moon-app.git
cd moon-app
```

2. Open the project in Xcode:

```bash
open MoonApp.xcodeproj
```

3. Build and run the project on a simulator or device.

## Usage

### Authentication

1. On first launch, you will be prompted to log in.
2. Enter your username and password.
3. The app will keep you logged in for 30 seconds after closing, using local storage to remember your session.

### Managing Clients

1. **View Clients**: The main screen displays a list of clients.
   - Use the search bar to filter clients by name.
   - Pull down to refresh the client list.

2. **Add Client**: Tap the `+` button to add a new client.
   - Fill in the client details and save.

3. **Edit Client**: Tap on a client in the list to view their details.
   - Tap the `Edit` button to modify client information.
   - You can capture a new image using the camera or select one from the photo library.
   - Save changes to update the client's information.

4. **Delete Client**: Tap the `Delete` button in the client's detail view to remove the client.
   - Confirm the deletion in the alert prompt.

### Storing Images

- Client images are stored locally on the device in the app's document directory.
- Images are saved as `[clientName].png`.

## Code Structure

- `MoonApp.swift`: Entry point of the application. Manages authentication and state persistence.
- `ClientsView.swift`: Displays the list of clients and handles searching and refreshing.
- `ClientView.swift`: Shows detailed information about a client, including their image.
- `EditClientView.swift`: Provides a form to edit client details and attach an image.
- `ImagePicker.swift`: Custom SwiftUI view to handle image picking from the camera or photo library.
- `Client.swift`: Data model for client information.

## Local Image Storage

### Save Image

```swift
func saveImage(image: UIImage, fileName: String) -> Bool {
    guard let data = image.pngData() else { return false }
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let fileURL = paths[0].appendingPathComponent(fileName)
    
    do {
        try data.write(to: fileURL)
        return true
    } catch {
        print("Unable to save image to local storage:", error)
        return false
    }
}
```

### Load Image

```swift
func loadImage(fileName: String) -> UIImage? {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let fileURL = paths[0].appendingPathComponent(fileName)
    
    if FileManager.default.fileExists(atPath: fileURL.path) {
        return UIImage(contentsOfFile: fileURL.path)
    }
    return nil
}
```
## Acknowledgements

- This app uses SwiftUI and UIKit for building the user interface.
- The image picker functionality is wrapped using `UIViewControllerRepresentable`.
