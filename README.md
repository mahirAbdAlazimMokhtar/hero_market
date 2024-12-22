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


---

## 📚 Features  

- **OnBoarding Screens**  
  - Supports both Light and Dark modes for better user experience.  
- **Login UI**  
  - Clean and modern design for a smooth login process.  

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

