// ============================================================
// karate-config.js
// Configuración global de Karate para el proyecto Petstore
// ============================================================
function fn() {
    var config = {
        // URL base de la API
        baseUrl: 'https://petstore.swagger.io/v2',

        // Headers por defecto para todas las peticiones
        defaultHeaders: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        }
    };

    // Aplicar headers por defecto globalmente
    karate.configure('headers', config.defaultHeaders);

    // Timeout de conexión (en milisegundos)
    karate.configure('connectTimeout', 10000);
    karate.configure('readTimeout', 15000);

    return config;
}
