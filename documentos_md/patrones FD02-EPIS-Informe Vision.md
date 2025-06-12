![](/documentos_md/img/Aspose.Words.de904471-d246-4f5d-b372-a9390722b9c5.001.png)

**UNIVERSIDAD PRIVADA DE TACNA** 

**FACULTAD DE INGENIERÍA** 

**Escuela Profesional de Ingeniería de Sistemas** 

***“App de Gestión Financiera para el Registro y Análisis de Gastos Personales”*** 

Curso: Patrones de Software  Docente: *Ing. Patrick Cuadros* 

Integrantes: 

***Ayma Choque, Erick Yoel (2021072616) \
Poma Machicado, Fabiola Estefani (2021070030) Tapia Vargas, Dylan Yariet (2021072630)*** 

**Tacna – Perú** 

***2025***

![](/documentos_md/img/Aspose.Words.de904471-d246-4f5d-b372-a9390722b9c5.002.png)
|CONTROL DE VERSIONES ||||||
| - | :- | :- | :- | :- | :- |
|Versión |Hecha por |Revisada por |Aprobada por |Fecha |Motivo |
|1\.0 |MPV |PC |PC |11/06/2025 |Versión Original |

**App de Gestión Financiera para el Registro y Análisis de Gastos Personales** 

**Documento de Visión** 

**Versión *{1.0}*** 



|CONTROL DE VERSIONES ||||||
| - | :- | :- | :- | :- | :- |
|Versión |Hecha por |Revisada por |Aprobada por |Fecha |Motivo |
|1\.0 |MPV |ELV |ARV |19/03/2025 |Versión Original |

**ÍNDICE GENERAL** 

