## **VGU CARE** ##

This project is a Web App created for the module of Programming Exercise.

The team consists of:
<!-- BLANK -->

The app aims to provide a platform for medical personnels and students to communicate, manage appointments and, in general, improve the study environment.

## Development Plan

We will use Docker to create a development environment, including a self-hosted database. This ensures the project's setup is consistent across the team's devices. 

Once we have a deployable web app, we will migrate to a 3-tier production architecture:
- **Frontend**: Static React build deployed to GitHub Pages
- **Backend**: Node.js API deployed to AWS ECS/Heroku 
- **Database**: PostgreSQL on AWS RDS

This approach maintains proper 3-tier architecture while leveraging free/low-cost cloud services.

## Project Structure

```
VGU_Care/
├── frontend/                 # React frontend application
│   ├── src/
│   │   ├── components/       # Reusable UI components
│   │   ├── pages/           # Main application pages
│   │   ├── services/        # API service calls
│   │   └── utils/           # Utility functions
│   ├── public/              # Static assets
│   └── package.json
├── backend/                 # Node.js backend API
│   ├── controllers/         # Route controllers
│   ├── models/             # Database models
│   ├── routes/             # API routes
│   ├── middleware/         # Custom middleware
│   └── config/             # Configuration files
├── database/               # Database scripts and migrations
├── docs/                   # Project documentation
├── tests/                  # Test files
└── README.md
```

## Features

- **User Authentication**: Secure login for students and medical personnel
- **Appointment Management**: Schedule and manage medical appointments
- **Communication Platform**: Messaging system between users
- **Profile Management**: User profile creation and updates
- **Dashboard**: Overview of appointments and notifications

## Technologies Used

- **Frontend**: React.js
- **Backend**: Node.js
- **Database**: PostgreSQL (Docker)
- **Containerization**: Docker & Docker Compose
- **Styling**: Tailwind CSS
- **Authentication**: JWT
- **Containerization**: Docker & Docker Compose
- **Dev Tools**: VSCode + Git

## Docker

Since we are new to Docker, just think of it as running multiple computers (containers) on your device. Each will handle their own task. One for frontend, one for backend/APIs and one for database.

As the setting up will be handled by Docker, there will be consitency accross all devices in our team and development will also be isolated, not messing with our own systems.


## Prerequisites

### Required Installation:
1. **[Docker Desktop](https://www.docker.com/get-started)** 
   - Downloads PostgreSQL, Node.js, and everything else automatically
   - Works on Windows, Mac, and Linux
   - **This is the only thing you need to install!**

2. **[Git](https://git-scm.com/)** - For version control

3. **[SQLTools](https://marketplace.visualstudio.com/items?itemName=mtxr.sqltools) by Matheus Teixeira**

4. **[SQLTools PostgreSQL/Cockroach Driver](https://marketplace.visualstudio.com/items?itemName=mtxr.sqltools-driver-pg)**


### Optional (for development):
- **[VSCode](https://code.visualstudio.com/)** - Code editor
- **[Draw.io Integration](https://marketplace.visualstudio.com/items?itemName=hediet.vscode-drawio)** - For .drawio diagrams

### Installation

1. **Install Docker Desktop**
   - Download from [docker.com](https://www.docker.com/get-started)
   - Install and start Docker Desktop
   - Wait for the whale icon 🐋 to appear in system tray. 
   *Note that it should say 'Engine running' not 'Engine starting'* 

2. **Clone the repository**

3. **Start everything with one command**
```bash
docker-compose up --build
```
*First time takes 2-3 minutes to download everything*

4. **Access the application**
- Frontend: http://localhost:3000
- Backend API: http://localhost:5000
- Database: localhost:5432

5. **Stop the application**
```bash
docker-compose down
```

### Development Setup

For active development with hot reload:
```bash
# Start only the database container
docker-compose up postgres -d

# Run frontend and backend on your machine (with auto-reload)
cd frontend && npm install && npm startbackend && npm install && npm run dev
cd 
```

### Common Docker Commands:
```bash
# Start all services
docker-compose up

# Start in background
docker-compose up -d

# Stop all services
docker-compose down

# Rebuild after code changes
docker-compose up --build

# View running containers
docker ps

# View logs
docker-compose logs
```

### Connecting to the Database (Optional)

If you want to query the database directly or inspect data:

1. **Connect to Database:**
   - Press `Ctrl+Shift+P` → Type "SQLTools Managment: Add New Connection"
   - Select **PostgreSQL**
   - Fill in connection details:

   ```
   Connection Name: VGU Care DB
   Server: localhost
   Port: 5432
   Database: vgu_care
   Username: vgu_user
   Password: vgu_password
   ```
   - Click **"Test Connection"** → **"Save Connection"**

2. **Query Database:**
   - Click SQLTools icon in sidebar
   - Right-click connection → **"New SQL File"**
   - Write queries and press `Ctrl+E` to execute

*Note: Your database comes pre-loaded with sample data (7 students, 2 medical staffs, 1 admin)*


## License

This project is licensed under the Apache License - see the [LICENSE](LICENSE) file for details.

