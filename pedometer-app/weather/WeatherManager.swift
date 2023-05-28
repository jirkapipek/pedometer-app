import SwiftUI
import MapKit

struct WeatherData: Codable {
    let latitude: Double
    let longitude: Double
    let generationtime_ms: Double
    let utc_offset_seconds: Int
    let timezone: String
    let timezone_abbreviation: String
    let elevation: Double
    let current_weather: CurrentWeather
}

struct CurrentWeather: Codable {
    let temperature: Double
    let windspeed: Double
    let winddirection: Double
    let weathercode: Int
    let is_day: Int
    let time: String
}

class WeatherManager: ObservableObject {
    @Published var weather: WeatherData?
    private var timer: Timer?
    
    func startFetchingWeatherData(for location: CLLocation) {
        // Invalidate the existing timer if it's running
        timer?.invalidate()
        
        // Start a new timer that fires every minute
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.fetchWeatherData(for: location)
        }
        
        // Immediately fetch weather data upon starting
        fetchWeatherData(for: location)
    }
    
    func stopFetchingWeatherData() {
        // Invalidate the timer to stop fetching data
        timer?.invalidate()
        timer = nil
    }
    
    func fetchWeatherData(for location: CLLocation) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current_weather=true&hourly=temperature_2m,relativehumidity_2m,windspeed_10m")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let weatherData = try? decoder.decode(WeatherData.self, from: data) {
                    DispatchQueue.main.async {
                        self.weather = weatherData // Naplnění hodnoty weather

                    }
                    return
                }
            }
            
            if let error = error {
                print("Failed to fetch weather data: \(error.localizedDescription)")
            }
        }.resume()
    }
}

