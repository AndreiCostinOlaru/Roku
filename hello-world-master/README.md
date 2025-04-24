# Channel application for Roku

## Use Case

This project is a Roku sample app designed as a base for experimenting with Scene Graph architecture and BrightScript features. 

## How to Run This Sample
* Zip the contents of the main file of this project and deploy to your roku device. Follow the developer set-up guide here for a quick guide on how to do so: https://developer.roku.com/en-ca/docs/developer-program/getting-started/developer-setup.md

## Features
* The main screen contains a layout group that contains a RowList and two buttons.
* Switching focus from the RowList to the buttons will trigger animations.
* The RowList has a timer-based animation.
* Uses tasks to make get requests and populate content nodes (RowList, Video, MarkupGrid).
* Selecting a RowListItem triggers the navigation to a DetailsScreen that is populated based on the item selected.
* Selecting the "ok" button triggers the navigation to a VideoScreen that displays a video player.
* Selecting the "To MarkupGrid screen" button triggers the navigation to a MarkupGridScreen that contains a markupGrid populated using the backend data.
* Implements deep-linking.

## Directory Structure
* Components: The Scene Graph components
    * DescriptionScreen: Screen that contains details about selected item in RowList
    * GetPokemonDataTask: Task that makes get request to retrieve pokemon data that will populate the RowList and MarkupGrid
    * GetVideoDataTask: Task that makes get request to retrieve video data for the video player in VideoScreen
    * Helpers: Contains helper function for timers and animations
    * MainScreen
    * MarkupGridItem: Defintion for the items in the MarkupGrid
    * MarkupGridScreen: Screen that contains a MarkupGrid
    * RowLisItem: Defintion for the items in the RowList
    * VideoScreen: Screen that contains the video player
*Images: Contains image assets used in the channel
*Source: Contains the main brightscript file that runs right when the channel starts

## Channel Flow
This section explains what happens when the channel/app does and what the user sees as a result.
Channel Launch: Initiates multiple URL requests to fetch content RowList, Video and MarkupGrid.
UI Update: Once all content is fetched and parsed, updates the UI with the content.
User Navigation: 
* Users can navigate through the RowList and select content. Upon selection, displays a details screen with content information.​
* Users can navigate from RowList to buttons and select them. Upon selecting the "ok" display a video screen. Upon selecting the "To MarkupGrid screen" display a markupGrid screen.
* In video screen users can play a video.
* In MarkupGrid screen users can navigate through the MarkupGrid items.

## Packages
This project uses bslint to enforce BrightScript code style and maintain clean, readable code. When cloning the project use **npm install**.

