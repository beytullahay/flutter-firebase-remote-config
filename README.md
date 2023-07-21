# flutter_remote_config

Using Flutter and Firebase Remote Config, it is a project that prints on the screen if there is a social media link, otherwise it does not show on the screen.

- After integrating Firebase into the project, go to Firebase Console.
- From here, Remote Config opens under Engage.
- With "New Create Group", separate folders are made for social media accounts such as Youtube, Linkedin, Twitter, and order is provided.
- There are 2 parameters under each group. These are the picture link and the social media address.
- In the code, if the link comes with "Remote Config", there is a structure that returns an empty "SizedBox" if there is no printing to the screen.
- If there is a link, the address of the image printed at the bottom of the screen is displayed with the "Snackbar" when the image is clicked.


## Firebase -> Engage --> Remote Config
<img src="https://github.com/beytullahay/flutter_remote_config/assets/81561442/166a0272-bc32-4f69-b7f0-ead99e6ddd51" width='200'> 

## Folder and parameters
<img src="https://github.com/beytullahay/flutter_remote_config/assets/81561442/590f6c58-bb8c-47da-a6b0-ff902b7a3f93" width='1100'> 
<img src="https://github.com/beytullahay/flutter_remote_config/assets/81561442/9ca470cc-7240-4768-bc4d-b3dce9e06adf" width='1100'> 
 
