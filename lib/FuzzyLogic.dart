

class FuzzyLogic {
  // Global initialization
  static String tomatoSoilMoistureStatus = '';
  static String tomatoTemperatureStatus = '';
  static String tomatoHumidityStatus = '';
  static String tomatoLightStatus = '';

  static String chiliSoilMoistureStatus = '';
  static String chiliTemperatureStatus = '';
  static String chiliHumidityStatus = '';
  static String chiliLightStatus = '';


  static String getSoilMoistureRecommendation(int rawSoilMoisture) {
    double normalizedPercentage = ((rawSoilMoisture - 200) / (800 - 200)) * 100;

    if (normalizedPercentage < 30) {
      return "Please water heavily.";
    } else if (normalizedPercentage >= 30 && normalizedPercentage < 40) {
      return "Please water moderately.";
    } else if (normalizedPercentage >= 50 && normalizedPercentage <= 70) {
      return "Maintain your current watering schedule.";
    } else if (normalizedPercentage > 70 && normalizedPercentage <= 80) {
      return "Reduce watering frequency to prevent overwatering.";
    } else if (normalizedPercentage > 80) {
      return "Stop watering to avoid waterlogging.";
    } else {
      return "Unknown soil moisture level.";
    }
  }

  static String getSoilMoistureStatus(int rawSoilMoisture) {
    double normalizedPercentage = ((rawSoilMoisture - 200) / (800 - 200)) * 100;

    if (normalizedPercentage < 30) {
      return "Soil moisture is very low (below 30%).";
    } else if (normalizedPercentage >= 30 && normalizedPercentage < 40) {
      return "Soil moisture is low (30%-40%).";
    } else if (normalizedPercentage >= 50 && normalizedPercentage <= 70) {
      return "Soil moisture is optimal (50%-70%).";
    } else if (normalizedPercentage > 70 && normalizedPercentage <= 80) {
      return "Soil moisture is high (70%-80%).";
    } else if (normalizedPercentage > 80) {
      return "Soil moisture is very high (above 80%).";
    } else {
      return "Unknown soil moisture level.";
    }
  }

  static String getHumidityRecommendation(int humidity) {
    if (humidity < 50) {
      return 'Start misting or spraying water.';
    } else if (humidity >= 50 && humidity <= 70) {
      return 'No need to add or reduce moisture';
    } else {
      return 'Reduce misting or spraying to lower humidity.';
    }
  }

  static String getHumidityStatus(int humidity) {
    if (humidity < 50) {
      return 'Humidity is below 50%.';
    } else if (humidity >= 50 && humidity <= 70) {
      return 'Humidity is within the optimal range (50-70%).';
    } else {
      return 'Humidity is above 70%.';
    }
  }


  static String getLightRecommendation(int lightIntensity) {
    if (lightIntensity <= 150) {
      return 'Consider increasing exposure to sunlight.';
    } else if (lightIntensity <= 200) {
      return 'Maintain current lighting level.';
    } else if (lightIntensity >= 280 && lightIntensity <= 350) {
      return 'No lighting adjustments needed.';
    } else if (lightIntensity > 350 && lightIntensity <= 450) {
      return 'Reduce exposure to direct sunlight.';
    } else {
      return 'Move the plants to a shaded area.';
    }
  }

  static String getLightStatus(int lightIntensity) {
    if (lightIntensity <= 150) {
      return 'Light intensity is low.';
    } else if (lightIntensity <= 200) {
      return 'Light intensity is moderate.';
    } else if (lightIntensity >= 280 && lightIntensity <= 350) {
      return 'Light intensity is optimal.';
    } else if (lightIntensity > 350 && lightIntensity <= 450) {
      return 'Light intensity is high.';
    } else {
      return 'Light intensity is very high.';
    }
  }


  static String getTemperatureStatus(int temperature) {
    if (temperature < 10) {
      return "Temperature is below 10°C.";
    } else if (temperature >= 10 && temperature < 18) {
      return "Temperature is low (10°C - 17°C).";
    } else if (temperature >= 18 && temperature <= 26) {
      return "Temperature is optimal (18°C - 26°C).";
    } else if (temperature > 26 && temperature <= 35) {
      return "Temperature is high (27°C - 35°C).";
    } else {
      return "Temperature is very high (above 35°C).";
    }
  }

  static String getTemperatureRecommendation(int temperature) {
    if (temperature < 10) {
      return "Move the plant to a warmer location.";
    } else if (temperature >= 10 && temperature < 18) {
      return "Ensure the plant is in a draft-free area.";
    } else if (temperature >= 18 && temperature <= 26) {
      return "Temperature is optimal.";
    } else if (temperature > 26 && temperature <= 35) {
      return "Provide shade/move the plant to a cooler spot.";
    } else {
      return "Move the plant to a significantly cooler location.";
    }
  }

  static String getPlantCondition({
    required int rawSoilMoisture,
    required int temperature,
    required int humidity,
    required int lightIntensity,
  }) {
    String soilMoistureStatus = getSoilMoistureStatus(rawSoilMoisture);
    String tempStatus = getTemperatureStatus(temperature);
    String humidityStatus = getHumidityStatus(humidity);
    String lightStatus = getLightStatus(lightIntensity);

    if (soilMoistureStatus.contains('very low') &&
        tempStatus.contains('below 10') &&
        humidityStatus.contains('below 50') &&
        lightStatus.contains('low')) {
      return 'VeryBad';
    }

    if ((soilMoistureStatus.contains('very low') &&
        tempStatus.contains('low') &&
        (humidityStatus.contains('below 50') || lightStatus.contains('low'))) ||
        soilMoistureStatus.contains('very low')) {
      return 'Bad';
    }

    if ((soilMoistureStatus.contains('optimal') &&
        tempStatus.contains('high') &&
        (humidityStatus.contains('below 50') || lightStatus.contains('low'))) ||
        soilMoistureStatus.contains('optimal')) {
      return 'Fair';
    }

    if ((soilMoistureStatus.contains('high') && tempStatus.contains('high') &&
        humidityStatus.contains('high') && lightStatus.contains('high')) ||
        soilMoistureStatus.contains('high')) {
      return 'Excellent';
    }

    if ((soilMoistureStatus.contains('optimal') &&
        tempStatus.contains('optimal') &&
        humidityStatus.contains('optimal') &&
        lightStatus.contains('optimal')) ||
        soilMoistureStatus.contains('optimal')) {
      return 'Excellent';
    }

    return 'Unknown';
  }


}
