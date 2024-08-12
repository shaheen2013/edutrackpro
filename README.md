<h3 align="center"><a href="https://github.com/shaheen2013/edutrackpro" target="_blank">EduTrackPro</a></h3>

# Student Session Tracking System

## Introduction

The **Student Session Tracking System** is a web application designed to track and manage student sessions, helping to identify and improve their practical or theoretical knowledge gaps in any subject. This application allows users to add students, manage their availability, schedule sessions, rate students, and generate improvement reports. It is built using Laravel 9+ for the backend and Vue.js 2 for the frontend.

## Features

- **Student Management:** Add and list student details including basic information such as name and date of birth.
- **Availability Tracking:** Manage and track the weekday availability of each student.
- **User Authentication:** Simple login/logout functionality for a single user.
- **Session Scheduling:** Schedule sessions with students, ensuring no overlap with existing sessions.
- **Notifications:** Notify both user and student 5 minutes before the session starts.
- **Session Rating:** Rate students after each session to monitor improvement.
- **Document Parsing:** Upload and parse MS-Docx files to extract target improvement data.
- **Report Generation:** Generate and export session reports in PDF format, with customizable templates and time splits.

## Installation

Follow these steps to set up the project locally:

### Prerequisites

- PHP 8.2 or higher
- Composer
- Node.js & npm
- MySQL or any other compatible database
- Git

### Steps

1. **Clone the Repository**

   ```bash
   git clone https://github.com/shaheen2013/edutrackpro.git
   cd edutrackpro
   ```

2. **Install Backend Dependencies**

   ```bash
   composer install
   ```

3. **Install Frontend Dependencies**

   ```bash
   npm install
   ```

4. **Environment Setup**

   Copy the `.env.example` file to `.env` and update the database and other necessary configurations.

   ```bash
   cp .env.example .env
   ```

   Generate the application key:

   ```bash
   php artisan key:generate
   ```

5. **Database Setup**

   Create a new database and run the migrations:

   ```bash
   php artisan migrate
   ```

6. **Run the Development Server**

   Start the Laravel development server:

   ```bash
   php artisan serve
   ```

   In a separate terminal, start the Vue development server:

   ```bash
   npm run dev
   ```

7. **Access the Application**

   Open your browser and visit `http://localhost:8000` to view the application.

## Additional Commands

- **Run Tests:**
  ```bash
  php artisan test
  ```

- **Build for Production:**
  ```bash
  npm run build
  ```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

```

Feel free to adjust the content according to your project's specific details and requirements.
