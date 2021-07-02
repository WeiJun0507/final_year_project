# final_year_project

Final Year Project Using Flutter.

### Getting Started

## 1) Define the Login and Register UI/UX:
    - Including forgot password,
    - sign in button,
    - navigation redirect

## 2) Create a Firebase Auth Service Class:
    a) Allow for Register using Email and Password
    b) Allow for Register using Google
    c) Forgot password reset function
    d) Auto generate extra properties for particular user => Should create Database service for this service
        i) Field could be: loyalty rewards, loyalty points accumulated, reservationID => Inherit Order details collection

## 3) Create Home page with different route:
    a) To Menu page: Browsing Menu
    b) To TableDetails page: can attempt the reservation
    c) To Order Details / Reservation Details
    d) Go to loyalty page to browse all the loyalty rewards available

## 4) Provide Auth check in all the Homepage and respective functionality
Reminder: 
    1) To use Firebase service: must initialize in the main function so that the class can use it.
    2) Using a provider package to make the currentUser Profile available in the whole app so that
       can redirect the user to the correct place.
    3) Update from Firebase: 
        i) FirebaseUser => User
        ii) AuthResult => UserCredential
        iii) Do not create User custom model, which will confused with
             FirebaseUser type.
    4) Provider Reminder: !!!
        i) Every provider wrapper must specified the type so that clearly define
           what type of the data it will receive.
        ii) In the class that uses the provider to receive data, If the provider do not specified
            the type of data receive. It could not found which one is going to receive and cannot
            perform the action. Will show error like could not find the provider.

## 5) Create Menu page: In ListView / FutureBuilder/ StreamBuilder
    5.1) Identify Menu method

## 6) Create Table Details and complete the reservation function

## 7) Create order details by querying the data from firebase

## 8) Loyalty Program:

#Project Ongoing Process:

15/5/2021: Create all necessary Model

16/5/2021: Create Sign In, Register, Forgot Password page

17/5/2021: Testing SignIn,Register,Forgot Password firebase method.

18/5/2021 - 19/5/2021 : Testing/ Debugging SignIn,Register,Forgot Password firebase method.
    ===== To detect the error occur during the method invoking
    ===== Throw the error in FirebaseAuthException and catch it in the view screen page.
    ===== The error threw is in e.code and e.message format, code is the error code
    ===== message is the error message, using ScaffoldMessenger.showSnackBar show the error message.
    ===== The LoginPage which render the login form can directly access the Scaffold context even in different class

19/5/2021 : 
-   Creating Database Reference
-   creating User model when the user register to the page.

20/5/2021 : 
-   Creating Profile Page
    1) Settings => Change Username, Email, Password
    2) About Page
    3) Log Out
-   Carousel Slider and Slider Detail Page, 
-   Debugging Login,Register,Forgot Password Function
-   Change Log out function to Profile Page

21/5/2021 : 
-   Modify, Update Profile Settings Function.

# Reminder:

To update the page when second page pop
   - Override DidUpdateDependencies
   - Receive the result from the Navigator
   - if (receive result is not null): setState and update the Page
   
22/5/2021 :
- Create Menu Page, Menu List Page, Menu Details Page
- Generate Idea for database methods.

###Todo : Understand how to use StreamBuilder and FutureBuilder, Decide using which to display the data

#Reminder :
    ## Remember to generate method for admin
    A validating method to identify admin user to allow them conduct : 
        1) Edit, Update, Delete database item (FoodMenuCategory, FoodMenuList, FoodMenuDetailItem)
        2) Edit, Update, Delete Carousel Item
        3) Todo: 23/5/2021 Add Menu Category
           - Create an action on top right of the appBar
           - pop out a modal or navigate to a new page
           - form allows admin to add category
           - onSaved: create records in database, update the MenuPageView
           - Dismissible Widget: Delete the record in the database
           - Edit: on Click edit: Navigate to a new page same as the form to create category
        
#Problem Encountered:
    - Still cannot use Provider Package fluently
    - Still cannot fully understand all the Provider Function
    - Weak in understanding Future async await, and combination of asynchronous and Future

23/5/2021 :
- Create Method for add,edit,get,delete Menu Category and Food item into the database (Without testing)
- Query of how to use FutureBuilder and StreamBuilder.

25/5/2021:
- Convert the display menu list to Future Builder
- add Add button, Edit and delete button to allow admin do modification.
- Develop Edit function, delete function and use.

#Problem Encountered:
could not get firebase storage image through code
    :Possibility wrong in path name
User have to press twice in order to add, edit the menu, food item.
    :Asynchronous method interrupted.

26/5/2021:
- Complete Food Menu Detail Page design
- Planning for Loyalty Program design layout

27/5/2021:
- Set constraint to only admin can add,edit,delete the menu item and food item.
- Generate Loyalty Promotion dashboard
- Generate Loyalty Promotion Detail page.
- Set up task to implement Database method to 
    1) Add Promotion
    2) Delete Promotion
    3) Edit Promotion
    
Problem solved:
- Async Interruption for submitting image to fireStore

30/5/2021:
- Complete Admin and Customer Loyalty Page
- Planning about Editing loyalty promotion page
- Planning about Loyalty Promotion onTap detail page

2/6/2021:
- Construct Reservation layout
- Organize database file/code structure
- Construct database solving method

6/6/2021:
- Construct reservation layout
    1) TableView,
    2) Time Selection View
    
8/9/2021:
- Adjust Reservation database and business logic
- Modify reservation flow
- creating add menu function to the list in provider
- Create Provider to store reservation, store menu details

10/9/2021: 
- Create Checkout Cart page
- Create Order model
- Create function to get all the details
- Modify database method 