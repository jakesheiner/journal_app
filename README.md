# myQuilt

## Setup

To run this project, you will need to set up environment variables.

1. Create a `.xcconfig` file in the root directory of the project (or copy from the provided template).
     e.g. 'my_apikey.xcconfig'
3. Add the following content to the `.xcconfig` file:

  API_KEY = your_api_key_here


3. Configure the `.xcconfig` file in Xcode:
- Open your Xcode project.
- Select the project, then select the `info` tab.
- Under 'configurations' set the `Config.xcconfig` file as the base configuration for your desired build configuration (e.g., Debug, Release).

4. Add a new entry in `Info.plist` with the key `API_KEY` and value `$(API_KEY)`.

5. Build and run the project.

## Notes

- Make sure not to commit the `.xcconfig` file containing sensitive information to version control.


##Running the app on your device

To run this app on your phone, first pair the device with Xcode, instructions here:
https://developer.apple.com/documentation/xcode/running-your-app-in-simulator-or-on-a-device

then go to product -> destination -> select your device from the menu,
then you can build and run the app from your device
