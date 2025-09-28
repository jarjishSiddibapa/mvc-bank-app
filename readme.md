# MVC Bank Application

A comprehensive digital banking application built using Java MVC architecture with JSP/Servlet technology. This modern banking system features user authentication, account management, fund transfers, and administrative controls with both light and dark theme support.

## 🚀 Features

### Core Banking Features
- **User Authentication**: Secure login/logout system with session management
- **Account Management**: Create and manage savings and current accounts
- **Fund Transfers**: Instant money transfers between accounts
- **Transaction History**: Digital passbook with complete transaction records
- **Account Statements**: Generate and view account statements

### Administrative Features
- **Admin Dashboard**: Comprehensive administrative control panel
- **User Management**: Create, view, and manage user accounts
- **Transaction Monitoring**: Monitor all system transactions
- **Account Oversight**: View and manage all customer accounts

### UI/UX Features
- **Dark/Light Mode**: Toggle between modern dark and light themes
- **Responsive Design**: Mobile-first approach for all devices
- **Modern Interface**: Clean, intuitive user experience
- **Secure Banking**: Industry-standard security practices

## 🏗️ Architecture

The application follows the **Model-View-Controller (MVC)** pattern:

- **Model**: Entity classes (`User`, `Account`, `Transaction`)
- **View**: JSP pages with dynamic content rendering
- **Controller**: Servlet controllers handling business logic
- **DAO Layer**: Database access objects for data persistence
- **Service Layer**: Business logic and validation

## 📁 Project Structure

```
mvc-bank-app/
├── src/main/
│   ├── java/com/aurionpro/
│   │   ├── controller/        # Servlet controllers
│   │   ├── dao/              # Data Access Objects
│   │   ├── model/            # Entity classes
│   │   ├── service/          # Business logic services
│   │   ├── filter/           # Security filters
│   │   └── util/             # Utility classes
│   └── webapp/
│       ├── common/           # Shared JSP components
│       ├── *.jsp             # Main JSP pages
│       ├── light.css         # Light theme styles
│       ├── dark.css          # Dark theme styles
│       └── WEB-INF/
└── project-images/           # Application screenshots
```

## 🖼️ Application Screenshots

### Light Theme
![Home Page Light](project-images/home-page-light.png)
*Modern homepage with clean design*

![Login Light](project-images/login-light.png)
*Secure login interface*

![User Dashboard Light](project-images/user-dashboard-light.png)
*Comprehensive user dashboard*

![Admin Dashboard Light](project-images/admin-dashboard-light.png)
*Administrative control panel*

![Account Details Light](project-images/account-details-light.png)
*Detailed account information*

![Transfer Light](project-images/transfer-light.png)
*Fund transfer interface*

![Transfer Confirmation Light](project-images/transfer-confirmation-light.png)
*Transfer confirmation screen*

![Account Statement Light](project-images/account-statement-light.png)
*Digital account statements*

### Dark Theme
![Home Page Dark](project-images/home-page-dark.png)
*Dark mode homepage*

![Login Dark](project-images/login-dark.png)
*Dark theme login*

![User Dashboard Dark](project-images/user-dashboard-dark.png)
*Dark mode user dashboard*

![Admin Dashboard Dark](project-images/admin-dashboard-dark.png)
*Dark theme admin panel*

![Account Details Dark](project-images/account-details-dark.png)
*Account details in dark mode*

![Transfer Dark](project-images/transfer-dark.png)
*Dark mode fund transfer*

![Account Statement Dark](project-images/account-statement-dark.png)
*Dark theme statements*

### Additional Pages
![Register Light](project-images/register-light.png) ![Register Dark](project-images/register-dark.png)
*User registration (Light/Dark)*

![About Us Light](project-images/about-us-light.png) ![About Us Dark](project-images/about-us-dark.png)
*About us page (Light/Dark)*

![Contact Light](project-images/contact-light.png) ![Contact Dark](project-images/contact-dark.png)
*Contact page (Light/Dark)*

![Privacy Policy Light](project-images/privacy-policy-light.png) ![Privacy Policy Dark](project-images/privacy-policy-dark.png)
*Privacy policy (Light/Dark)*

## 🛠️ Technology Stack

- **Backend**: Java, JSP, Servlets
- **Frontend**: HTML5, CSS3, JavaScript
- **Database**: PostgreSQL (configurable)
- **Build Tool**: Maven
- **Server**: Apache Tomcat
- **Architecture**: MVC Pattern

## 🚀 Getting Started

### Prerequisites
- Java 8 or higher
- Apache Tomcat 9+
- PostgreSQL database
- Maven (for build management)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/jarjishSiddibapa/mvc-bank-app.git
   cd mvc-bank-app
   ```

2. **Database Setup**
   - Create a PostgreSQL database
   - Update database configuration in the application

3. **Build the project**
   ```bash
   mvn clean compile
   ```

4. **Deploy to Tomcat**
   - Copy the project to Tomcat webapps directory
   - Start Tomcat server

5. **Access the application**
   - Open browser and navigate to `http://localhost:8080/mvc-bank-app`

## 💡 Usage

### For Users
1. **Registration**: Create a new account with personal details
2. **Login**: Access your dashboard with credentials
3. **Account Management**: View account details and balance
4. **Transfer Funds**: Send money to other accounts
5. **View Statements**: Check transaction history and statements

### For Administrators
1. **Admin Login**: Access with administrator credentials
2. **User Management**: Create and manage user accounts
3. **Transaction Monitoring**: View all system transactions
4. **System Administration**: Oversee banking operations

## 🎨 Theme Switching

The application supports both light and dark themes:
- Click the theme toggle button in the header
- Preference is saved in browser storage
- Consistent experience across all pages

## 🔒 Security Features

- Session-based authentication
- Input validation and sanitization
- SQL injection prevention
- Secure password handling
- Admin access controls

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👤 Author

**Jarjish Siddibapa**
- GitHub: [@jarjishSiddibapa](https://github.com/jarjishSiddibapa)

## 🙏 Acknowledgments

- Built during training at AurionPro
- Inspired by modern banking interfaces
- Thanks to the open-source community

---

*Experience the future of digital banking with our modern, secure, and user-friendly banking application.*