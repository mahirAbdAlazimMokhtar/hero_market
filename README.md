# 🛒 Hero Market

**A new Flutter project.**
Welcome to the Hero Market app! This project is built with Flutter to provide a seamless user experience in both light and dark modes. 🚀

---

## 🚀 Getting Started

### OnBoarding Screen

#### 🌞 Light Mode

![Light Mode Screenshot 1](https://github.com/user-attachments/assets/ea2330db-7481-40a8-9fbb-7fa21d74b0b3)

&nbsp;

![Light Mode Screenshot 2](https://github.com/user-attachments/assets/5b2ed580-e5eb-4a29-90ec-92aea5676075)

#### 🌙 Dark Mode

![Dark Mode Screenshot 1](https://github.com/user-attachments/assets/e835cc58-0a0a-4a8c-bae0-9e8ff7cced94)

&nbsp;

![Dark Mode Screenshot 2](https://github.com/user-attachments/assets/4adf39db-b1a9-49e0-8790-df4019aa0d15)

---

## 🔑 Login UI

![Dark Mode Login UI](https://github.com/user-attachments/assets/7a0dfef0-53a0-4c7b-b271-1495ab73457c)

&nbsp;

![Login Light Mode](https://github.com/user-attachments/assets/5dd19821-13fa-435c-b58e-7eb5487d02fe)

&nbsp;

## 🔑 Register Screen UI

![Register Screen](https://github.com/user-attachments/assets/a768c1f2-4808-4ad8-aa4b-1dff40ac1b2c)

&nbsp;

## 🔑 Confirm Email (Forgot Password) Screen UI

![Confirm Email Screen](https://github.com/user-attachments/assets/f0c06c7d-4178-4272-be82-05174f82c062)

&nbsp;

## 🛡️ Field Validation: Ensure Fields Are Not Empty

📋 Key Features
Dynamic Error Messages:
Displays clear, user-friendly error messages for fields left empty.

Real-Time Validation:
Errors appear as the user interacts with the form and disappear upon correction.

Prevents Incomplete Submission:
The form cannot be submitted unless all required fields are filled and validated.

![Field Required ](https://github.com/user-attachments/assets/caa8ece6-adbc-42e0-a981-3a3f192392a0)

&nbsp;

## 🔐 Password Visibility Toggle

💡 Benefits
User-Friendly: Real-time validation and visibility toggle make form-filling smoother.
Secure & Accessible: Ensures data security while improving usability.
Seamless Integration: Easily customizable for other text fields in the app.

![Password Violability](https://github.com/user-attachments/assets/08439541-6d96-495b-8a79-126ebbe57a0e)

&nbsp;

🔒 Feature: Password Mismatch Validation

This Password Mismatch Validation feature ensures a smoother and error-free experience for users, boosting both usability and reliability! 🚀

![Simulator Screenshot - iPhone 16 Plus - 2024-12-23 at 21 37 36](https://github.com/user-attachments/assets/1b8b92da-da23-4b70-92de-ad7f9000da95)

---

&nbsp;

🚀 Forgot Password Feature :-

🔒 Secure Email Verification
Sends a One-Time Password (OTP) to the user’s registered email to confirm their identity.

⏱ Countdown Timer

Displays a timer to indicate the time remaining for OTP expiration, preventing multiple unnecessary requests.

🔄 Resend OTP

Allows users to resend a new OTP after the timer expires, with increasing intervals to enhance security.

🌟 Responsive & Intuitive UI

Offers a seamless user experience with clear instructions and real-time feedback.

Confirm Your Eamil

![Simulator Screenshot - iPhone 16 Plus - 2024-12-24 at 21 13 38](https://github.com/user-attachments/assets/cd4e1a6e-79ef-45c5-a175-03eadfaaf042)

Verification OTP CODE

![Simulator Screenshot - iPhone 16 Plus - 2024-12-24 at 21 13 45](https://github.com/user-attachments/assets/4699964c-225c-4811-9b4f-17dca60999f3)

Countdown Timer

![Simulator Screenshot - iPhone 16 Plus - 2024-12-24 at 21 13 55](https://github.com/user-attachments/assets/125e3419-d42a-4e12-84be-fecc05dce18b)

Resend OTP Button

![Simulator Screenshot - iPhone 16 Plus - 2024-12-24 at 21 14 45](https://github.com/user-attachments/assets/0e651c23-b719-41c3-aae0-ef8cff9443f2)

&nbsp;

## 🚀 Added Reset Password Feature

The **Reset Password** functionality enhances user security and experience by providing:

- **Secure OTP-based Email Verification**
- **Dynamic Countdown Timer**
- **Intuitive Resend OTP Mechanism**

  ![Simulator Screenshot - iPhone 16 Plus - 2024-12-30 at 10 48 22](https://github.com/user-attachments/assets/16ef516b-5590-475d-8d1c-2b41ad808b04)

  ## 🆕 Bottom Navigation Bar

A **Bottom Navigation Bar** has been added for a seamless user experience. The navigation bar includes the following tabs:

- **Home** 🏠  
- **Categories** 📂  
- **Cart** 🛒  
- **Wishlist** ❤️  
- **Profile** 👤  

### 🌙 Dark Mode Screenshot

![Dark Mode Bottom Navigation Bar](https://github.com/user-attachments/assets/7ca0d44c-e94f-4824-bc78-9badf926525a)

&nbsp;

### 🌞 Light Mode Screenshot

![Light Mode Bottom Navigation Bar](https://github.com/user-attachments/assets/3c8515c3-3d14-43a8-9bb5-8136dbebea9b)


## 📚 Features

- **OnBoarding Screens**
  - Supports both Light and Dark modes for better user experience.
- **Login UI**
  - Clean and modern design for a smooth login process.
- **Register Screen UI**
  - Offers a user-friendly and elegant interface to simplify the registration process.
- **Confirm Email (Forgot Password) Screen UI**
  - Provides a clean and intuitive design for verifying emails and resetting passwords efficiently.

---

## 📂 Project Structure

```plaintext
lib/
├── main.dart
├── core/
│   ├── utils/
│   │   ├── constants.dart
│   │   ├── theme.dart
│   ├── error/
│   │   ├── exceptions.dart
│   │   ├── failures.dart
│   ├── usecases/
│       ├── usecase.dart
├── features/
│   ├── onboarding/
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   │   ├── onboarding_screen.dart
│   │   │   ├── widgets/
│   │   │       ├── onboarding_widget.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── onboarding_entity.dart
│   │   │   ├── usecases/
│   │   │       ├── get_onboarding_data.dart
│   │   ├── data/
│   │       ├── models/
│   │       │   ├── onboarding_model.dart
│   │       ├── repositories/
│   │           ├── onboarding_repository_impl.dart
│   │       ├── datasources/
│   │           ├── onboarding_remote_datasource.dart
│   │           ├── onboarding_local_datasource.dart
│   ├── login/
│       ├── presentation/
│       │   ├── pages/
│       │   │   ├── login_screen.dart
│       │   ├── widgets/
│       │       ├── login_form.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── login_entity.dart
│       │   ├── usecases/
│       │       ├── login_user.dart
│       ├── data/
│           ├── models/
│           │   ├── login_model.dart
│           ├── repositories/
│           │   ├── login_repository_impl.dart
│           ├── datasources/
│               ├── login_remote_datasource.dart
│               ├── login_local_datasource.dart

```
