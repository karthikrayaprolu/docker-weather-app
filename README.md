# Weather App

This is a simple weather application that allows users to search for weather information based on a city name. The application fetches data from the OpenWeather API and displays the current weather conditions, including temperature, humidity, and wind speed.

## Project Structure

```
weather-app
├── src
│   ├── weather.html        # HTML structure for the weather application
│   ├── script.js           # JavaScript code for fetching weather data and updating the UI
│   ├── style.css           # CSS styles for the weather application
│   └── assets              # Directory containing image assets
│       ├── background.jpg  # Background image for the application
│       ├── cloud.png       # Icon for cloudy weather
│       ├── clear.png       # Icon for clear weather
│       ├── rain.png        # Icon for rainy weather
│       ├── snow.png        # Icon for snowy weather
│       ├── mist.png        # Icon for misty weather
│       └── 404.png         # Icon for location not found error
├── Dockerfile               # Instructions to build the Docker image
├── nginx.conf               # Configuration for the Nginx web server
├── docker-compose.yml       # Defines services and configurations for Docker
└── README.md                # Documentation for the project
```

## Setup Instructions

### Method 1: Run with Docker

1. **Clone the Repository**:
   Clone this repository to your local machine using:
   ```
   git clone <repository-url>
   ```

2. **Navigate to the Project Directory**:
   Change into the project directory:
   ```
   cd weather-app
   ```

3. **Build the Docker Image**:
   Run the following command to build the Docker image:
   ```
   docker-compose build
   ```

4. **Run the Docker Container**:
   Start the application by running:
   ```
   docker-compose up
   ```

5. **Access the Application**:
   Open your web browser and navigate to `http://localhost:8080` to view the weather application.

### Method 2: Run with Kubernetes (Minikube)

1. **Clone the Repository and Navigate to Project Directory**:
   ```
   git clone <repository-url>
   cd weather-app
   ```

2. **Start Minikube**:
   ```
   minikube delete --all
   minikube start --driver=docker
   ```

3. **Check Cluster Status**:
   ```
   minikube status
   kubectl get nodes
   ```

4. **Enable Minikube to Use Local Docker Images**:
   ```
   minikube -p minikube docker-env | Invoke-Expression
   ```

5. **Build Local Docker Image**:
   ```
   docker build -t weather-app:1.0 .
   ```

6. **Apply Kubernetes Manifests**:
   ```
   kubectl apply -f k8s/deployment.yaml
   kubectl apply -f k8s/service.yaml
   kubectl apply -f k8s/ingress.yaml
   ```

7. **Access the Service**:
   ```
   minikube service weather-app-service
   ```

   Or if using ingress, update `/etc/hosts` with:
   ```
   127.0.0.1 weather.local
   ```

   then open 👉 http://weather.local

## Usage

- Enter a city name in the search box and click the search button to fetch the weather data.
- The application will display the current temperature, weather conditions, humidity, and wind speed.
- If the location is not found, an error message will be displayed.

## Stopping the Application

To stop the application, press `Ctrl + C` in the terminal where the Docker container is running. Alternatively, you can run:
```
docker-compose down
```

## Additional Notes

- Ensure that Docker is installed and running on your machine.
- You can customize the Nginx configuration in `nginx.conf` as needed.
- The application is accessible on port 8080 of your localhost, which can be changed in the `docker-compose.yml` file if necessary.