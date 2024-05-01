#Github user app (Access Group Exam)

### App Explanation
#### Structure
##### Entry
The entry point is outside of the scope, thus using default entry with storyboard with default delegate.
##### Files
There are three files that contains User List, Model and API Client. The ideal way will be separate them to different package.
###### User List
In this file, there are user list main page and user detail page. The UI nib file is grouped by the features since there are only two features there.
###### Modle
This file contains struct model file.
###### API Client
THis file contains Api related file.

### Tech stack
#### Libaries
Third party libaries listed below:

- Alamofire (latest release), this is to speed up the API decode process.
- KingFisher (latest release), this is to optimize the image downloading process.


Native libraies:

- Combine: This is to use the MVVM structure

#### MVVM pattern
In this app, for a quicker approach and for keep it simple, I didn't choose to use rxSwift. In ViewModel, I choose to let ViewModel hold on the publisher instead of using transform input output pattern for better readbility. 