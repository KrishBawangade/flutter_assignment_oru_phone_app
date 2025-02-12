# flutter_assignment_oru_phone_app

Flutter-based mobile application. The app implements authentication, product listings with pagination, and a modular UI architecture.  

---

## 📌 Features  

### 🚀 Splash Screen  
- Checks if the user is authenticated and persists authentication state.  
- Navigates to:  
  - **Home Screen** (if authenticated).  
  - **Confirm Name Screen** (if the user hasn't set their name).  

### 🔐 Authentication  
- **Login OTP Screen**: Users enter a phone number to receive an OTP.  
- **Verify OTP Screen**: Users enter OTP to authenticate.  
  - If a new user, they are redirected to the **Confirm Name Screen**.  
- **Confirm Name Screen**: New users must enter a name before proceeding.  

### 🏠 Home Screen  
- **Scrolling Behavior**: Matches the expected app flow.  
- **Product Listings**:  
  - Supports pagination with a loading indicator.  
  - Displays liked listings with red heart icons.  
- **Cyclic Dummy Product Cards**: After every 7th product, a set of dummy cards appears.  

---

## 🏗 State Management  
The assignment uses **Provider** for state management.  

---

## 📂 Project Structure  
The project follows **a modular structure** with separate folders for:  
- **providers/** - Manages state and business logic.  
- **pages/** - Contains different screens of the app.  
- **services/** - Handles API calls and business logic.  
- **assets/** - Stores static files like images.  
- **utils/** - Utility functions and constants.  
- **widgets/** - Reusable UI components.  

---

## 🚀 Getting Started  

### Prerequisites  
- Flutter SDK installed ([Download here](https://flutter.dev/docs/get-started/install))  
- Android Studio / VS Code with Flutter plugin  
- Firebase setup (for authentication)  

### Installation & Setup  

1. **Clone the repository**  
   ```sh  
   git clone https://github.com/your-repo/oruphones-assignment.git  
   cd oruphones-assignment

2. Install dependencies

flutter pub get


3. Configure Firebase

Add google-services.json (for Android) and GoogleService-Info.plist (for iOS).



4. Run the app

flutter run

---

🛠 Technologies Used

Flutter

Firebase

Provider (State Management)





Contact- 
    Email: krishbawangade08@gmail.com