1. [**Introducción  4](#_page3_x85.05_y70.85)** 
1. [Propósito  4](#_page3_x85.05_y358.51) 
1. [Alcance  4](#_page3_x85.05_y477.26) 
1. [Definiciones, Siglas y Abreviaturas  5](#_page4_x85.05_y70.85) 
1. [Referencias  5](#_page4_x85.05_y294.06) 
1. [Visión General  6](#_page5_x85.05_y70.85) 
2. [**Posicionamiento  6](#_page5_x85.05_y373.00)** 
   1. [Oportunidad de negocio  6](#_page5_x85.05_y388.81) 
   1. [Definición del problema  7](#_page6_x85.05_y70.85) 
3. [**Descripción de los interesados y usuarios  7](#_page6_x85.05_y408.47)** 
1. [Resumen de los interesados  7](#_page6_x85.05_y424.28) 
1. [Resumen de los usuarios  8](#_page7_x85.05_y70.85) 
1. [Entorno de usuario  8](#_page7_x85.05_y369.00) 
1. [Perfiles de los interesados  9](#_page8_x85.05_y70.85) 
1. [Perfiles de los Usuarios  9](#_page8_x85.05_y443.95) 
1. [Necesidades de los interesados y usuarios  10](#_page9_x85.05_y70.85) 
4. [**Vista General del Producto  11](#_page10_x85.05_y70.85)** 
1. [Perspectiva del producto  11](#_page10_x85.05_y86.66) 
1. [Resumen de capacidades  11](#_page10_x85.05_y367.83) 
1. [Suposiciones y dependencias  12](#_page11_x85.05_y321.72) 
1. [Costos y precios  13](#_page12_x85.05_y70.85) 
1. [Licenciamiento e instalación  13](#_page12_x85.05_y474.47) 
5. [**Características del producto  14](#_page13_x85.05_y70.85)** 
5. [**Restricciones  14](#_page13_x85.05_y210.58)** 
5. [**Rangos de calidad  14](#_page13_x85.05_y357.70)** 
5. [**Precedencia y Prioridad  14](#_page13_x85.05_y490.85)** 
5. [**Otros requerimientos del producto  15](#_page14_x85.05_y70.85)** 
1. [Estándares legales  15](#_page14_x85.05_y86.66) 
1. [Estándares de comunicación  15](#_page14_x85.05_y168.43) 
1. [Estándares de cumplimiento de la plataforma  15](#_page14_x85.05_y221.22) 
1. [Estándares de calidad y seguridad  15](#_page14_x85.05_y288.50) 
10. [**Conclusiones  15](#_page14_x85.05_y386.27)** 
1. Introducción<a name="_page3_x85.05_y70.85"></a> 

` `En la actualidad, la gestión financiera personal es un aspecto crucial para lograr estabilidad económica y una mejor calidad de vida. Sin embargo, muchas personas enfrentan dificultades al administrar sus ingresos y gastos de manera eficiente, lo que puede derivar en problemas como el sobreendeudamiento, la falta de ahorros y una planificación deficiente de sus recursos. 

El avance de la tecnología ha permitido el desarrollo de herramientas digitales que facilitan la organización de las finanzas personales. Sin embargo, muchas de estas soluciones son genéricas y no se adaptan a las necesidades específicas de los usuarios, lo que limita su efectividad. 

Este proyecto propone el desarrollo de una aplicación móvil de gestión financiera que permita a los usuarios registrar y analizar sus gastos de manera sencilla e intuitiva. A través de funcionalidades como la categorización de ingresos y egresos, reportes detallados, gráficos interactivos y un sistema de escaneo de boletas, la aplicación ofrecerá una solución integral para mejorar el control del dinero y facilitar la toma de decisiones financieras informadas. 

1. Propósito<a name="_page3_x85.05_y358.51"></a> 

   El propósito de esta aplicación es proporcionar a los usuarios una herramienta eficiente y accesible para la gestión de sus finanzas personales. La aplicación permitirá registrar ingresos, generar reportes detallados y visualizar patrones de gasto, facilitando la toma de decisiones informadas sobre el manejo del dinero. Además, busca fomentar hábitos financieros saludables y mejorar la planificación económica de los usuarios. 

2. Alcance<a name="_page3_x85.05_y477.26"></a> 

   La aplicación estará diseñada para dispositivos móviles y permitirá a los usuarios: 

- Registrar ingresos categorizados. 
- Visualizar gráficos y reportes detallados sobre sus finanzas. 
- Visualizar detalladamente sus gastos por categorías. 
- Utilizar un sistema de escaneo de boletas para registrar gastos automáticamente mediante fotos e ingreso manual de texto. 
- Configurar alertas y recomendaciones personalizadas basadas en patrones de gasto. 
- Exportar datos financieros para su análisis externo. 

El sistema será desarrollado para dispositivos Android, con una interfaz intuitiva y segura para el manejo de la información financiera del usuario. 

3. Definiciones,<a name="_page4_x85.05_y70.85"></a> Siglas y Abreviaturas 

   **Gestión financiera personal:** Proceso de administrar los ingresos, gastos, ahorros e inversiones de una persona. 

   **Egresos:** Dinero que una persona gasta en bienes o servicios. 

   **Ingresos:** Dinero que una persona recibe, ya sea por salario, inversiones u otras fuentes. 

   **IA (Inteligencia Artificial)**: Conjunto de técnicas que permiten a los sistemas informáticos realizar tareas que normalmente requieren inteligencia humana. En este proyecto, la IA se utiliza para procesar automáticamente documentos y extraer información relevante para el registro de gastos. 

   **UI/UX:** Diseño de la Interfaz de Usuario (UI) y Experiencia de Usuario (UX), clave para la facilidad de uso de la aplicación. 

4. Referencias<a name="_page4_x85.05_y294.06"></a> 

   El manejo adecuado de las finanzas personales es un factor clave para la estabilidad económica y la toma de decisiones informadas. Sin embargo, la falta de educación financiera puede llevar a comportamientos perjudiciales que afectan la calidad de vida de los individuos. Según González et al. (2023), "La educación financiera es un componente fundamental para una vida financiera saludable y sostenible; de manera que, la falta de conocimiento financiero conduce a comportamientos financieros perjudiciales y de exclusión, limitando oportunidades y disminuyendo la calidad de vida." (p. 72). 

   Para abordar esta problemática, se han desarrollado herramientas digitales que facilitan la administración del dinero. Ramírez (2020) propone que una solución efectiva es el desarrollo de un aplicativo móvil que permita al usuario registrar sus gastos personales, establecer límites y personalizar categorías con el objetivo de mejorar la gestión financiera. 

   El impacto de las aplicaciones móviles en la administración de finanzas personales ha sido ampliamente reconocido. Como señala Claves Financieras (s.f.), "En el mundo actual, la gestión de finanzas personales ha evolucionado gracias a las aplicaciones móviles. Estas aplicaciones no solo ayudan a controlar los gastos, sino que también facilitan la planificación financiera y la inversión." 

   Además, el uso de dispositivos móviles para la gestión financiera ha crecido exponencialmente en los últimos años. Un estudio de The Insight Partners (s.f.) revela que "los usuarios de teléfonos inteligentes descargan aproximadamente tres aplicaciones de finanzas personales en sus dispositivos móviles, y 4 de cada 10 utilizan sus dispositivos para gestionar las finanzas, consultar el historial de cuentas, realizar un seguimiento de las inversiones y pagar facturas, entre otras actividades financieras." 

5. Visión<a name="_page5_x85.05_y70.85"></a> General 

   La aplicación de gestión de finanzas personales permitirá a los usuarios registrar y monitorear sus gastos de manera automática mediante el escaneo de facturas y boletas con la cámara del celular. A diferencia de tecnologías tradicionales como el OCR, esta aplicación utilizará Inteligencia Artificial basada en reconocimiento de imágenes para identificar y extraer datos relevantes, como productos, precios, fechas y totales, de forma precisa y eficiente. 

   El sistema organizará automáticamente esta información, facilitando al usuario el seguimiento de sus egresos, la visualización de su historial de gastos, el establecimiento de presupuestos y el mejoramiento de su administración financiera. 

   El producto estará diseñado para ofrecer una experiencia de usuario intuitiva, segura y eficiente, garantizando la privacidad de los datos personales y permitiendo su integración con otras herramientas financieras. La aplicación estará disponible para dispositivos Android y ofrecerá funcionalidades adicionales como reportes visuales, alertas de gasto y análisis de comportamiento financiero. 

2. Posicionamiento<a name="_page5_x85.05_y373.00"></a> 
1. Oportunidad<a name="_page5_x85.05_y388.81"></a> de negocio 

   En la era digital, el manejo de las finanzas personales continúa siendo un reto para muchas personas. A pesar de la amplia oferta de herramientas financieras, gran parte de los usuarios no tiene el hábito de registrar sus gastos, lo que dificulta el control efectivo de sus finanzas. 

   La implementación de Inteligencia Artificial con capacidades de reconocimiento de imágenes abre una nueva oportunidad de negocio. Esta tecnología permite automatizar el proceso de extracción de datos desde boletas y facturas físicas sin necesidad de ingreso manual, eliminando fricciones y mejorando significativamente la experiencia del usuario. 

   La aplicación se orienta a personas que desean gestionar sus finanzas de manera práctica, sin invertir demasiado tiempo en el registro de gastos. Asimismo, puede resultar atractiva para pequeños negocios o emprendedores que buscan una solución moderna, ágil y accesible para monitorear sus ingresos y egresos. Esta combinación de automatización inteligente y facilidad de uso posiciona al producto como una herramienta innovadora y con alto potencial de adopción. 

2. Definición<a name="_page6_x85.05_y70.85"></a> del problema 

   Problema: A pesar del creciente acceso a herramientas digitales, muchas personas continúan enfrentando dificultades para registrar y controlar sus gastos diarios de manera eficiente, lo que puede derivar en desorganización financiera y decisiones económicas poco informadas. 

- Falta de visibilidad sobre los hábitos de consumo: Los usuarios no cuentan con información clara ni consolidada sobre en qué y cómo gastan su dinero. 
- Dificultad para establecer presupuestos y alcanzar objetivos de ahorro: La ausencia de datos estructurados impide generar metas financieras realistas y controlar el cumplimiento de las mismas. 
- Pérdida de control sobre los ingresos y egresos personales: Sin un seguimiento constante, es común que las personas pierdan el equilibrio entre lo que ganan y lo que gastan. 
- Tiempo y esfuerzo en el registro manual de gastos: Registrar cada gasto manualmente resulta tedioso y poco sostenible en el tiempo, desmotivando a los usuarios a mantener un control financiero activo. 
3. Descripción<a name="_page6_x85.05_y408.47"></a> de los interesados y usuarios 
1. Resumen<a name="_page6_x85.05_y424.28"></a> de los interesados 

   Los interesados en el desarrollo de la aplicación comprenden todas aquellas partes que influyen directa o indirectamente en el éxito del proyecto, o que se verán beneficiadas por su implementación tales como. 

- Equipo de desarrollo: Responsable del diseño, desarrollo, pruebas, despliegue y mantenimiento de la aplicación. Su trabajo garantiza la funcionalidad, estabilidad y escalabilidad del producto. 
- Inversores: Personas o entidades que financian el proyecto con la expectativa de obtener beneficios económicos. Están interesados en la viabilidad comercial y el retorno de inversión. 
- Usuarios finales: Individuos que utilizarán la aplicación para gestionar sus finanzas personales. Su satisfacción, adopción y retroalimentación son claves para el éxito y mejora continua del producto. 
- Entidades externas: Instituciones financieras, comercios o proveedores de servicios que podrían integrarse con la aplicación, ya sea para compartir datos, ofrecer servicios complementarios o generar alianzas estratégicas. 
2. Resumen<a name="_page7_x85.05_y70.85"></a> de los usuarios 

   La aplicación está dirigida a usuarios que desean mejorar su gestión financiera diaria sin recurrir al registro manual de gastos. Se prioriza una experiencia accesible, automatizada y visualmente clara, adecuada para distintos perfiles de usuarios. 

- Usuarios individuales: Personas que desean llevar un control detallado de sus gastos personales, identificar patrones de consumo y mejorar sus hábitos financieros. 
- Emprendedores y pequeños negocios: Usuarios que necesitan una herramienta simple pero efectiva para registrar ingresos y egresos, sin la complejidad de un sistema contable tradicional. 
- Usuarios con poca experiencia en finanzas: Personas que no cuentan con conocimientos financieros avanzados y requieren una interfaz intuitiva, fácil de usar y con orientación visual para facilitar el entendimiento de su situación económica. 
3. Entorno<a name="_page7_x85.05_y369.00"></a> de usuario 

   La aplicación será utilizada principalmente en dispositivos móviles con sistemas operativos Android. 

- Plataforma: La aplicación será compatible principalmente con dispositivos móviles Android, aprovechando sus capacidades y características específicas para un rendimiento fluido y eficiente. 
- Conectividad: Se requiere una conexión a Internet para la sincronización de datos y el respaldo de la información en la nube. Sin embargo, algunas funciones, como el escaneo y el registro local de gastos, estarán disponibles sin conexión, lo que permite su uso en cualquier momento y lugar. 
- Condiciones de uso: El uso de la aplicación puede variar según las necesidades del usuario. Se contempla un uso ocasional para escanear boletas o facturas y registrar los datos de forma automática, o un uso frecuente para monitorear las finanzas personales, revisar reportes y establecer presupuestos de manera continua. 
4. Perfiles<a name="_page8_x85.05_y70.85"></a> de los interesados 
- Equipo de Desarrollo 
  - Responsabilidades: Encargados del diseño, desarrollo, pruebas e implementación de la aplicación. Su labor asegura que la aplicación funcione correctamente en diversas plataformas, sea escalable y proporcione una experiencia de usuario óptima. 
  - Objetivos: Garantizar que la aplicación sea robusta, fácil de usar y capaz de integrarse bien con otros sistemas. Están enfocados en asegurar la estabilidad del producto a largo plazo y en mejorar continuamente la experiencia del usuario mediante actualizaciones y nuevas funcionalidades. 
- Usuarios Finales 
- Responsabilidades: Personas que utilizarán la aplicación para gestionar sus finanzas personales de manera eficaz. Estos usuarios pueden ser desde individuos que desean registrar sus gastos hasta emprendedores que buscan controlar las finanzas de su negocio. 
- Objetivos: Buscan una solución intuitiva, rápida y segura para el control de sus gastos, la visualización de su flujo de dinero y la mejora de sus hábitos financieros. Se espera que el sistema proporcione datos precisos y herramientas fáciles de usar para alcanzar sus metas económicas. 
5. Perfiles<a name="_page8_x85.05_y443.95"></a> de los Usuarios Usuario Individual 
- Descripción: Persona que busca organizar y gestionar sus gastos personales de manera eficiente. 
- Características: Generalmente no utiliza herramientas financieras avanzadas ni sistemas complicados. Prefiere una solución simple y accesible que no requiera conocimientos financieros previos. 
- Objetivos: Desea una herramienta automatizada que registre y analice sus gastos sin necesidad de introducir datos manualmente. Busca facilidad de uso, rapidez y precisión, y valora una interfaz intuitiva que le permita llevar el control de sus finanzas de manera eficiente. 
6. Necesidades<a name="_page9_x85.05_y70.85"></a> de los interesados y usuarios Interesados 
- Equipo de Desarrollo: Necesita contar con requisitos claros y especificaciones detalladas para desarrollar la aplicación de manera eficiente. Además, requiere tecnologías adecuadas y actualizadas que garanticen el rendimiento, escalabilidad y mantenimiento del sistema. 
- Inversores: Requieren un modelo de negocio sólido y viable que asegure la rentabilidad a largo plazo. También buscan proyecciones claras de crecimiento y expansión del producto en el mercado. 
- Entidades: Las instituciones financieras y otras posibles entidades colaboradoras buscan que la aplicación sea compatible con sus sistemas y que garantice un alto nivel de seguridad y protección de los datos al integrarse con sus plataformas. 

Usuarios 

- Facilidad de uso: La aplicación debe ser extremadamente intuitiva, con una interfaz sencilla y fácil de navegar. Los usuarios, independientemente de su nivel de conocimiento financiero, deben poder registrar, revisar y analizar sus gastos sin complicaciones. 
- Automatización: La aplicación debe permitir el escaneo automático de boletas, facturas y otros documentos financieros, extrayendo datos clave (como productos, precios y totales) sin que el usuario tenga que ingresar esta información manualmente. 
- Reportes y análisis: Los usuarios requieren reportes visuales y análisis claros sobre sus ingresos y egresos. La información debe estar presentada de manera comprensible, permitiendo a los usuarios tener una visión rápida y precisa de su situación financiera. 
- Seguridad: La protección de los datos personales y financieros debe ser una prioridad. La aplicación debe implementar medidas de seguridad robustas, como cifrado de datos y autenticación segura, para garantizar que la información del usuario esté protegida en todo momento. 
4. Vista<a name="_page10_x85.05_y70.85"></a> General del Producto 
1. Perspectiva<a name="_page10_x85.05_y86.66"></a> del producto 

   La aplicación de gestión de finanzas personales se posiciona como una solución innovadora que permite a los usuarios registrar y monitorear sus gastos de manera automática mediante el escaneo de facturas y boletas. Utilizando Inteligencia Artificial para el reconocimiento de imágenes, el sistema extrae de manera precisa y eficiente la información relevante, como productos, precios y totales, y la organiza automáticamente en categorías, eliminando la necesidad de ingresar datos manualmente. 

   El producto competirá con aplicaciones tradicionales de gestión de gastos, pero se diferenciará por su enfoque en la automatización inteligente, lo que simplifica el proceso y reduce la intervención del usuario. Además, su capacidad para generar y exportar reportes financieros hace que la aplicación sea una herramienta versátil tanto para usuarios individuales como para pequeños emprendedores, ayudándoles a llevar un control financiero más efectivo y sin esfuerzo. 

2. Resumen<a name="_page10_x85.05_y367.83"></a> de capacidades 

   La aplicación contará con las siguientes funcionalidades clave: 

   Escaneo y Reconocimiento de Facturas y Boletas 

- Uso de Inteligencia Artificial para el reconocimiento de imágenes, permitiendo la extracción automática de datos relevantes como productos, precios, totales, y fechas de las facturas y boletas. 
- Compatibilidad con distintos formatos de documentos, como imágenes ,y texto plano  asegurando flexibilidad en el tipo de recibos y boletas que se pueden escanear. 

Registro y Categorización de Gastos 

- Organización automática de los gastos en categorías predefinidas, facilitando el control y análisis de los egresos. 
- Posibilidad de personalizar etiquetas y categorías según las necesidades del usuario, permitiendo una organización más adaptada a sus hábitos de consumo. 

Generación de Reportes y Estadísticas 

- Visualización de tendencias de gasto mediante gráficos interactivos e informes detallados que facilitan la comprensión de los patrones de consumo. 
- Análisis mensual de ingresos y egresos, proporcionando una visión clara de la salud financiera del usuario y ayudando a la toma de decisiones informadas. 

Gestión de Presupuestos 

- Creación de límites de gasto por categoría, permitiendo a los usuarios establecer objetivos financieros para controlar sus egresos. 
- Alertas automáticas cuando los usuarios superan los presupuestos establecidos, ayudando a mantener el control sobre sus finanzas. 

Exportación e Integración 

- Generación de reportes en formatos PDF o CSV para facilitar la visualización, análisis y archivo de los datos financieros. 
 
3. Suposiciones<a name="_page11_x85.05_y321.72"></a> y dependencias 

   **Suposiciones:** 

- Se espera que los usuarios cuenten con un dispositivo móvil con cámara funcional, ya que el escaneo de boletas y facturas es una característica principal de la aplicación. 
- La aplicación requerirá una conexión a Internet para procesar las imágenes mediante modelos de Inteligencia Artificial, que permiten la extracción automática de datos relevantes. 
- Los usuarios aceptarán los términos de uso y las políticas de privacidad al momento de instalar y utilizar la aplicación, incluyendo el manejo seguro de su información financiera. 

**Dependencias:** 

- Dependencia de servicios de procesamiento en la nube o APIs de IA para el reconocimiento de datos desde imágenes. 
- Dependencia de bibliotecas y frameworks actualizados para el desarrollo móvil en Android. 
- Posible dependencia de servicios externos para el almacenamiento seguro de datos y generación de reportes (por ejemplo, servicios de bases de datos en la nube o generación de archivos PDF/CSV). 
4. Costos<a name="_page12_x85.05_y70.85"></a> y precios 

La aplicación adoptará un modelo de negocio basado en dos planes: **Básico** y **Premium**, permitiendo a los usuarios elegir según sus necesidades de gestión financiera. 

- **Versión Gratuita** 
  - Acceso a funciones básicas  de registros de gatos 
  - Categorización automática de gastos. 
  - Visualización de reportes básicos mensuales. 
  - Inclusión de anuncios publicitarios dentro de la aplicación. 
- **Suscripción Premium (Pago Mensual)** 
  - Acceso a reportes avanzados, gráficos comparativos y análisis detallado de ingresos y egresos. 
  - Acceso a funciones esenciales como el escaneo de boletas y facturas mediante IA. 
  - Exportación de datos en múltiples formatos (PDF, CSV). 
  - Eliminación total de publicidad para una experiencia más fluida. 
  - Funcionalidades adicionales como alertas personalizadas y gestión de presupuestos avanzados. 
5. Licenciamiento<a name="_page12_x85.05_y474.47"></a> e instalación **Licenciamiento:** 
- La aplicación se distribuirá bajo un modelo de **licencia de usuario final (EULA)**, detallando el uso permitido y las restricciones del software. 
- Se respetarán normativas de privacidad como **GDPR y CCPA**, asegurando la protección de datos de los usuarios. 
- El código fuente y la tecnología utilizada estarán sujetos a derechos de propiedad intelectual. 

**Instalación:** 

- Disponible en **Google Play Store** (Android). 
- Proceso de instalación estándar a través de las tiendas oficiales. 
- Actualizaciones automáticas para mejorar la funcionalidad y seguridad. 
5. Características<a name="_page13_x85.05_y70.85"></a> del producto 
- Escaneo de facturas y boletas mediante API gemini. 
- Categorización automática de gastos. 
- Reportes gráficos y análisis de tendencias de gasto. 
- Establecimiento de presupuestos y alertas de sobrepaso. 
- Almacenamiento seguro con opción de exportación. 
- Sincronización entre dispositivos. 
- Interfaz intuitiva y amigable. 
6. Restricciones<a name="_page13_x85.05_y210.58"></a> 
- La aplicación sólo funcionará en dispositivos móviles con **Android 10+**  
- Se requiere acceso a Internet para la sincronización y procesamiento de imágenes mediante una API de análisis (Gemini). 
- La precisión del procesamiento dependerá de la calidad de la imagen y del formato del documento. 
- Cumplimiento con las políticas de las tiendas de aplicaciones. 
7. Rangos<a name="_page13_x85.05_y357.70"></a> de calidad 
- **Precisión del procesamiento:** Se buscará una tasa de reconocimiento superior al 99% en facturas y boletas estándar.** 
- **Tiempo de respuesta:** La extracción de datos no deberá superar los **5 segundos** por documento. 
- **Interfaz de usuario:** Debe ser intuitiva, con un tiempo de aprendizaje menor a **5 minutos**. 
8. Precedencia<a name="_page13_x85.05_y490.85"></a> y Prioridad 
- **Reconocimiento de datos mediante IA desde facturas y boletas** *(Alta prioridad)* 

  ` `Base fundamental del producto. Permite extraer automáticamente información relevante desde imágenes capturadas por la cámara del dispositivo. 

- **Categorización automática de gastos** *(Alta prioridad)* 

  ` `Esencial para facilitar al usuario la organización de sus finanzas personales sin necesidad de intervención manual. 

- **Reportes y estadísticas visuales** *(Media prioridad)* 

  ` `Mejora significativa de la experiencia del usuario, permitiendo una mejor comprensión de sus hábitos financieros. 

- **Gestión de presupuestos con alertas** *(Media prioridad)* 

  ` `Funcionalidad de valor agregado para usuarios que desean un mayor control de sus gastos mensuales. 

9. Otros<a name="_page14_x85.05_y70.85"></a> requerimientos del producto 
1. Estándares<a name="_page14_x85.05_y86.66"></a> legales 
- Cumplimiento con **GDPR (Unión Europea)** y **CCPA (California, EE.UU.)** para protección de datos. 
- Normativas locales sobre almacenamiento y gestión de datos financieros. 
2. Estándares<a name="_page14_x85.05_y168.43"></a> de comunicación 
- Uso de **HTTPS/TLS 1.2+** para la transmisión segura de datos. 
- API REST para integraciones con otros servicios financieros. 
3. Estándares<a name="_page14_x85.05_y221.22"></a> de cumplimiento de la plataforma 
- Cumplimiento con **Google Play Developer Policies** y **App Store Review Guidelines**. 
- Uso de SDKs aprobados por Apple y Google. 
4. Estándares<a name="_page14_x85.05_y288.50"></a> de calidad y seguridad 
- Implementación de **autenticación multifactor (MFA)** para acceso seguro. 
- Evaluaciones periódicas de seguridad para detectar vulnerabilidades. 
10. Conclusiones<a name="_page14_x85.05_y386.27"></a> 

Este documento establece los requisitos para el desarrollo de una aplicación innovadora de gestión de finanzas personales, basada en la automatización mediante Inteligencia Artificial para el reconocimiento de imágenes. Su objetivo es proporcionar una experiencia intuitiva, segura y eficiente, permitiendo a los usuarios optimizar el control de sus finanzas sin necesidad de ingresar datos manualmente. 

La solución integra tecnologías avanzadas de procesamiento de imágenes y aprendizaje automático para identificar y categorizar transacciones financieras de manera precisa. Esto reduce la carga operativa del usuario, minimiza errores y facilita una visión clara de su estado financiero en tiempo real. 

Además, la aplicación prioriza la seguridad y privacidad de los datos, implementando medidas robustas de protección para garantizar la confidencialidad de la información. Con una interfaz intuitiva y un diseño centrado en la experiencia del usuario, esta herramienta busca transformar la manera en que las personas gestionan sus recursos económicos, promoviendo una mayor estabilidad y planificación financiera. 

11. Recomendaciones 
    1. Realizar pruebas de usabilidad con usuarios reales para identificar oportunidades de mejora en la experiencia de usuario (UX). 
    1. Invertir en la optimización de los modelos de IA para asegurar una alta precisión en el reconocimiento de productos, precios y totales desde facturas y boletas. 
    1. Explorar alianzas estratégicas con entidades financieras, bancos o fintechs que puedan aportar valor mediante integraciones futuras, como sincronización de cuentas o automatización de ingresos. 
11. Bibliografía 

Claves Financieras. (s.f.). Comparativa de las aplicaciones de finanzas más populares. Recuperado de Claves Financieras 

González, M., Pérez, L., & Torres, J. (2023). Educación financiera desde un enfoque cienciométrico y revisión sistemática. Revista Peruana de Educación Financiera, 12(1), 65-80. 

Ramírez, P. (2020). Desarrollo de un aplicativo móvil para la gestión financiera personal (Tesis de maestría). Pontificia Universidad Católica del Ecuador. 

The Insight Partners. (s.f.). Panorama y alcance del mercado de aplicaciones de finanzas personales. Recuperado de The Insight Partners 

[https://www.canva.com/design/DAGiUDufhxo/dEBuxOEu2pg8awF9k8aEpA/edit?utm_ content=DAGiUDufhxo&utm_campaign=designshare&utm_medium=link2&utm_sourc e=sharebutton](https://www.canva.com/design/DAGiUDufhxo/dEBuxOEu2pg8awF9k8aEpA/edit?utm_content=DAGiUDufhxo&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)  

![](/documentos_md/img/Aspose.Words.de904471-d246-4f5d-b372-a9390722b9c5.003.jpeg)
17 
