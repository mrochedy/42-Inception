# 42-Inception, by Maxime Rochedy

This repository contains my implementation of the **Inception** project from **École 42**, designed to build a multi-service infrastructure using **Docker** containers. The project focuses on deploying essential services like **WordPress**, **Nginx**, and **MariaDB**, while ensuring that the setup is scalable and secure. This project was evaluated by three peers and received the maximum score of **125/100**, including bonus features.

Please note that, while the code and configurations aim for robustness, this project is inherently complex. Certain features might exhibit minor issues or require troubleshooting, especially when dealing with different environments. Your feedback or contributions to improve the setup are welcome!

<img width="198" alt="125/100 grade" src="https://github.com/user-attachments/assets/708486c1-c045-40d6-ab0c-e5dc3650a50d">

## About the Project

The **Inception** project is all about system administration and containerization using Docker. The objective is to build a fully functional infrastructure composed of several services, each running in its **own container**. This allows for separation of concerns, easier management, and enhanced security.

The project includes:

- **Nginx**: A web server used to serve HTTP requests.
- **MariaDB**: A relational database management system used to store and manage WordPress data.
- **WordPress**: A popular CMS for creating and managing websites.

### Bonus Features:

- **Redis Cache**: Used to manage caching for the WordPress site, improving its performance by reducing database load.
- **FTP Server**: Provides FTP access to the WordPress volume, allowing users to manage files through FTP clients.
- **Static Website**: A simple static site (excluding PHP).
- **Adminer**: A lightweight database management tool, similar to phpMyAdmin, used to interact with the MariaDB database.
- **Portainer**: A service for managing Docker containers through a user-friendly web interface, simplifying the monitoring and control of the Docker environment.

Each service has been configured to work together harmoniously within Docker containers, but due to the complexity of managing multiple interconnected services, slight issues may arise depending on the environment or system setup.

## Getting Started

To get started with the project, ensure that **Docker** is installed on your system. It’s recommended to use a **virtual machine** to avoid any potential conflicts with existing services on your machine.

After adding a `.env` file containing the required **environment variables** and **credentials**, just clone the project and build it:

```bash
git clone https://github.com/mrochedy/42-Inception.git
cd 42-Inception
make
```

The project will automatically pull the required Docker images and create the necessary containers.

## Contributing

If this repository was helpful, feel free to ⭐️ **star** ⭐️ it to boost visibility! Contributions are welcome through pull requests, especially for fixing bugs or enhancing the setup. Just as with other 42 projects, avoid submitting this code as your own.

Thank you for checking out the project, and enjoy working with **Docker** and **Inception**!
