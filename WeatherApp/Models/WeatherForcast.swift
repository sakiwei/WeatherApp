//
//  WeatherForcast.swift
//  WeatherApp
//
//  Created by Sakiwei on 14/1/2022.
//

import Foundation

// MARK: - WeatherForcast
struct WeatherForcast: Codable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case hourly, daily
    }
}

// MARK: WeatherForcast convenience initializers and mutators

extension WeatherForcast {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(WeatherForcast.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    func with(
        lat: Double? = nil,
        lon: Double? = nil,
        timezone: String? = nil,
        timezoneOffset: Int? = nil,
        hourly: [HourlyWeather]? = nil,
        daily: [DailyWeather]? = nil
    ) -> WeatherForcast {
        return WeatherForcast(
            lat: lat ?? self.lat,
            lon: lon ?? self.lon,
            timezone: timezone ?? self.timezone,
            timezoneOffset: timezoneOffset ?? self.timezoneOffset,
            hourly: hourly ?? self.hourly,
            daily: daily ?? self.daily
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DailyWeather
struct DailyWeather: Codable {
    let dt: Double
    let sunrise, sunset, moonrise: Int
    let moonset: Int
    let moonPhase: Double
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let dewPoint, windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [Weather]
    let clouds: Int
    let pop, uvi: Double
    let snow: Double?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, uvi, snow
    }
}

// MARK: DailyWeather convenience initializers and mutators

extension DailyWeather {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DailyWeather.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    func with(
        dt: Double? = nil,
        sunrise: Int? = nil,
        sunset: Int? = nil,
        moonrise: Int? = nil,
        moonset: Int? = nil,
        moonPhase: Double? = nil,
        temp: Temp? = nil,
        feelsLike: FeelsLike? = nil,
        pressure: Int? = nil,
        humidity: Int? = nil,
        dewPoint: Double? = nil,
        windSpeed: Double? = nil,
        windDeg: Int? = nil,
        windGust: Double? = nil,
        weather: [Weather]? = nil,
        clouds: Int? = nil,
        pop: Double? = nil,
        uvi: Double? = nil,
        snow: Double?? = nil
    ) -> DailyWeather {
        return DailyWeather(
            dt: dt ?? self.dt,
            sunrise: sunrise ?? self.sunrise,
            sunset: sunset ?? self.sunset,
            moonrise: moonrise ?? self.moonrise,
            moonset: moonset ?? self.moonset,
            moonPhase: moonPhase ?? self.moonPhase,
            temp: temp ?? self.temp,
            feelsLike: feelsLike ?? self.feelsLike,
            pressure: pressure ?? self.pressure,
            humidity: humidity ?? self.humidity,
            dewPoint: dewPoint ?? self.dewPoint,
            windSpeed: windSpeed ?? self.windSpeed,
            windDeg: windDeg ?? self.windDeg,
            windGust: windGust ?? self.windGust,
            weather: weather ?? self.weather,
            clouds: clouds ?? self.clouds,
            pop: pop ?? self.pop,
            uvi: uvi ?? self.uvi,
            snow: snow ?? self.snow
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day, night, eve, morn: Double
}

// MARK: FeelsLike convenience initializers and mutators

extension FeelsLike {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FeelsLike.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    func with(
        day: Double? = nil,
        night: Double? = nil,
        eve: Double? = nil,
        morn: Double? = nil
    ) -> FeelsLike {
        return FeelsLike(
            day: day ?? self.day,
            night: night ?? self.night,
            eve: eve ?? self.eve,
            morn: morn ?? self.morn
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

// MARK: Temp convenience initializers and mutators

extension Temp {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Temp.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    func with(
        day: Double? = nil,
        min: Double? = nil,
        max: Double? = nil,
        night: Double? = nil,
        eve: Double? = nil,
        morn: Double? = nil
    ) -> Temp {
        return Temp(
            day: day ?? self.day,
            min: min ?? self.min,
            max: max ?? self.max,
            night: night ?? self.night,
            eve: eve ?? self.eve,
            morn: morn ?? self.morn
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let weatherDescription: String
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: Weather convenience initializers and mutators

extension Weather {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Weather.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    func with(
        id: Int? = nil,
        main: String? = nil,
        weatherDescription: String? = nil,
        icon: String? = nil
    ) -> Weather {
        return Weather(
            id: id ?? self.id,
            main: main ?? self.main,
            weatherDescription: weatherDescription ?? self.weatherDescription,
            icon: icon ?? self.icon
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Hourly
struct HourlyWeather: Codable {
    let dt: Double
    let temp, feelsLike: Double
    let pressure, humidity: Int
    let dewPoint, uvi: Double
    let clouds, visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [Weather]
    let pop: Double

    enum CodingKeys: String, CodingKey {
        case dt, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, pop
    }
}

// MARK: Hourly convenience initializers and mutators

extension HourlyWeather {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HourlyWeather.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    func with(
        dt: Double? = nil,
        temp: Double? = nil,
        feelsLike: Double? = nil,
        pressure: Int? = nil,
        humidity: Int? = nil,
        dewPoint: Double? = nil,
        uvi: Double? = nil,
        clouds: Int? = nil,
        visibility: Int? = nil,
        windSpeed: Double? = nil,
        windDeg: Int? = nil,
        windGust: Double? = nil,
        weather: [Weather]? = nil,
        pop: Double? = nil
    ) -> HourlyWeather {
        return HourlyWeather(
            dt: dt ?? self.dt,
            temp: temp ?? self.temp,
            feelsLike: feelsLike ?? self.feelsLike,
            pressure: pressure ?? self.pressure,
            humidity: humidity ?? self.humidity,
            dewPoint: dewPoint ?? self.dewPoint,
            uvi: uvi ?? self.uvi,
            clouds: clouds ?? self.clouds,
            visibility: visibility ?? self.visibility,
            windSpeed: windSpeed ?? self.windSpeed,
            windDeg: windDeg ?? self.windDeg,
            windGust: windGust ?? self.windGust,
            weather: weather ?? self.weather,
            pop: pop ?? self.pop
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
