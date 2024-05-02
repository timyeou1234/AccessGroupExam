# Github user app (Access Group Exam)

## Total working hours: 12.5 hours
- Pre-project planning: 0.5h
- Create repo and package import: 0.5h
- First version with MVC: 3h
- MVVM restructure: 4h
- Detail page implementation: 3h
- Documentation: 1.5h

### App Explanation
#### Structure
##### Entry
The entry point is outside of the scope, thus using default entry with a storyboard with default delegate.
##### Files
There are three files that contains User List, Model, and API Client. The ideal way will be to separate them into different packages.
###### User List
In this file, there are user list main page and user detail page. The UI nib file is grouped by the features since there are only two features there.
###### Modle
This file contains a struct model file.
###### API Client
This file contains API-related files.

### Tech stack
#### Libraries
Third-party libaries listed below:

- Alamofire (latest release), this is to speed up the API decode process.
- KingFisher (latest release), this is to optimize the image downloading process.


Native libraries:

- Combine: This is to use the MVVM structure

#### MVVM pattern
In this app, for a quicker approach and to keep it simple, I didn't choose to use rxSwift but native combine instead. Combine in general is easier to understand while the function is natively supported. In ViewModel, I choose to let ViewModel hold on to the publisher instead of using a transform input-output pattern for better readability. 
