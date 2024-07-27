# myQuilt

## Overview

myQuilt is an AI powered journaling app
I designed and implemented, which leverages the OpenAI API for text and image generation. The app uses the power of AI to create a visual record of the user's mood by crating a color and pattern representation of the users' input. The result is a quilt: a grid of blocks, each with a pattern and color based off of the journal entries of the user. At a glance the user is provided with a visual memory of their emotions, and has the option to select any square to reread their own entry.

## Setup

To run this project, you will need to supply an openai API key.

1. Open the apikey.xcconfig file at the root of the project
1. Replace the placeholder text with your api key, making sure to enclose the value with quotes.
1. Save the file
1. Build and run the project.

## Notes

- The `.xcconfig` file is set to be ignored by git and will not be committed


## Running the app on your device 

-To run this app on your phone, first pair the device with Xcode, instructions here:
https://developer.apple.com/documentation/xcode/running-your-app-in-simulator-or-on-a-device

-then go to product -> destination -> select your device from the menu,
-then you can build and run the app from your device
