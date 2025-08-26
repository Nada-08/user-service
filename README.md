# User Service Project

A Spring Boot application with MySQL database, containerized using Docker for easy deployment and development.

---

## Prerequisites

Before you can run this project, you only need the following tools:

### 1. Git

Git is needed to clone the repository.

* [Download Git](https://git-scm.com/downloads)
* Verify installation:

  ```bash
  git --version
  ```

### 2. Docker & Docker Compose

Docker is used to run the application and database containers.

* **Windows / macOS:** Install [Docker Desktop](https://www.docker.com/products/docker-desktop/). It includes both Docker and Docker Compose.
* **Linux (Ubuntu/Debian):**

  ```bash
  sudo apt update
  for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh ./get-docker.sh --dry-run
  sudo apt update
  sudo apt install docker-ce docker-compose-plugin

  # Optional: allow running docker without sudo
  sudo usermod -aG docker $USER
  ```
* Verify installation:

  ```bash
  docker --version
  docker compose version
  ```

---

## Getting Started

### Step 1: Clone the Repository

```bash
git clone https://github.com/Nada-08/user-service.git
cd user-service
```

### Step 2: Build the Application JAR

The Dockerfile expects a built JAR in the `target/` folder. You have two options:

#### Option 1: Build with Maven locally (if installed)

```bash
mvn clean package -DskipTests
``` 

#### Option 2: Build with Maven inside Docker (no local Java/Maven required)

```bash
docker run --rm -v $(pwd):/app -w /app maven:3.9-eclipse-temurin-17 mvn clean package -DskipTests
```

This will generate:

```
target/user-service-1.0-SNAPSHOT.jar
```

### Step 3: Run with Docker Compose

```bash
docker compose up --build
```

This will:

* Build the Spring Boot container
* Start a MySQL 8 container
* Link them together
* Expose the app on `http://localhost:8080`

---

## Services

### Application Service (`app`)

* **Technology:** Spring Boot (Java)
* **Port:** 8080
* **Depends on:** MySQL (`db`)

### Database Service (`db`)

* **Technology:** MySQL 8
* **External Port:** 3307 (mapped from 3306 inside container)
* **Database:** `myappdb`
* **Credentials:**

  * Root password: `root123`
  * User: `springuser`
  * Password: `root123`


# Connecting to MySQL

You don’t need to install MySQL locally. The database runs inside Docker.

To connect to the MySQL database:

```bash
docker exec -it <mysql_container_name> mysql -u springuser -p myappdb
```

---

## Useful Commands

```bash
# Stop services
docker compose down

# Stop services and remove database data
docker compose down -v

# Rebuild everything
docker compose up --build

# View logs
docker compose logs -f
```

---

## Troubleshooting

**Issue:** `target/user-service-1.0-SNAPSHOT.jar not found`
**Solution:** Run the Maven build step before `docker compose up`.

**Issue:** `docker: command not found`
**Solution:** Install Docker and ensure it is running.

**Issue:** Database connection error
**Solution:** Wait a few seconds, the app will start once MySQL is healthy.

**Issue:** Port already in use
**Solution:** Stop the process using the port, or change ports in `docker-compose.yml`.

---

## Project Structure

```
user-service/
├── src/                    # Source code
├── target/                 # Built JAR (after mvn package)
├── Dockerfile              # App container config
├── docker-compose.yml      # Multi-container setup
├── pom.xml                 # Maven configuration
└── README.md               # Documentation
```
