class LRoutes {
  // -- Authentication
  static const home = '/';                      // Splash o dashboard inicial
  static const login = '/sign-in';              // Iniciar sesión
  static const signUp = '/sign-up';             // Registrarse
  static const forgotPassword = '/forgot-password'; // Olvidé mi contraseña
  static const resetPassword = '/reset-password';   // Restablecer contraseña
  static const verifyEmail = '/verify-email';       // Verificación de correo

  // -- Onboarding (si aplica)
  static const onboarding = '/onboarding';          // Pantallas de bienvenida

  // -- Risk Evaluation Flow
  static const dashboard = '/dashboard';
  static const riskEval  = '/risk-evaluation'; // Evaluación de riesgo
  static const riskResult = '/risk-result';          // Resultado de la evaluación
  static const actionPlan = '/action-plan';  
  static const habitTracking = '/habit-tracking';
  static const learning = '/learning';        // Plan de acción / recomendaciones

  // -- Habit Tracking
  static const dailyLog = '/daily-log';              // Registro diario de hábitos
  static const addHabit = '/daily-log/add-habit';    // Añadir nuevo hábito

  // -- Progress / Dashboard
  static const progress = '/progress';               // Progreso de salud

  // -- Learning / Content
  static const learn = '/learn';                     // Pantalla de consejos y artículos
  static const articleDetail = '/learn/article';     // Detalle de artículo
  static const videoDetail = '/learn/video';         // Detalle de video

  // -- User
  static const profile = '/profile';                 // Perfil del usuario
  static const settings = '/settings';  
  
               // Ajustes de la aplicación
}
