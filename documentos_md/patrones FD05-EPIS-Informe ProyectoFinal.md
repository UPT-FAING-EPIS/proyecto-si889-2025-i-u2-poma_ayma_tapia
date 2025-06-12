![](/documentos_md/img/Aspose.Words.cf11bb0a-acc2-4847-befb-1a50ecb767b5.001.png)

**UNIVERSIDAD PRIVADA DE TACNA** 

**FACULTAD DE INGENIERÍA** 

**Escuela Profesional de Ingeniería de Sistemas** 

**Informe Final**  

**“App de Gestión Financiera para el Registro y Análisis de Gastos Personales”** 

Curso:  Patrones de Software Docente: *Ing. Patrick Cuadros* 

Integrantes: 

***Ayma Choque, Erick Yoel (2021072616) \
Poma Machicado, Fabiola Estefani (2021070030) Tapia Vargas, Dylan Yariet (2021072630)*** 

**Tacna – Perú** 

***2025***

![](/documentos_md/img/Aspose.Words.cf11bb0a-acc2-4847-befb-1a50ecb767b5.002.png)
|CONTROL DE VERSIONES ||||||
| - | :- | :- | :- | :- | :- |
|Versión |Hecha por |Revisada por |Aprobada por |Fecha |Motivo |
|1\.0 |MPV |ELV |ARV |10/10/2020 |Versión Original |
# **ÍNDICE GENERAL** 
[**Antecedentes  3](#_page2_x85.05_y70.85) **[Planteamiento del Problema  4](#_page3_x85.05_y165.70)** 

1. [Problema  4](#_page3_x85.05_y181.51)
1. [Justificación  4](#_page3_x85.05_y498.46)
1. [Alcance  5](#_page4_x85.05_y114.47)

[**Objetivos  5](#_page4_x85.05_y335.78) **[Marco Teórico  5](#_page5_x85.05_y70.85)** 

1. [Gestión Financiera Personal  5](#_page5_x85.05_y86.66)
1. [Tecnologías Utilizadas en el Desarrollo de Aplicaciones Móviles  6](#_page5_x85.05_y576.71)
1. [Automatización de Procesos Financieros  7](#_page6_x85.05_y244.74)
1. [Análisis de Datos Financieros  7](#_page6_x85.05_y639.94)
1. [Seguridad y Privacidad en Aplicaciones Financieras  8](#_page7_x85.05_y197.32)

[**Desarrollo de la Solución  8](#_page8_x85.05_y70.85)** 

1. [Análisis de Factibilidad (técnico, económica, operativa, social, legal, ambiental)  8](#_page8_x85.05_y86.66) 
1. [Tecnología de Desarrollo  10](#_page10_x85.05_y70.85) 
1. [Metodología de implementación (Documento de VISION, SRS, SAD)  11](#_page11_x85.05_y70.85) 

[**Cronograma  12](#_page12_x85.05_y70.85) **[Presupuesto  13](#_page13_x85.05_y86.66) [Conclusiones  13](#_page14_x85.05_y70.85) [Recomendaciones  14](#_page14_x85.05_y608.33) [Bibliografía  15](#_page16_x85.05_y70.85) [Anexos  15**](#_page16_x85.05_y497.67)**

<a name="_page2_x85.05_y70.85"></a>**Antecedentes**  

La gestión financiera personal es un tema ampliamente discutido debido a su impacto directo en la estabilidad económica y la calidad de vida de las personas. Sin embargo, la mayoría de los individuos enfrenta serias dificultades al tratar de gestionar sus finanzas de manera eficiente. De acuerdo con estudios recientes, una gran parte de la población mundial carece de una planificación financiera adecuada, lo que genera un aumento de la deuda personal y una falta de ahorro. 

Con la proliferación de la tecnología móvil, han surgido diversas aplicaciones diseñadas para ayudar a las personas a gestionar sus finanzas. Algunas de las aplicaciones más conocidas incluyen: 

1. Mint: Esta aplicación, popular en los Estados Unidos, permite a los usuarios realizar un seguimiento de sus ingresos y gastos, generar presupuestos y recibir alertas sobre pagos de facturas. Si bien es útil para muchos, la aplicación no se adapta completamente a las necesidades de cada usuario, ya que carece de opciones avanzadas de personalización y análisis financiero detallado. 
1. YNAB (You Need A Budget): YNAB se enfoca en enseñar a los usuarios cómo administrar su dinero mediante el uso de un sistema de asignación de fondos por categoría. Aunque es muy efectiva en términos educativos y de planificación de presupuesto, algunos usuarios encuentran su interfaz compleja y no apta para principiantes. 
1. Fintonic: Aplicación española que permite a los usuarios controlar sus ingresos, gastos y presupuestos mediante la categorización automática de transacciones. Sin embargo, muchos usuarios reportan problemas con la integración de cuentas bancarias y la falta de personalización en los informes generados. 

A pesar de la existencia de estas herramientas, la mayoría de ellas son aplicaciones genéricas que no se ajustan completamente a las necesidades particulares de los usuarios, especialmente en cuanto a la personalización del control de gastos, la integración de datos financieros y la adaptación a los hábitos financieros de cada persona. 

Por otro lado, el escaneo de boletas o recibos es una característica que ha ido ganando popularidad en aplicaciones de gestión financiera, ya que permite a los usuarios registrar sus gastos de manera rápida y precisa sin tener que introducir manualmente la información. Herramientas como Expensify o Receipt Bank han sido pioneras en este campo, pero aún existe una brecha en el mercado para soluciones completas que ofrezcan una combinación de escaneo de recibos, categorización automática de gastos, generación de reportes y alertas personalizadas. 

En este contexto, surge la necesidad de una solución móvil integral que combine las mejores características de las aplicaciones existentes, pero que a su vez ofrezca un enfoque adaptado a las necesidades específicas del usuario, con mayor personalización, funcionalidad avanzada de análisis y un sistema simplificado de escaneo de boletas 

<a name="_page3_x85.05_y165.70"></a>**Planteamiento del Problema**  

1. Problema<a name="_page3_x85.05_y181.51"></a> 

   En la actualidad, muchas personas enfrentan dificultades para registrar y gestionar sus gastos diarios de manera eficiente, lo que puede generar desorden financiero y afectar la toma de decisiones económicas. La falta de herramientas automatizadas y accesibles provoca una baja visibilidad sobre los hábitos de consumo, dificultando la planificación y el control del presupuesto personal. 

   Además, la ausencia de un sistema estructurado para registrar los egresos puede llevar a una administración financiera deficiente, impidiendo la identificación de oportunidades de ahorro y provocando una gestión ineficaz del dinero. A esto se suma el tiempo y esfuerzo que conlleva el registro manual de cada transacción, lo que desmotiva a los usuarios y dificulta la adopción de hábitos financieros saludables. 

   Ante esta situación, es necesario desarrollar una solución tecnológica que permita automatizar el registro de gastos de manera rápida y precisa, facilitando el control financiero y ayudando a los usuarios a tomar decisiones económicas más informadas. 

2. Justificación<a name="_page3_x85.05_y498.46"></a> 

   La necesidad de contar con una solución práctica y automatizada para la gestión de gastos personales responde a la creciente demanda de herramientas tecnológicas que faciliten la vida diaria de los usuarios. Una aplicación que permita registrar egresos de manera automática y organizada no solo optimiza el tiempo, sino que también proporciona información valiosa para el análisis financiero. 

   Además, esta solución contribuirá al desarrollo de habilidades de educación financiera, promoviendo una mejor administración del dinero desde edades tempranas. Implementar una herramienta de este tipo puede tener un impacto positivo tanto a nivel individual como social, al fomentar prácticas económicas más sostenibles y responsables. 

   Asimismo, al ofrecer una interfaz amigable, accesible desde diferentes dispositivos y con funcionalidades que se adapten a las necesidades de cada usuario, se amplía el alcance de la propuesta, permitiendo beneficiar a un mayor número de personas, incluyendo aquellas con conocimientos tecnológicos limitados. 

3. Alcance<a name="_page4_x85.05_y114.47"></a> 

   Este proyecto contempla el desarrollo de una aplicación móvil multiplataforma que permita a los usuarios registrar, categorizar y visualizar sus egresos de forma automática o manual. La herramienta incluirá funciones como alertas de gastos, reportes gráficos mensuales, categorización inteligente de transacciones, y recomendaciones personalizadas para optimizar el uso del dinero. 

   El sistema estará enfocado en el usuario individual, aunque en futuras etapas podría ampliarse para incluir funcionalidades orientadas a grupos familiares Inicialmente, la aplicación se desarrollará en idioma español, pero se considerará su internacionalización a largo plazo. 
# <a name="_page4_x85.05_y335.78"></a>**Objetivos** 
Objetivo general 

Desarrollar una aplicación móvil de gestión financiera personal que permita a los usuarios registrar, analizar y optimizar sus gastos mediante el escaneo de facturas y boletas, ofreciendo herramientas avanzadas para mejorar la administración de sus finanzas. 

Objetivos Específicos 

- Implementar una funcionalidad de escaneo de boletas para extraer automáticamente los datos de facturas y boletas. 
- Diseñar un sistema de análisis y categorización de gastos que genere reportes detallados y gráficos intuitivos. 
- Desarrollar una opción de exportación de datos y sincronización en la nube, permitiendo a los usuarios acceder a su historial financiero en cualquier momento. 

<a name="_page5_x85.05_y70.85"></a>**Marco Teórico**  
1. ## **Gestión<a name="_page5_x85.05_y86.66"></a> Financiera Personal** 
La gestión financiera personal se refiere  ![](/documentos_md/img/Aspose.Words.cf11bb0a-acc2-4847-befb-1a50ecb767b5.003.jpeg)a la capacidad de un individuo para  manejar sus ingresos, egresos, ahorros e  inversiones de manera eficiente, con el  fin de alcanzar sus objetivos económicos  y financieros. La base de una buena  gestión financiera radica en la toma de  decisiones informadas, el seguimiento  de los hábitos de consumo y la  planificación a largo plazo.  

Uno de los principales desafíos de la gestión financiera es el control de los gastos personales, ya que las personas suelen no tener una visión clara de sus flujos de dinero, lo que puede llevar a la acumulación de deudas y a la incapacidad de ahorrar. Los principios clave de la gestión financiera personal incluyen: 

- Presupuesto: Es esencial crear y mantener un presupuesto que permita ajustar los ingresos con los gastos. 
- Ahorro: Establecer objetivos de ahorro es crucial para alcanzar una estabilidad económica futura. 
- Deuda controlada: Es importante mantener las deudas dentro de un rango razonable para no comprometer la capacidad de pago. 
- Inversiones inteligentes: La inversión es una herramienta para el crecimiento del patrimonio, pero debe ser realizada con conocimientos adecuados y estrategias bien definidas. 
2. ## **Tecnologías<a name="_page5_x85.05_y576.71"></a> Utilizadas en el Desarrollo de Aplicaciones Móviles** 
El desarrollo de aplicaciones móviles ha crecido enormemente en los últimos años, permitiendo a los usuarios acceder a herramientas y servicios desde cualquier lugar y en cualquier momento. Las aplicaciones móviles de gestión financiera se basan en tecnologías que permiten el manejo eficiente de datos financieros de manera segura y accesible. 

- Plataformas de desarrollo móvil: Las aplicaciones móviles pueden ser desarrolladas para plataformas como Android e iOS. Android, que usa Java y Kotlin como lenguajes principales, es una plataforma muy popular para aplicaciones de consumo masivo, mientras que iOS usa Swift y Objective-C. 
- Bases de datos: Para almacenar los datos financieros de los usuarios de forma eficiente y segura, se utilizan bases de datos relacionales (como SQLite) o NoSQL (como Firebase). 
- Tecnologías de escaneo de boletas: El uso de tecnologías como OCR (Reconocimiento Óptico de Caracteres) permite extraer automáticamente los datos de los recibos y facturas, facilitando el registro de transacciones. Herramientas como Google Vision y Tesseract OCR se utilizan para esta función. 
3. ## **Automatización<a name="_page6_x85.05_y244.74"></a> de Procesos Financieros** 
La automatización en la gestión financiera personal se refiere al uso de herramientas tecnológicas para simplificar tareas como el registro de gastos, la categorización de transacciones y la generación de reportes. Las aplicaciones móviles que incorporan automatización permiten que los usuarios ingresen los datos de manera más eficiente, reduciendo el esfuerzo y el riesgo de errores humanos. 

- Escaneo de boletas y recibos: La automatización del ingreso de datos mediante escaneo es uno de los avances más significativos en las aplicaciones financieras. Mediante OCR, las aplicaciones pueden reconocer y extraer automáticamente la información de los recibos, ahorrando tiempo y esfuerzo en comparación con el registro manual. 
- Categorización inteligente de gastos: Algunas aplicaciones utilizan algoritmos de machine learning para analizar los patrones de gasto del usuario y realizar sugerencias personalizadas o categorizar automáticamente las transacciones según su naturaleza (por ejemplo, alimentos, entretenimiento, transporte). 
- Alertas y recomendaciones: A través del análisis de datos históricos, las aplicaciones pueden generar alertas que notifiquen al usuario sobre eventos importantes, como cuando se está excediendo un presupuesto 

  o cuando es necesario ahorrar para un objetivo determinado. 
4. ## **Análisis<a name="_page6_x85.05_y639.94"></a> de Datos Financieros** 
El análisis de datos es crucial para la toma de decisiones financieras informadas. Las aplicaciones móviles de gestión financiera no solo permiten registrar los datos, sino que también ofrecen herramientas de análisis que proporcionan una visión detallada del comportamiento financiero del usuario. 

- Gráficos y reportes: El uso de gráficos interactivos y reportes detallados ayuda a los usuarios a comprender mejor sus patrones de consumo y ahorro. Estos reportes pueden incluir gráficos de barras, circulares y líneas que visualizan la distribución de los gastos por categoría, los ingresos y los ahorros. 
- Tendencias y proyecciones: Algunas aplicaciones avanzadas permiten realizar proyecciones basadas en tendencias históricas, ayudando a los usuarios a visualizar cómo sus decisiones actuales afectarán su situación financiera futura. 
5. ## **Seguridad<a name="_page7_x85.05_y197.32"></a> y Privacidad en Aplicaciones Financieras** 
La seguridad es un aspecto crucial en las aplicaciones de gestión financiera, dado que manejan información sensible. La protección de los datos personales y financieros de los usuarios es fundamental para generar confianza. 

- Encriptación: Los datos deben ser cifrados tanto en tránsito (cuando son enviados a los servidores) como en reposo (cuando están almacenados en la base de datos). 
- Autenticación y autorización: La implementación de sistemas de autenticación de múltiples factores (2FA) y protocolos seguros de autorización (OAuth, JWT) ayuda a garantizar que solo los usuarios autorizados puedan acceder a sus datos. 
- Cumplimiento de normativas: Las aplicaciones financieras deben cumplir con normativas de protección de datos como GDPR (Reglamento General de Protección de Datos de la Unión Europea) o HIPAA (Ley de Portabilidad y Responsabilidad de Seguro de Salud en EE. UU.) para garantizar la privacidad y la seguridad. 
# <a name="_page8_x85.05_y70.85"></a>**Desarrollo de la Solución** 
1. Análisis<a name="_page8_x85.05_y86.66"></a> de Factibilidad (técnico, económica, operativa, social, legal, ambiental) 

   **Factibilidad Técnica** 

   El proyecto presenta alta factibilidad técnica gracias al uso de herramientas modernas y ampliamente respaldadas. El desarrollo se realizará en **Flutter**, permitiendo construir una única base de código para Android e iOS, reduciendo tiempos y costos de mantenimiento. 

   ` `Para el backend, se utilizará **Firebase**, que proporciona servicios escalables como Firestore (base de datos en tiempo real), Authentication, Storage y Functions. 

   ` `Además, se incorporará **inteligencia artificial generativa** a través del modelo **Gemini**, el cual reemplaza tecnologías OCR tradicionales para extraer información de boletas con mayor precisión, incluso en condiciones visuales difíciles. 

   ` `El equipo cuenta con experiencia en estas tecnologías, lo que asegura una implementación sólida. El uso de herramientas ampliamente adoptadas minimiza riesgos técnicos durante el desarrollo y operación. 

   **Factibilidad Económica** 

   Se ha realizado un análisis detallado de los costos asociados al desarrollo, operación y mantenimiento del sistema. Los costos mensuales se estiman en: 

- **Costos generales:** S/ 1,000.00 
- **Costos operativos:** S/ 300.00 
- **Costos del ambiente (Firebase, IA, publicación, etc):** S/ 375.00 
- **Costos de personal:** S/ 8,400.00 

**Total mensual: S/ 10,075.00** 

A nivel financiero, se ha proyectado un ingreso por suscripción mensual con un crecimiento progresivo de usuarios. Los indicadores obtenidos fueron: 

- **Valor Actual Neto (VAN):** S/ 12,340.59 
- **Tasa Interna de Retorno (TIR):** 27% 
- **Relación Beneficio/Costo (B/C):** 1.41 

Estos resultados confirman que el proyecto es **financieramente viable** y sostenible a mediano plazo. 

**Factibilidad Operativa** 

La aplicación es operativamente viable, gracias a tecnologías que facilitan el despliegue, mantenimiento y escalabilidad del sistema. 

` `**Firebase** permite gestionar la infraestructura sin necesidad de servidores físicos, mientras que **Flutter** agiliza el desarrollo multiplataforma. 

` `La escalabilidad automática de Firebase permite adaptar el sistema al crecimiento de usuarios sin intervenciones manuales. Las tareas de mantenimiento serán rápidas, con bajo impacto para los usuarios. Todo esto favorece una operación estable, eficiente y sostenible. 

**Factibilidad Legal** 

El sistema se ajustará a la **Ley de Protección de Datos Personales**, aplicando buenas prácticas de seguridad como cifrado de datos, autenticación segura y control de accesos mediante reglas en Firebase. 

` `Se establecerán **términos y condiciones de uso**, junto con políticas de privacidad claras. También se evaluará la necesidad de registros o permisos legales según la jurisdicción, asegurando que el software opere sin vulnerar ninguna normativa vigente. 

**Factibilidad Social** 

La aplicación tiene un fuerte impacto social al mejorar la **educación financiera** de los usuarios. Permite registrar y visualizar gastos de forma sencilla, brindando control y claridad sobre las finanzas personales. 

` `Además, democratiza el acceso a herramientas digitales de gestión financiera, beneficiando especialmente a personas con poco conocimiento financiero. Su uso podría fomentar hábitos de ahorro y una mejor toma de decisiones económicas. 

**Factibilidad Ambiental** 

El proyecto es **ambientalmente responsable**, ya que reduce el uso de papel mediante la digitalización de boletas y recibos. 

` `Al operar en la nube (Firebase) y fomentar el **trabajo remoto**, disminuye el consumo de energía en oficinas físicas y reduce la huella de carbono asociada al transporte. 

` `Además, al evitar el uso de infraestructura física tradicional, se genera un impacto ambiental menor, alineándose con prácticas sostenibles en el desarrollo tecnológico. 

2. Tecnología<a name="_page10_x85.05_y70.85"></a> de Desarrollo 

   El sistema será desarrollado utilizando tecnologías modernas, eficientes y con amplio respaldo de la comunidad de desarrollo: 

   **Frontend:** 

   Se usará Flutter, un framework de código abierto de Google que permite crear aplicaciones móviles nativas para Android e iOS desde una única base de código. Flutter facilita una experiencia de usuario fluida, reduce tiempos de desarrollo y simplifica el mantenimiento. 

   **Backend y servicios en la nube:** 

   La plataforma Firebase será utilizada para gestionar toda la infraestructura del backend, sin necesidad de servidores físicos. Los principales servicios a integrar incluyen: 

- Firestore: Base de datos NoSQL en tiempo real. 
- Authentication: Para registro y control seguro de usuarios. 
- Storage: Almacenamiento de imágenes y archivos. 

**Procesamiento inteligente de datos:** 

Se incorporará inteligencia artificial generativa mediante el modelo Gemini (IA de Google), que permitirá extraer datos de boletas y facturas de forma precisa, reemplazando tecnologías OCR tradicionales. Esta solución mejora la interpretación de documentos, incluso con baja calidad visual o formatos variados. 

**Herramientas de soporte:** 

- Visual Studio Code: Como entorno de desarrollo. 
- Git y GitHub: Para control de versiones y trabajo colaborativo. 
- Google Cloud Console: Para monitoreo y gestión de recursos de Firebase. 

Estas tecnologías fueron seleccionadas por su escalabilidad, facilidad de integración, comunidad activa y capacidad para adaptarse al crecimiento futuro del sistema. 

3. Metodología<a name="_page11_x85.05_y70.85"></a> de implementación (Documento de VISION, SRS, SAD) 

   Para asegurar una implementación estructurada y efectiva del sistema, se seguirá una metodología basada en buenas prácticas de ingeniería de software. Esta metodología contempla el desarrollo iterativo e incremental del sistema, sustentado en documentación técnica clave que guiará cada fase del proyecto. 

1. **Documento de Visión (Vision Document)** 

Este documento define el propósito, alcance, funcionalidades principales y actores del sistema. También identifica las necesidades de los usuarios, las metas del proyecto y las restricciones técnicas o de negocio. Sirve como punto de referencia para alinear a todos los involucrados sobre los objetivos del proyecto. 

2. **Especificación de Requisitos del Software (SRS – Software Requirements Specification)** 

   Aquí se detallan los requisitos funcionales y no funcionales del sistema. Incluye descripciones precisas sobre lo que el software debe hacer (ej. gestión de usuarios, escaneo de boletas, generación de reportes) y condiciones que debe cumplir (ej. rendimiento, seguridad, disponibilidad). Esta especificación es esencial para asegurar que el sistema cumpla las expectativas del usuario final. 

3. **Diseño de Arquitectura del Software (SAD – Software Architecture Document)** 

   Este documento presenta la arquitectura técnica del sistema, detallando los componentes principales, su interacción y los patrones de diseño empleados. Incluye diagramas de arquitectura, flujos de datos, diseño del backend (Firebase), estructura de la app en Flutter, y la integración con servicios como Gemini. El SAD garantiza que el sistema sea escalable, mantenible y coherente con los requisitos técnicos definidos. 

4. **Ciclo de vida del desarrollo** 

Se adoptará un enfoque ágil, dividiendo el desarrollo en sprints o entregas parciales, lo cual permite validar avances de forma continua, adaptarse a cambios y garantizar entregables funcionales en cada etapa. Cada sprint incluirá actividades de diseño, desarrollo, pruebas y revisión. 
# <a name="_page12_x85.05_y70.85"></a>**Cronograma** 

|Semana |Fase / Actividades Técnicas |Responsables |
| - | - | - |
|Semana 1 |<p>- Revisión de requerimientos funcionales y no funcionales </p><p>- Elaboración del Documento de Visión </p>|Líder de Proyecto |
|Semana 2 |<p>- Elaboración del SRS (Especificación de Requisitos de Software) </p><p>- Diseño preliminar de la arquitectura (SAD) </p>|Líder + Programador |
|Semana 3 |<p>- Configuración del entorno de desarrollo (Flutter, Firebase, repositorio GitHub) </p><p>- Definición de historias de usuario </p>|Todo el equipo |
|Semana 4 |<p>- Diseño de interfaces (mockups, navegación) </p><p>- Implementación inicial del login (Firebase Auth) </p>|Programador |
|Semana 5 |<p>- Estructura de Firestore y configuración de reglas de acceso </p><p>- Desarrollo de pantallas principales (dashboard, gastos) </p>|Programador |
|Semana 6 |<p>- Integración con Gemini API para lectura inteligente de boletas </p><p>- Pruebas con diferentes tipos de imágenes </p>|Programador + QA |
|Semana 7 |<p>- Desarrollo de funcionalidades CRUD (agregar, editar, eliminar gastos) </p><p>- Almacenamiento de imágenes (Firebase Storage) </p>|Programador |
|Semana 8 |<p>- Generación automática de reportes financieros </p><p>- Configuración de funciones en la nube (Firebase Functions) </p>|Programador |
|Semana 9 |<p>- Pruebas unitarias </p><p>- Pruebas de validación de datos </p><p>- Feedback inicial con usuarios simulados </p>|QA Tester |
|Semana 10 |<p>- Corrección de errores y optimizaciones </p><p>- Validación de seguridad (reglas de acceso, encriptación) </p>|QA Tester + Líder |
|Semana 11 |<p>- Preparación para despliegue </p><p>- Publicación en Google Play Store </p><p>- Plan de lanzamiento </p>|Líder de Proyecto |
|Semana 12 |<p>- Campaña de publicidad básica </p><p>- Evaluación final del proyecto </p><p>- Documentación y cierre </p>|Todo el equipo |
# <a name="_page13_x85.05_y86.66"></a>**Presupuesto** 
Se totalizan los costos y se presenta un resumen final del proyecto. 



|**Categoría** |**Costo Total (S/.) Me** |
| - | - |
|Costos Generales |1,000.00  |
|Costos Operativos  |300\.00  |
|Costos del Ambiente |375\.00  |
|Costos de Personal |8,400.00  |

Gran Total: S/ 10,075.00  

<a name="_page14_x85.05_y70.85"></a>**Conclusiones**  

- Impacto positivo de las aplicaciones de gestión financiera personal: El desarrollo de herramientas tecnológicas orientadas a la gestión financiera personal ha demostrado ser un factor crucial para mejorar la administración del dinero de los usuarios. Las aplicaciones móviles permiten a los individuos llevar un control más detallado y organizado de sus ingresos, egresos y ahorros, lo que facilita la toma de decisiones informadas. 
- Automatización como factor clave de éxito: La automatización en el registro de gastos, especialmente a través del escaneo de boletas, es una funcionalidad que aumenta significativamente la eficiencia de las aplicaciones financieras. Esta característica no solo ahorra tiempo, sino que también minimiza los errores humanos y proporciona un registro preciso y actualizado de las transacciones. 
- Necesidad de personalización en las aplicaciones: A pesar de la existencia de diversas soluciones para la gestión financiera, muchas de las aplicaciones disponibles no logran adaptarse completamente a las necesidades individuales de los usuarios. Las soluciones más exitosas son aquellas que ofrecen un alto grado de personalización en la categorización de gastos, la generación de reportes y las recomendaciones personalizadas. 
- Seguridad como prioridad: La seguridad de los datos personales y financieros de los usuarios es un aspecto fundamental en el desarrollo de aplicaciones móviles de este tipo. Las aplicaciones deben garantizar la protección de la información a través de tecnologías como la encriptación y sistemas de autenticación de múltiples factores. 
- Oportunidades de mejora: Aunque las aplicaciones de gestión financiera móvil han avanzado significativamente, aún existen áreas de oportunidad para integrar funciones más avanzadas, como la planificación financiera a largo plazo, la integración con más bancos y servicios financieros, y la incorporación de algoritmos más sofisticados para el análisis predictivo. 
# <a name="_page14_x85.05_y608.33"></a>**Recomendaciones** 
- Optimización de la experiencia del usuario: Para mejorar la adopción de la aplicación, se recomienda hacer la interfaz más intuitiva y amigable, especialmente para usuarios que no están familiarizados con la tecnología. Una experiencia fluida y accesible aumentará la tasa de retención de los usuarios. 
- Incorporación de características de educación financiera: Integrar secciones dentro de la aplicación que enseñen principios básicos de educación financiera podría agregar valor, especialmente en regiones donde las personas tienen poca educación financiera. Incluir recomendaciones personalizadas basadas en 

  el comportamiento del usuario también podría ayudar a mejorar los hábitos financieros. 

- Ampliar la compatibilidad con más servicios y bancos: Para hacer que la aplicación sea aún más útil, se sugiere la integración con una mayor variedad de servicios financieros y bancos para facilitar la sincronización de las transacciones de los usuarios. 
- Mejorar la personalización del análisis y los reportes: Es recomendable seguir optimizando la personalización de los reportes, permitiendo que los usuarios personalicen las categorías de gasto y tengan acceso a gráficos más avanzados y dinámicos que les ayuden a comprender mejor sus finanzas. 
- Refuerzo de la seguridad de la información: Continuar con la implementación de protocolos de seguridad robustos para garantizar que los datos de los usuarios estén protegidos frente a amenazas cibernéticas. Además, es importante cumplir con las normativas internacionales sobre protección de datos (como GDPR o CCPA) para ganar la confianza del usuario. 

<a name="_page16_x85.05_y70.85"></a>**Bibliografía**  

- Kiyosaki, R. T. (1997). Padre Rico, Padre Pobre: Qué les enseñan los ricos a sus hijos sobre el dinero que los pobres y la clase media no les enseñan. Editorial Aguilar. 
- Kotler, P., & Keller, K. L. (2016). Dirección de marketing (15ª ed.). Pearson Prentice Hall. 
- Tversky, A., & Kahneman, D. (1974). Judgment under uncertainty: Heuristics and biases. Science, 185(4157), 1124-1131. 
- Miller, M. (2014). Personal Finance for Dummies. Wiley. 
- Sullivan, S. (2020). Mobile App Development: A Complete Guide for Beginners. TechWorld Publishing. 
- Olaverri-Monreal, C., & Kerzner, H. (2018). Estudios y aplicaciones tecnológicas en la gestión de proyectos. Springer-Verlag. 
- Bowers, E. (2019). Financial Technology: New Advances in Personal Finance Management. Journal of Financial Technology, 2(3), 45-58. 
- Google Vision OCR. (2021). Recuperado de <https://cloud.google.com/vision>  
- Apple Developer Documentation (2021). Core Data for iOS <https://developer.apple.com/documentation/coredata>  
# <a name="_page16_x85.05_y497.67"></a>**Anexos** 
Anexo 01 Informe de Factibilidad 

Anex0 02   Documento de Visión 

Anexo 03 Documento SRS 

Anexo 04 Documento SAD 

Anexo 05 Manuales y otros documentos 
17 
