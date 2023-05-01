import SwiftUI
import MapKit

struct WeatherData: Codable {
    let current_weather: CurrentWeather
    let hourly: Hourly
}

struct CurrentWeather: Codable {
    let temperature_2m: Double
    let relativehumidity_2m: Double
    let windspeed_10m: Double
}

struct Hourly: Codable {
    let temperature_2m: [Double]
    let relativehumidity_2m: [Double]
    let windspeed_10m: [Double]
}

class WeatherManager: ObservableObject {
    @Published var weather: WeatherData?
    
    func fetchWeatherData(for location: CLLocation) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current_weather=true&hourly=temperature_2m,relativehumidity_2m,windspeed_10m")!
        print("https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current_weather=true&hourly=temperature_2m,relativehumidity_2m,windspeed_10m")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let weatherData = try? decoder.decode(WeatherData.self, from: data) {
                    DispatchQueue.main.async {
                        self.weather = weatherData
                    }
                    return
                }
            }
            
            print("Failed to fetch weather data: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}
