# myQuilt

## Overview

myQuilt, an AI powered journaling app
I designed and implemented a journaling app, which leverages the OpenAI API for text and image generation. The app uses the power of AI to create a visual record of the user's mood by crating a color and pattern representation of the users' input. The result is a quilt: a grid of blocks, each with a pattern and color based off of the journal entries of the user. At a glance the user is provided with a visual memory of their emotions, and has the option to select any square to reread their own entry.

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


## Running the app on your device 

-To run this app on your phone, first pair the device with Xcode, instructions here:
https://developer.apple.com/documentation/xcode/running-your-app-in-simulator-or-on-a-device

-then go to product -> destination -> select your device from the menu,
-then you can build and run the app from your device
