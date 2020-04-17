# ecommerce-mvvm
Ecommerce App using MVVM Architechture.

# Installations : 
  - Clone or download this project
  - Open ```.xcworkspace``` file
  - If you need to refresh Pod file Go to project directory, then run ```pod install``` from your terminal
  - 3rd Party : RxSwift, Alamofire, Alamofire Image, Realm, FBSDKLoginKit, GoogleSignIn, SwiftyJSON
  
# Requirements : 
  - Xcode 11.3+
  - IOS 13.0+
  - Swift 5.0
  - Pod
  
# Features 
1. Login : 
      - By Email Address & Password, By Facebook & By Google
      - Sign in button will be disabled until valid email & password are inputed. 
2. Home
      - Load list category and item promo, pull list to refresh
3. Search Page
      - Search page from static data (local json)
4. Detail Page
      - Detail of Item, buy item from this page
5. Purchased Item
      - Purchased item will be shown here
6. Unit Test
7. UI Test
8. Clean Code, No error, No Warning.

# Asumptions
1. Static data at Search Page is loaded from json file
2. At First load, search page will show blank page, will show item after filling search bar.
3. Search page will show all item after done searching and field is left blank. 
4. Facebook App ID maybe disabled by Facebook since App is not completely configured (no url policy) at Facebook Developer Page. 
5. UI Test covered one complete transaction include : Login -> Home -> Detail Item -> Back Home -> Search Page -> Detail Page -> Buy -> Purchased Page. 

# Note
Some Screenshots provided at Screenshots folder. 

# Contact 
Ask me : adiwibowoplus@gmail.com
