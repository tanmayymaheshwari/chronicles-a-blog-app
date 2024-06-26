# Theme

--Multiple uses throughout the app
--Define global colors
--Define scaffold and appbar theme
--UI can be made as a function which takes a parameter (Ex: Enabled and Focused Borders)

# SignUp

--Controllers for text fields
--FormKey must be defined
--RichText to display different type of texts in the same line
--'gradient' present in Container

# Login

--First page that loads
--Same as Signup
--Static route navigator

# AuthField

--HintText, ObscureText
--Controller, Validator

# Supabase

--Project URL and Key in Secret Folder
--Initialize in void main() with binding

# AuthRepo in Domain

--Skeleton Interface with functions like signup(), login()
--Domain and Data Layers must never mix up

# Auth in Database

--Interface with above functions
--Class which implements the functions
--Example on SignUp, it returns UserID from database

# AuthRepo Implementation in DataLayer

--Implements from Domain but extracts data from Database

# UseCase

--Defined globally in Core folder
--Each UseCase dart file must only return 1 UseCase

# Bloc

--Set up Events and States
--response.fold() to emit() states
--Data like userSignUp must be made private

# SignUp

--onPressed: formKey validation -> AuthSignup Event -> _userSignUp usecase -> AuthRepoImpl -> AuthSupabaseImpl
--Implementation is called because we cannot instantiate abstract class
--In case we switch databases, the Interface allows us to simply code another class giving us the required functions and parameters
--If we had directly connected to the database with a class, we would have to rewrite the entire code

# Dependency Injection

--Bloc has not yet been connected to the app
--MyApp will be wrapped in MultiBlocProvider
--To prevent cluttering in main.dart, due to importing all classes when calling a Bloc
--Package called GetIt is used which has serviceLocator()
--Initialize database with Future and create separate function for each Bloc
--serviceLoactor() acts like a dictionary for all dependencies

# Supabase & PostGreSQL

--To link data from Authentication to Database, we use PostGres
--Automatic available but manual connection is preferred
--Use documentation to get SQL code

# Entity & Model

--User entity and model created and replaced throughout with String success
--Entity is in Domain and Model is in Data Layer
--Entity defines the business logic (real life representation of the object)
--Model is used to handle the entity's data being fetched from APIs

# Snackbar & Loader

--Added in 'core' since it will be used globally

# Login

--Implement in Data Layer in AuthSupabaseDatasourceImpl
--Implement in AuthRepoImpl
--Implement in Usecase
--Implement in Auth_Bloc & Auth_State
--Inject in dependency

















 
