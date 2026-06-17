package com.petstore;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;

/**
 * Runner principal para ejecutar todas las pruebas de la API Petstore.
 * Genera reporte HTML en target/karate-reports/
 */
class PetstoreRunner {

    @Karate.Test
    Karate testAll() {
        return Karate.run("classpath:features")
                     .outputCucumberJson(true)
                     .outputJunitXml(true);
    }
}
