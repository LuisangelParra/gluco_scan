/* --
      LIST OF Enums
      They cannot be created inside a class.
-- */

/// Diabetes risk levels as defined in the evaluation screen.
enum DiabetesRiskLevel { low, moderate, high }

/// Categories for the health recommendations (p. ej., alimentación, ejercicio, sueño, manejo del estrés).
enum RecommendationCategory { diet, exercise, sleep, stressManagement }

/// Types of measurements shown on the dashboard (glucosa, insulina, ritmo cardíaco).
enum MeasurementType { glucose, insulin, heartRate }

/// Habit categories for tracking daily routines (p. ej., alimentación, actividad física, sueño).
enum HabitCategory { nutrition, physicalActivity, sleep }

/// Authentication methods used in the app (correo, Facebook, Google).
enum AuthMethod { email, facebook, google }

/// Main sections of the application for navigation.
enum AppSection { evaluation, actionPlan, dailyLog, progress, recommendations, profile }

/// Custom text sizes used in various branded widgets.
enum TextSizes { small, medium, large }

/// Supported image types for assets, network images, etc.
enum ImageType { asset, network, memory, file }
