# Weather App 🌦️

A modern, responsive weather application that provides real-time weather information for any city worldwide. Built with vanilla HTML, CSS, and JavaScript, the app fetches data from the OpenWeatherMap API and displays current weather conditions including temperature, humidity, wind speed, and weather descriptions with dynamic icons.

## Project Structure

```
weather-app/
├── src/                     # Application source files
│   ├── weather.html         # Main HTML page (entry point)
│   ├── script.js            # JavaScript for API calls and DOM manipulation
│   ├── style.css            # CSS styles and responsive design
│   └── assets/              # Static image assets
│       ├── background.jpg   # Background image for the application
│       ├── cloud.png        # Cloudy weather icon
│       ├── clear.png        # Clear weather icon
│       ├── rain.png         # Rainy weather icon
│       ├── mist.png         # Misty/Hazy weather icon
│       ├── maxtemp.png      # Maximum temperature icon
│       ├── mintemp.png      # Minimum temperature icon
│       └── 404.png          # Error state icon (location not found)
├── k8s/                     # Kubernetes deployment manifests
│   ├── deployment.yaml      # Kubernetes deployment configuration
│   ├── service.yaml         # Kubernetes service configuration
│   └── ingress.yaml         # Kubernetes ingress configuration
├── Dockerfile               # Multi-stage Docker build instructions
├── nginx.conf               # Nginx web server configuration
├── docker-compose.yml       # Docker Compose service definition
└── README.md               # Project documentation
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

## Features

- 🔍 **City Search**: Enter any city name to get current weather information
- 🌡️ **Temperature Display**: Real-time temperature in Celsius with weather descriptions
- 💨 **Wind Information**: Current wind speed in Km/h
- 💧 **Humidity Levels**: Atmospheric humidity percentage
- 🎨 **Dynamic Icons**: Weather-appropriate icons (clear, cloudy, rainy, misty)
- 📱 **Responsive Design**: Works seamlessly on desktop and mobile devices
- ⚡ **Fast Loading**: Optimized with Nginx and Docker containerization

## Docker Configuration

### Dockerfile Architecture
- **Base Image**: `nginx:alpine` (lightweight and secure)
- **Application Files**: Static assets served from `/usr/share/nginx/html/`
- **Custom Configuration**: Optimized Nginx settings for performance
- **Port Exposure**: Container runs on port 80, mapped to host port 8080

### Docker Compose Setup
- **Service Name**: `weather-app`
- **Build Context**: Current directory (`.`)
- **Port Mapping**: `8080:80` (host:container)
- **Restart Policy**: `unless-stopped` for automatic recovery
- **Container Name**: `weather-app-container`

### Nginx Configuration Highlights
- **Gzip Compression**: Enabled for better performance
- **Static Asset Caching**: 1-year cache for images and assets
- **Security Headers**: X-Frame-Options, X-Content-Type-Options, X-XSS-Protection
- **Fallback Routing**: Serves `weather.html` for all routes

## API Integration

This application uses the **OpenWeatherMap API** to fetch real-time weather data:
- **API Endpoint**: `https://api.openweathermap.org/data/2.5/weather`
- **Parameters**: City name, metric units, API key
- **Response Data**: Temperature, humidity, wind speed, weather conditions
- **Error Handling**: 404 responses for invalid locations

## Stopping the Application

### Stop Docker Compose
```bash
docker-compose down
```

### Stop Individual Container
```bash
docker stop weather-app-container
```

### Remove Container and Images
```bash
docker-compose down --rmi all --volumes
```

## Troubleshooting

### Common Issues

1. **Port Already in Use**:
   ```bash
   # Change port in docker-compose.yml from 8080 to another port
   ports:
     - "3000:80"  # Use port 3000 instead
   ```

2. **API Key Issues**:
   - Ensure you have a valid OpenWeatherMap API key
   - The current key in `script.js` may have usage limits

3. **Container Won't Start**:
   ```bash
   # Check Docker logs
   docker logs weather-app-container
   
   # Rebuild the image
   docker-compose build --no-cache
   ```

4. **Assets Not Loading**:
   - Verify all files are in the `src/assets/` directory
   - Check browser console for 404 errors

## Development

### Local Development Without Docker
1. Open `src/weather.html` directly in a web browser
2. Use a local web server for proper asset loading:
   ```bash
   # Using Python
   cd src && python -m http.server 3000
   
   # Using Node.js
   npx serve src -p 3000
   ```

### Modifying the Application
1. Edit files in the `src/` directory
2. Rebuild the Docker image:
   ```bash
   docker-compose build
   docker-compose up
   ```

## Production Deployment

### Environment Variables
Consider adding environment variables for:
- OpenWeatherMap API key
- Port configuration
- Nginx worker processes

### Security Considerations
- Replace the hardcoded API key with environment variables
- Implement rate limiting for API calls
- Add HTTPS support with SSL certificates
- Use secrets management for API keys

## Additional Notes

- **Docker Required**: Ensure Docker and Docker Compose are installed
- **Port Configuration**: Default port 8080 can be changed in `docker-compose.yml`
- **Nginx Customization**: Modify `nginx.conf` for specific requirements
- **Cross-Platform**: Works on Windows, macOS, and Linux with Docker
- **Resource Usage**: Minimal resource footprint with Alpine Linux base image