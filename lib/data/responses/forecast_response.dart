import 'dart:convert';

import 'package:intl/intl.dart';

class ForecastResponse {
    final String? cod;
    final int? message;
    final int? cnt;
    final List<WeatherForecast>? list;
    final City? city;

    ForecastResponse({
        this.cod,
        this.message,
        this.cnt,
        this.list,
        this.city,
    });

    factory ForecastResponse.fromJson(String str) => ForecastResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ForecastResponse.fromMap(Map<String, dynamic> json) => ForecastResponse(
        cod: json["cod"],
        message: json["message"],
        cnt: json["cnt"],
        list: json["list"] == null ? [] : List<WeatherForecast>.from(json["list"]!.map((x) => WeatherForecast.fromMap(x))),
        city: json["city"] == null ? null : City.fromMap(json["city"]),
    );

    Map<String, dynamic> toMap() => {
        "cod": cod,
        "message": message,
        "cnt": cnt,
        "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toMap())),
        "city": city?.toMap(),
    };
}

class City {
    final int? id;
    final String? name;
    final Coord? coord;
    final String? country;
    final int? population;
    final int? timezone;
    final int? sunrise;
    final int? sunset;

    City({
        this.id,
        this.name,
        this.coord,
        this.country,
        this.population,
        this.timezone,
        this.sunrise,
        this.sunset,
    });

    factory City.fromJson(String str) => City.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory City.fromMap(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        coord: json["coord"] == null ? null : Coord.fromMap(json["coord"]),
        country: json["country"],
        population: json["population"],
        timezone: json["timezone"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "coord": coord?.toMap(),
        "country": country,
        "population": population,
        "timezone": timezone,
        "sunrise": sunrise,
        "sunset": sunset,
    };
}

class Coord {
    final double? lat;
    final double? lon;

    Coord({
        this.lat,
        this.lon,
    });

    factory Coord.fromJson(String str) => Coord.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Coord.fromMap(Map<String, dynamic> json) => Coord(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "lat": lat,
        "lon": lon,
    };
}

class WeatherForecast {
    final int? dt;
    final MainClass? main;
    final List<Weather>? weather;
    final Clouds? clouds;
    final Wind? wind;
    final int? visibility;
    final double? pop;
    final Sys? sys;
    final DateTime? dtTxt;
    final Rain? rain;
    final String? day;

    WeatherForecast({
        this.dt,
        this.main,
        this.weather,
        this.clouds,
        this.wind,
        this.visibility,
        this.pop,
        this.sys,
        this.dtTxt,
        this.rain,
        this.day
    });

    factory WeatherForecast.fromJson(String str) => WeatherForecast.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory WeatherForecast.fromMap(Map<String, dynamic> json) => WeatherForecast(
        dt: json["dt"],
        main: json["main"] == null ? null : MainClass.fromMap(json["main"]),
        weather: json["weather"] == null ? [] : List<Weather>.from(json["weather"]!.map((x) => Weather.fromMap(x))),
        clouds: json["clouds"] == null ? null : Clouds.fromMap(json["clouds"]),
        wind: json["wind"] == null ? null : Wind.fromMap(json["wind"]),
        visibility: json["visibility"],
        pop: json["pop"]?.toDouble(),
        sys: json["sys"] == null ? null : Sys.fromMap(json["sys"]),
        dtTxt: json["dt_txt"] == null ? null : DateTime.parse(json["dt_txt"]),
        rain: json["rain"] == null ? null : Rain.fromMap(json["rain"]),
        day: DateFormat.E().format(DateTime.fromMillisecondsSinceEpoch(json["dt"] * 1000))
    );

    Map<String, dynamic> toMap() => {
        "dt": dt,
        "main": main?.toMap(),
        "weather": weather == null ? [] : List<dynamic>.from(weather!.map((x) => x.toMap())),
        "clouds": clouds?.toMap(),
        "wind": wind?.toMap(),
        "visibility": visibility,
        "pop": pop,
        "sys": sys?.toMap(),
        "dt_txt": dtTxt?.toIso8601String(),
        "rain": rain?.toMap(),
        "day": day,
    };
}

class Clouds {
    final int? all;

    Clouds({
        this.all,
    });

    factory Clouds.fromJson(String str) => Clouds.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Clouds.fromMap(Map<String, dynamic> json) => Clouds(
        all: json["all"],
    );

    Map<String, dynamic> toMap() => {
        "all": all,
    };
}

class MainClass {
    final double? temp;
    final double? feelsLike;
    final double? tempMin;
    final double? tempMax;
    final int? pressure;
    final int? seaLevel;
    final int? grndLevel;
    final int? humidity;
    final double? tempKf;

    MainClass({
        this.temp,
        this.feelsLike,
        this.tempMin,
        this.tempMax,
        this.pressure,
        this.seaLevel,
        this.grndLevel,
        this.humidity,
        this.tempKf,
    });

    factory MainClass.fromJson(String str) => MainClass.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MainClass.fromMap(Map<String, dynamic> json) => MainClass(
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
        pressure: json["pressure"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
        humidity: json["humidity"],
        tempKf: json["temp_kf"]?.toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
        "humidity": humidity,
        "temp_kf": tempKf,
    };
}

class Rain {
    final double? the3H;

    Rain({
        this.the3H,
    });

    factory Rain.fromJson(String str) => Rain.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Rain.fromMap(Map<String, dynamic> json) => Rain(
        the3H: json["3h"]?.toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "3h": the3H,
    };
}

class Sys {
    final String? pod;

    Sys({
        this.pod,
    });

    factory Sys.fromJson(String str) => Sys.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Sys.fromMap(Map<String, dynamic> json) => Sys(
        pod: json["pod"].toString(),
    );

    Map<String, dynamic> toMap() => {
        "pod": pod,
    };
}

class Weather {
    final int? id;
    final String? main;
    final String? description;
    final String? icon;
    final String? iconUrl;

    Weather({
        this.id,
        this.main,
        this.description,
        this.icon,
        this.iconUrl
    });

    factory Weather.fromJson(String str) => Weather.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Weather.fromMap(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"]?.toString(),
        description: json["description"]?.toString(),
        icon: json["icon"]?.toString(),
        iconUrl: 'https://openweathermap.org/img/wn/${json["icon"]?.toString()}@2x.png',
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
        "iconUrl": iconUrl,
    };
}

class Wind {
    final double? speed;
    final int? deg;
    final double? gust;

    Wind({
        this.speed,
        this.deg,
        this.gust,
    });

    factory Wind.fromJson(String str) => Wind.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Wind.fromMap(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble(),
        deg: json["deg"],
        gust: json["gust"]?.toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
    };
}
