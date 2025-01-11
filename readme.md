## Local Development and Testing

### Overview
The project was initially developed and tested locally to ensure all components (frontend, backend, and database) work seamlessly together. Docker Compose was used to orchestrate the services and simplify the local setup.

### Docker Compose Setup
The `docker-compose.yml` file defines the following services:
- **Frontend**: Serves the React application.
- **Backend**: Provides the API and interacts with the database.
- **Database**: A PostgreSQL instance for data storage.

### Local Testing Instructions
1. Clone the repository:
   ```bash
   git clone https://github.com/Vivek1121sachdev/TaskManagerWithK8s.git
   cd task-manager

2. Test using the Docker Compose:
    ```bash
    docker-compose --build up

3. Access the Application:
- Fronend: http://localhost:3000
- Backend API: http://localhost:5001/tasks