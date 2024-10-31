Scotiabank Financial Services Project
Project Overview
This project is a web application for Scotiabank, built using JSP (Java Server Pages), to replicate core financial services functionalities such as transaction handling, loan registration, and insurance records. It provides an interactive user interface for customers to manage their transactions, request loans, and set up insurance plans.

Prerequisites
To run this project, ensure you have the following installed:

Java JDK: Version 8 or higher
Apache Tomcat: Version 9 or higher
MySQL: For database management
JDBC MySQL Connector: Place the MySQL connector jar file (e.g., mysql-connector-java-8.0.26.jar) in the lib folder of your Tomcat server.
Setup Instructions
Step 1: Database Configuration
Create a MySQL database named scotiabank.
Import the provided SQL script (scotiabank.sql) located in the db folder to set up the required tables and initial data.
Update the database configuration in the base_datos.jsp file with your MySQL credentials:
jsp
Copiar código
String dbUrl = "jdbc:mysql://localhost:3306/scotiabank";
String dbUser = "your_username";
String dbPassword = "your_password";
Step 2: Server Setup
Download and install Apache Tomcat.
Place the MySQL connector jar file in the lib directory of your Tomcat installation to enable database connectivity.
Step 3: Deploy the Application
Copy the entire project directory into the webapps folder of your Tomcat server.
Start the Tomcat server by running the startup.sh or startup.bat script in the bin folder of Tomcat.
Project Structure
The project follows this structure:

src: Contains Java source files and JSP pages.
lib: Dependencies for the project (e.g., MySQL connector).
db: Database scripts.
styles: CSS files for styling.
scripts: JavaScript files (e.g., ajax_transaccion.js) for handling dynamic content.
Usage
Login: Access the login page at http://localhost:8080/YourProjectName/login.jsp.
Transaction Registration: Go to transaccion.jsp to record transactions, select transaction types, and view transaction history.
Loan Application: Access prestamo.jsp to apply for loans with specified terms.
Insurance Setup: Access seguro.jsp to register insurance policies.
Known Issues / Future Improvements
Consider adding more robust error handling for database connectivity issues.
Improve user feedback with additional front-end validations and dynamic updates.
Contributor
Jose Jesus Huertas Valverde
