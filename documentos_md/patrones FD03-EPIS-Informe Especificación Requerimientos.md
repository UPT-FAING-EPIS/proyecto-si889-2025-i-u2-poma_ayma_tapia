![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.001.png)

**UNIVERSIDAD PRIVADA DE TACNA** 

**FACULTAD DE INGENIERÍA** 

**Escuela Profesional de Ingeniería de Sistemas** 

` `**“App de Gestión Financiera para el Registro y Análisis de Gastos Personales”** 

Curso: Patrones de Software  Docente: Ing. Patrick Cuadros 

Integrantes: 

***Ayma Choque, Erick Yoel (2021072616) \
Poma Machicado, Fabiola Estefani (2021070030) Tapia Vargas, Dylan Yariet (2021072630)*** 

**Tacna – Perú *2025*** 

![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.002.png)
|CONTROL DE VERSIONES ||||||
| - | :- | :- | :- | :- | :- |
|Versión |Hecha por |Revisada por |Aprobada por |Fecha |Motivo |
|1\.0 |MPV |ELV |ARV |11/06/2025 |Versión Original |
# **App de Gestión Financiera para el Registro y Análisis de Gastos Personales** 
# **Documento de Especificación de Requerimientos de Software** 
# **Versión *{1.0}*** 
**ÍNDICE GENERAL** 

[**INTRODUCCIÓN..........................................................................................................4**](#_page3_x85.05_y70.85)

1. [**Generalidades de la Empresa..................................................................................4**](#_page3_x85.05_y94.66)
1. [Nombre de la Empresa........................................................................................ 4](#_page3_x85.05_y110.47)
1. [Visión...................................................................................................................4](#_page3_x85.05_y158.08)
1. [Misión..................................................................................................................4](#_page3_x85.05_y237.31)
1. [Organigrama........................................................................................................ 4](#_page3_x85.05_y316.55)
2. [**Visionamiento de la Empresa................................................................................. 4**](#_page3_x85.05_y565.52)
1. [Descripción del Problema....................................................................................4](#_page3_x85.05_y589.32)
1. [Objetivos de Negocios......................................................................................... 5](#_page4_x85.05_y70.85)
1. [Objetivos de Diseño.............................................................................................5](#_page4_x85.05_y181.51)
1. [Alcance del Proyecto............................................................................................5](#_page4_x85.05_y339.97)
1. [Viabilidad del Sistema..........................................................................................6](#_page5_x85.05_y94.66)
1. [Información obtenida del Levantamiento de Información.................................. 6](#_page5_x85.05_y290.56)
3. [**Análisis de Procesos............................................................................................... 6**](#_page5_x85.05_y338.18)
1. [Diagrama del Proceso Actual – Diagrama de Actividades....................................6](#_page5_x85.05_y353.99)
1. [Diagrama del Proceso Propuesto – Diagrama de Actividades Inicial...................6](#_page5_x85.05_y521.01)
4. [**Especificación de Requerimientos de Software.......................................................7**](#_page6_x85.05_y70.85)
1. [Cuadro de Requerimientos Funcionales Inicial....................................................7](#_page6_x85.05_y86.66)
1. [Cuadro de Requerimientos No Funcionales.........................................................8](#_page7_x85.05_y94.66)
1. [Cuadro de Requerimientos Funcionales Final......................................................9](#_page8_x85.05_y70.85)
1. [Reglas de Negocio..............................................................................................11](#_page10_x85.05_y70.85)
5. [**Fase de Desarrollo................................................................................................12**](#_page11_x85.05_y70.85)
1. [Perfiles de Usuario.............................................................................................12](#_page11_x85.05_y86.66)
1. [Modelo Conceptual........................................................................................... 12](#_page11_x85.05_y276.55)
1. [Diagrama de Paquetes...............................................................................12](#_page11_x85.05_y300.36)
1. [Diagrama de Casos de Uso.........................................................................13](#_page12_x85.05_y70.85)
1. [Escenarios de Caso de Uso (Narrativa)...................................................... 14](#_page13_x85.05_y70.85)
3. [Modelo Lógico................................................................................................... 23](#_page22_x85.05_y87.70)
1. [Análisis de Objetos.....................................................................................23](#_page22_x85.05_y111.50)
1. [Diagrama de Actividades con Objetos....................................................... 26](#_page25_x85.05_y70.85)
1. [Diagrama de Secuencia..............................................................................27](#_page26_x85.05_y70.85)

[1. Secuencia de Autenticación...........................................................................27](#_page26_x85.05_y94.66) 

4. [Diagrama de Clases....................................................................................29](#_page28_x85.05_y540.38)

[**CONCLUSIONES........................................................................................................ 30** ](#_page29_x85.05_y70.85)[RECOMENDACIONES................................................................................................ 30** ](#_page29_x85.05_y450.82)[BIBLIOGRAFÍA.......................................................................................................... 31**](#_page30_x85.05_y70.85)
# <a name="_page3_x85.05_y70.85"></a>INTRODUCCIÓN 
1. Generalidades<a name="_page3_x85.05_y94.66"></a> de la Empresa 
1. Nombre<a name="_page3_x85.05_y110.47"></a> de la Empresa Financiera Confianza 
1. Visión<a name="_page3_x85.05_y158.08"></a> 

   Ser la institución financiera más confiable para las MYPES y emprendedores del Perú, impulsando su crecimiento con soluciones digitales innovadoras y accesibles. 

3. Misión<a name="_page3_x85.05_y237.31"></a> 

   Brindar servicios financieros inclusivos y herramientas tecnológicas que mejoren la gestión económica de nuestros clientes, promoviendo la educación financiera y el desarrollo sostenible. 

4. Organigrama<a name="_page3_x85.05_y316.55"></a> 

   ![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.003.png)

2. Visionamiento<a name="_page3_x85.05_y565.52"></a> de la Empresa 
1. Descripción<a name="_page3_x85.05_y589.32"></a> del Problema 
- Financiera Confianza actualmente ofrece préstamos y servicios básicos de ahorro, pero enfrenta los siguientes desafíos: 
- Falta de control financiero en sus clientes: El 65% de sus usuarios (según encuesta interna, 2023) no lleva un registro organizado de sus gastos. 
- App limitada: Su aplicación móvil sólo permite consultar saldos y pagar préstamos, sin herramientas de análisis de gastos. 
- Alta morosidad: Muchos clientes no planifican sus finanzas, lo que aumenta el riesgo de impagos. 
2. Objetivos<a name="_page4_x85.05_y70.85"></a> de Negocios 
   1. Reducir la morosidad en un 20% mediante educación financiera integrada en la app. 
   1. Aumentar la retención de clientes ofreciendo una herramienta de gestión financiera personalizada. 
   1. Posicionarse como líder en innovación fintech en el sector microfinanciero peruano. 
2. Objetivos<a name="_page4_x85.05_y181.51"></a> de Diseño 
- Interfaz simple y en español. 
- Escaneo inteligente de boletas con IA (Gemini API) para registro automático. 
- Alertas personalizadas ("Estás gastando 30% más en alimentos este mes"). 
- Sincronización con cuentas de Financiera Confianza para unificar egresos. 
4. Alcance<a name="_page4_x85.05_y339.97"></a> del Proyecto 

   El proyecto busca desarrollar una aplicación financiera para Financiera Confianza, con el objetivo de mejorar la gestión económica de sus clientes a través de herramientas digitales innovadoras. La plataforma permitirá registrar gastos, visualizar análisis financieros y administrar ahorros y deudas, facilitando una mejor planificación económica. 

   Entre sus principales funciones se incluyen la autenticación segura de usuarios, el registro de gastos manuales y automatizados mediante escaneo de facturas con inteligencia artificial, la creación de presupuestos mensuales y el establecimiento de límites de gasto diario con alertas personalizadas. Además, se generarán reportes financieros con gráficos interactivos para ayudar a los usuarios a tomar decisiones informadas sobre sus finanzas. 

   El sistema también integrará notificaciones inteligentes, enviando alertas sobre vencimientos de pagos y posibles excesos en los presupuestos establecidos. Sincroniza los datos con las cuentas de Financiera Confianza, permitiendo una visión unificada de ingresos y egresos. 

   Este proyecto está dirigido a MYPES y emprendedores, quienes podrán optimizar su planificación financiera con mayor facilidad. También beneficiará a los administradores de la entidad, proporcionándoles herramientas de monitoreo y educación financiera para reducir la morosidad. 

5. Viabilidad<a name="_page5_x85.05_y94.66"></a> del Sistema 



|Aspecto |Análisis |
| - | - |
|Técnica |Posible usando: Flutter (app multiplataforma), Firebase (BD), Gemini API. |
|Económica |El equipo de TI de Financiera Confianza ya maneja integraciones con bancos. |
|Legal  |Cumple con la Ley de Protección de Datos (Ley N° 29733) y normativas SBS. |

6. Información<a name="_page5_x85.05_y290.56"></a> obtenida del Levantamiento de Información 
3. Análisis<a name="_page5_x85.05_y338.18"></a> de Procesos 
1. Diagrama<a name="_page5_x85.05_y353.99"></a> del Proceso Actual – Diagrama de Actividades 

![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.004.png)

2. Diagrama<a name="_page5_x85.05_y521.01"></a> del Proceso Propuesto – Diagrama de Actividades Inicial 
4. Especificación<a name="_page6_x85.05_y70.85"></a> de Requerimientos de Software 
1. Cuadro<a name="_page6_x85.05_y86.66"></a> de Requerimientos Funcionales Inicial 



|RF |Requerimiento |Descripción |
| - | - | - |
|RF01 |Iniciar Sesión  |El usuario ingresa email y contraseña para autenticarse.|
|RF02|Registrar Usuario |El usuario crea una cuenta con email, contraseña, nombre, teléfono y foto de perfil. |
|RF03 |Recuperar Contraseña  |El usuario solicita recuperar su contraseña. Luego recibe un correo para cambiarla. |
|RF04 |Editar Perfil |El usuario modifica su información personal y foto de perfil. |
|RF05 |Configurar Gasto Diario |El usuario establece un límite diario de gasto con alertas si se excede. |
|RF06 |Editar Gasto Diario |El usuario modifica el  límite diario de gasto |
|RF07 |Crear Planes de Gastos (Mensuales)  |El usuario establece presupuestos mensuales por categoría. |
|RF08 |Editar Planes  |El usuario modifica presupuestos existentes. |
|RF09 |Alertar Sobre Gasto Excesivo |La app notifica si se sobrepasa un presupuesto. |
|RF10 |Registrar gasto manualmente |El usuario ingresa los datos del gasto manualmente. Luego guarda el registro. |
|RF11 |Registrar gasto por escaneo |El usuario toma o carga una foto del recibo. La app usa IA para extraer y categorizar los datos. El usuario confirma antes de guardar. |
|RF12 |Visualizar Análisis Financiero |El usuario ve gráficos y estadísticas de sus gastos. |
|RF13 |Crear Deudas y Préstamos |El usuario registra deudas pendientes y pagos programados. |
|RF14 |Editar Deudas y Préstamos |El usuario modifica deudas pendientes y pagos programados. |
|RF15 |Notificar Pagos y Vencimientos |La app envía recordatorios sobre pagos próximos. |
|RF16 |Exportar Reportes y Movimientos |El usuario puede  descargar reportes y sus movimientos financieros en formatos Excel y PDF. |

2. Cuadro<a name="_page7_x85.05_y94.66"></a> de Requerimientos No Funcionales 



|RNF |Requerimiento |Descripción |
| - | - | - |
|RNF01 |Rendimiento |El aplicativo debe responder rápidamente en todas las operaciones comunes (registrar transacciones, generar reportes, mostrar gráficos) sin demoras notables, con tiempos de carga no mayores a 2 segundos. |
|RNF02|Seguridad |Los datos del usuario (como contraseñas y transacciones) deben estar protegidos mediante encriptación robusta (como AES-256) y protocolos de seguridad actualizados (como HTTPS y autenticación multifactor). |
|RNF03 |Usabilidad |La interfaz del aplicativo debe ser intuitiva y fácil de usar, permitiendo a los usuarios completar tareas como ingresar transacciones y visualizar reportes sin complicaciones. La navegación debe ser fluida tanto en dispositivos móviles como en escritorio. |
|RNF04 |Escalabilidad |El aplicativo debe ser capaz de manejar un número creciente de usuarios y transacciones sin afectar su rendimiento. Se debe poder escalar en la base de datos y en el manejo de reportes sin comprometer la experiencia del usuario. |
|RNF05 |Disponibilidad |El sistema debe estar disponible la mayor parte del tiempo, con un mínimo de 99.5% de tiempo de funcionamiento sin interrupciones significativas. |
|RNF06 |Mantenimiento |El aplicativo debe permitir actualizaciones y mejoras continuas sin que los usuarios experimenten interrupciones significativas. La implementación de nuevas funcionalidades no debe requerir reescritura del código base. |
|RNF07 |Notificaciones |El aplicativo debe permitir la configuración de notificaciones push para alertas personalizadas (gastos excesivos, presupuesto, pagos recurrentes) que se envíen en tiempo real, asegurando que el usuario esté siempre al tanto de sus finanzas. |

3. Cuadro<a name="_page8_x85.05_y70.85"></a> de Requerimientos Funcionales Final 



|RF |Requerimiento |Descripción |
| - | - | - |
|RF01 |Iniciar Sesión  |El usuario ingresa email y contraseña para autenticarse.|
|RF02|Registrar Usuario|El usuario crea una cuenta con email, contraseña, nombre, teléfono y foto de perfil. |
|RF03 |Recuperar Contraseña  |El usuario solicita recuperar su contraseña. Luego recibe un correo para cambiarla. |
|RF04 |Editar Perfil |El usuario modifica su información personal y foto de perfil. |
|RF05 |Configurar Gasto Diario |El usuario establece un límite diario de gasto con alertas si se excede. |
|RF06 |Editar Gasto Diario |El usuario modifica el  límite diario de gasto |
|RF07 |Crear Planes de Gastos (Mensuales)|El usuario establece presupuestos mensuales por categoría. |
|RF08 |Editar Planes  |El usuario modifica presupuestos existentes. |
|RF09 |Alertar Sobre Gasto Excesivo |La app notifica si se sobrepasa un presupuesto. |
|RF10 |Registrar gasto manualmente |El usuario ingresa los datos del gasto manualmente. Luego guarda el registro. |
|RF11 |Registrar gasto por escaneo |El usuario toma o carga una foto del recibo. La app usa IA para extraer y categorizar los datos. El usuario confirma antes de guardar. |
|RF12 |Visualizar Análisis Financiero |El usuario ve gráficos y estadísticas de sus gastos. |
|RF13 |Crear Deudas y Préstamos |El usuario registra deudas pendientes y pagos programados. |
|RF14 |Editar Deudas y Préstamos |El usuario modifica deudas pendientes y pagos programados. |
|RF15 |Notificar Pagos y Vencimientos |La app envía recordatorios sobre pagos próximos. |
|RF16 |Exportar Reportes y Movimientos |El usuario puede  descargar reportes y sus movimientos financieros en formatos Excel y PDF. |
|RNF01 |Rendimiento |El aplicativo debe responder rápidamente en todas las operaciones comunes (registrar transacciones, generar reportes, mostrar gráficos) sin demoras notables, con tiempos de carga no mayores a 2 segundos. |
|RNF02|Seguridad |Los datos del usuario (como contraseñas y transacciones) deben estar protegidos mediante encriptación robusta (como AES-256) y protocolos de seguridad actualizados (como HTTPS y autenticación multifactor). |
|RNF03 |Usabilidad |La interfaz del aplicativo debe ser intuitiva y fácil de usar, permitiendo a los usuarios completar tareas como ingresar transacciones y visualizar reportes sin complicaciones. La navegación debe ser fluida tanto en dispositivos móviles como en escritorio. |
|RNF04 |Escalabilidad |El aplicativo debe ser capaz de manejar un número creciente de usuarios y transacciones sin afectar su rendimiento. Se debe poder escalar en la base de datos y en el manejo de reportes sin comprometer la experiencia del usuario. |
|RNF05|Disponibilidad |El sistema debe estar disponible la mayor parte del tiempo, con un mínimo de 99.5% de tiempo de funcionamiento sin interrupciones significativas. |
|RNF06 |Mantenimiento |El aplicativo debe permitir actualizaciones y mejoras continuas sin que los usuarios experimenten interrupciones significativas. La implementación de nuevas funcionalidades no debe requerir reescritura del código base. |
|RNF07 |Notificaciones |El aplicativo debe permitir la configuración de notificaciones push para alertas personalizadas (gastos excesivos, presupuesto, pagos recurrentes) que se envíen en tiempo real, asegurando que el usuario esté siempre al tanto de sus finanzas. |

4. Reglas<a name="_page10_x85.05_y70.85"></a> de Negocio 



|Regla |Descripción  |
| - | - |
|Validación de Usuario |Un usuario no puede acceder al sistema sin registrarse previamente con un correo electrónico válido y una contraseña segura. |
|Límites de Presupuesto  |Los usuarios podrán establecer presupuestos mensuales para cada categoría, pero el total de los presupuestos no puede exceder el 100% de los límite mensuales registrados. |
|Registro de Transacciones |Una transacción debe incluir un montó, una categoría, una fecha y una descripción. Las transacciones no pueden ser registradas con valores negativos (a menos que se trate de un "ingreso negativo" o devolución). |
|Validación de  Egresos |Los egresos no pueden ser registrados con valores nulos o sin una categoría asociada. |
|Historial de Transacciones |El sistema debe permitir consultar las transacciones pasadas en un rango de fechas específico (mensual, anual, etc.). |
|Comparación de Periodos |Los usuarios pueden comparar sus gastos en diferentes periodos (por ejemplo, este mes vs. el mes pasado), pero solo podrán hacerlo dentro del mismo año. |
|Notificación de Gastos Excesivos |Si un usuario excede un porcentaje configurado de su presupuesto, se enviará una notificación de alerta. El porcentaje debe estar entre el 5% y el 50% según la configuración del usuario. |
|Presupuesto por Categoría |Los presupuestos establecidos para cada categoría no pueden ser inferiores a un valor mínimo predeterminado para asegurar que las necesidades básicas (alimentación, transporte, etc.) sean cubiertas. |
|Exportación de Datos |Los usuarios pueden exportar sus datos financieros en formatos como CSV o Excel, pero los reportes exportados solo incluirán transacciones aprobadas. |

5. Fase<a name="_page11_x85.05_y70.85"></a> de Desarrollo 
1. Perfiles<a name="_page11_x85.05_y86.66"></a> de Usuario 

   El perfil de usuario de la aplicación está compuesto principalmente por individuos interesados en gestionar sus finanzas personales de manera eficiente. Estos usuarios pueden ser jóvenes, adultos o freelancers que buscan llevar un control de sus egresos y presupuestos mensuales. La aplicación está diseñada para ser intuitiva y fácil de usar, permitiendo a los usuarios registrar transacciones, establecer límites de presupuesto, generar reportes financieros y recibir notificaciones sobre gastos excesivos o pagos recurrentes. Además, los usuarios valoran la seguridad de sus datos, por lo que la aplicación ofrece medidas de protección robustas, como la encriptación y autenticación multifactor. 

2. Modelo<a name="_page11_x85.05_y276.55"></a> Conceptual 
1. ### Diagrama<a name="_page11_x85.05_y300.36"></a> de Paquetes 
   [https://www.mermaidchart.com/app/projects/4fa7b273-3e12-4 cd1-a6e2-5ce82b1b910d/diagrams/5144ca63-964b-4864-85ec-5 342ee0fcedd/version/v0.1/edit](https://www.mermaidchart.com/app/projects/4fa7b273-3e12-4cd1-a6e2-5ce82b1b910d/diagrams/5144ca63-964b-4864-85ec-5342ee0fcedd/version/v0.1/edit)  

   ![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.005.png)
2. ### Diagrama<a name="_page12_x85.05_y70.85"></a> de Casos de Uso 
![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.006.jpeg)
3. ### Escenarios<a name="_page13_x85.05_y70.85"></a> de Caso de Uso (Narrativa) 
` `Caso de Uso: CU-01 - Registrar Usuario 

|**Caso de uso** |CU-01 |
| - | - |
|**Actores** |Registrar Usuario |
|**Propósito** |Permitir que un nuevo cliente cree una cuenta en el sistema. |
|**Tipo** |Principal |
|**Descripción** |El cliente ingresa al sistema proporcionando su información básica para crear una cuenta y poder utilizar los servicios bancarios. |
|**Precondición** |<p>- El cliente no debe tener una cuenta registrada previamente. </p><p>- El cliente debe tener acceso a internet. </p>|
|**Curso normal de eventos** ||
|**Acciones de actores** |**Acciones de página web** |
|<p>1\.  El cliente selecciona la opción </p><p>"Registrar". </p>|<p>2\.  El sistema muestra el formulario </p><p>de registro. </p>|
|<p>3\.  El cliente ingresa su nombre, </p><p>correo electrónico, número de teléfono y crea una contraseña. </p>|<p>4\.  El sistema valida que los campos </p><p>no estén vacíos. </p>|
|5\.  El cliente envía el formulario. |<p>6\.  El sistema muestra un mensaje de </p><p>confirmación. </p>|
||<p>7\.  El sistema valida la información y </p><p>crea la cuenta. </p>|

Caso de Uso: CU-02 - Iniciar Sesión



|**Caso de uso** |CU-02 |
| - | - |
|**Actores** |Cliente |
|**Propósito** |Permitir que un cliente acceda al sistema ingresando sus credenciales válidas. |
|**Tipo** |Principal |
|**Descripción** |El cliente accede al sistema proporcionando su correo electrónico y contraseña previamente registrados. Si las credenciales son correctas, el sistema le concede acceso. |
|**Precondición** |- El cliente debe tener una cuenta |
||<p>previamente registrada. </p><p>- El cliente debe tener acceso a internet. </p>|
| :- | - |
|**Curso normal de eventos** ||
|**Acciones de actores** |**Acciones de página web** |
|1\. Selecciona la opción "Iniciar Sesión". |2\. Muestra el formulario de inicio de sesión. |
|3\. Ingresa correo electrónico y contraseña. |4\. Valida que los campos no estén vacíos. |
|5\. Hace clic en "Ingresar". |6\. Verifica las credenciales en la base de datos. |
||7\. Si son correctas, concede el acceso al pantalla principal |

Caso de Uso: CU-03 - Recuperar Contraseña



|**Caso de uso** |CU-03 |
| - | - |
|**Actores** |Cliente |
|**Propósito** |Permitir que el cliente recupere el acceso a su cuenta en caso de olvidar la contraseña. |
|**Tipo** |Principal |
|**Descripción** |El cliente solicita la recuperación de su contraseña mediante su correo electrónico registrado. El sistema envía un enlace para restablecerla. |
|**Precondición** |<p>- El cliente debe tener una cuenta previamente registrada. </p><p>- El cliente debe tener acceso a internet. </p>|
|**Curso normal de eventos** ||
|**Acciones de actores** |**Acciones de página web** |
|1\. Selecciona "¿Olvidaste tu contraseña?" |2\. Muestra el formulario para ingresar el correo. |
|3\. Ingresa su correo electrónico registrado. |4\. Verifica que el correo está registrado. |
|5\. Confirma solicitud de recuperación. |6\. Envía un enlace de restablecimiento al correo. |
||7\. Muestra mensaje de confirmación de envío. |

Caso de Uso: CU-04 - Editar Perfil

|**Caso de uso** |CU-04 |
| - | - |
|**Actores** |Cliente |
|**Propósito** |Permitir que el cliente actualice su información personal en el sistema. |
| - | :- |
|**Tipo** |Principal |
|**Descripción** |El cliente accede a su perfil y modifica sus datos personales como nombre, teléfono o correo. |
|**Precondición** |<p>- Debe haber iniciado sesión. </p><p>- El cliente debe tener acceso a internet. </p>|
|**Curso normal de eventos** ||
|**Acciones de actores** |**Acciones de página web** |
|1\. Selecciona la opción "Editar Perfil". |2\. Muestra el formulario con datos actuales. |
|3\. Modifica los campos deseados. |4\. Valida los datos ingresados. |
|5\. Hace clic en "Guardar cambios". |6\. Actualiza la información en la base de datos. |
||7\. Muestra mensaje de confirmación. |

Caso de Uso: CU-05 - Configurar Gasto Diario

|**Caso de uso** |CU-05 |
| - | - |
|**Actores** |Cliente |
|**Propósito** |Permitir al cliente establecer un límite de gasto diario. |
|**Tipo** |Principal |
|**Descripción** |El cliente configura un monto máximo de gasto diario para controlar sus finanzas. |
|**Precondición** |<p>- Debe haber iniciado sesión. </p><p>- El cliente debe tener acceso a internet. </p>|
|**Curso normal de eventos** ||
|**Acciones de actores** |**Acciones de página web** |
|1\. Selecciona el botón de "Configuración". |2\. Muestra las opciones de configuración. |
|3\. Ingresa el límite de gasto diario. |4\. Valida el monto ingresado. |
|5\. Confirma la configuración. |6\. Guarda el límite diario y muestra confirmación. |

Caso de Uso: CU-06 - Editar Gasto Diario

|**Caso de uso** |CU-06 |
| - | - |
|**Actores** |Cliente |
|**Propósito** |Permitir que el cliente modifique su límite de gasto diario. |
| - | :- |
|**Tipo** |Principal |
|**Descripción** |El cliente ajusta el monto del gasto diario previamente configurado. |
|**Precondición** |- Debe tener un gasto diario ya configurado. |
|**Curso normal de eventos** ||
|**Acciones de actores** |**Acciones de página web** |
|1\. Selecciona el botón de "Configuración". |2\. Muestra el monto actual configurado. |
|3\. Ingresa un nuevo monto. |4\. Valida el nuevo monto. |
|5\. Confirma la edición. |6\. Actualiza la base de datos y confirma el cambio. |

Caso de Uso: CU-07 - Crear Planes de Gastos (Mensuales)

|**Caso de uso** |CU-07 |
| - | - |
|**Actores** |Cliente |
|**Propósito** |Permitir al cliente establecer un plan de gastos mensual para controlar su presupuesto. |
|**Tipo** |Principal |
|**Descripción** |El cliente define montos límite por categoría de gasto para el mes actual o próximos. |
|**Precondición** |- Debe haber iniciado sesión en el sistema. |
|**Curso normal de eventos** ||
|**Acciones de actores** |**Acciones de página web** |
|1\. Accede a la opción "Planes de Gastos". |2\. Muestra opciones para crear o editar planes. |
|3\. Selecciona "Crear nuevo plan". |4\. Muestra formulario con categorías disponibles. |
|5\. Ingresa el mes y montos por categoría. |6\. Valida datos e informa si hay errores. |
|7\. Confirma y guarda el plan. |8\. Registra el plan y muestra mensaje de éxito. |

Caso de Uso: CU-08 - Editar Planes 

|**Caso de uso** |CU-08 |
| - | - |
|**Actores** |Cliente |
|**Propósito** |Permitir que el cliente modifique los planes de gastos mensuales previamente creados. |
| - | :- |
|**Tipo** |Segundario |
|**Descripción** |El cliente accede a sus planes de gastos y realiza ajustes en los montos o categorías. |
|**Precondición** |<p>- Debe haber creado un plan de gastos. </p><p>- Debe haber iniciado sesión. </p>|
|**Curso normal de eventos** ||
|**Acciones de actores** |**Acciones de página web** |
|1\. Selecciona la opción "Editar Planes". |2\. Muestra la lista de planes existentes. |
|3\. Elige un plan para modificar. |4\. Presenta el formulario con los datos actuales. |
|5\. Modifica los campos deseados. |6\. Valida los datos ingresados. |
|7\. Guarda los cambios. |8\. Actualiza la información en la base de datos. |
||9\. Muestra mensaje de confirmación. |

Caso de Uso: CU-09 - Alertar Sobre Gasto Excesivo



|**Caso de uso** |CU-09 |
| - | - |
|**Actores** |Cliente |
|**Propósito** |Notificar al cliente cuando sus gastos superen el límite establecido para evitar sobregiros. |
|**Tipo** |Secundario |
|**Descripción** |El sistema monitorea los gastos diarios y envía alertas al cliente si se excede el gasto límite configurado. |
|**Precondición** |<p>- El cliente debe haber configurado un límite de gasto. </p><p>- Debe haber gastos registrados. </p>|
|**Curso normal de eventos** ||
|**Acciones de actores** |**Acciones de página web** |
||1\. Monitorea los gastos ingresados por el cliente. |
||2\. Compara el total con el límite configurado. |
||3\. Si se excede, envía una alerta al cliente (notificación). |

Caso de Uso: CU-10 - Registrar Gasto Manualmente

|**Caso de uso** |CU-10 |
| - | - |
|**Actores** |Cliente |
|**Propósito** |Permitir al cliente ingresar manualmente los gastos realizados para llevar un control financiero. |
|**Tipo** |Principal |
|**Descripción** |El cliente añade un gasto introduciendo los detalles como monto, categoría y fecha mediante un formulario. |
|**Precondición** |<p>- Debe haber iniciado sesión. </p><p>- El cliente debe tener acceso a la funcionalidad de gastos. </p>|
|**Curso normal de eventos** ||
|**Acciones de actores** |**Acciones de página web** |
|1\. Selecciona "Registrar gasto manualmente". |2\. Muestra el formulario para ingresar gasto. |
|3\. Ingresa monto y fecha del gasto. |4\. Valida los datos ingresados. |
|5\. Confirma el registro del gasto. |6\. La IA de Gemini Clasifica y luego se guarda el gasto en la base de datos. |
||7\. Muestra mensaje de confirmación. |

Caso de Uso: CU-11 - Registrar Gasto por Escaneo

|**Caso de uso** |CU-11 |
| - | - |
|**Actores** |Cliente |
|**Propósito** |Permitir al cliente registrar gastos automáticamente escaneando recibos o facturas. |
|**Tipo** |Principal |
|**Descripción** |El cliente utiliza la cámara o carga una imagen del recibo para que el sistema extraiga y registre los datos del gasto. |
|**Precondición** |<p>- Debe haber iniciado sesión. </p><p>- El cliente debe tener acceso a la función de escaneo. </p>|
|**Curso normal de eventos** ||
|**Acciones de actores** |**Acciones de página web** |
|1\. Selecciona "Registrar gasto por escaneo". |2\. Solicita permiso para acceder a la cámara |
||o carga imagen. |
| :- | - |
|3\. Escanea el recibo o carga la imagen. |4\. La IA procesa la imagen y extrae datos relevantes del gasto. |
|5\. Revisa y confirma los datos extraídos. |6\. La IA de Gemini Clasifica y luego se guarda el gasto en la base de datos. |
||7\. Muestra mensaje de confirmación. |

Caso de Uso: CU-12 - Visualizar Análisis Financiero

|**Caso de uso** |CU-12 |
| - | - |
|**Actores** |Cliente |
|**Propósito** |Permitir al cliente visualizar reportes y gráficos que muestran el estado y tendencias de sus finanzas. |
|**Tipo** |Principal |
|**Descripción** |El cliente accede a un panel donde puede revisar su resumen financiero, gastos y otras métricas importantes. |
|**Precondición** |<p>- Debe haber iniciado sesión. </p><p>- Debe tener datos financieros registrados. </p>|
|**Curso normal de eventos** ||
|**Acciones de actores** |**Acciones de página web** |
|1\. Selecciona la opción "Análisis Financiero". |2\. Recupera datos financieros del cliente. |
|3\. Visualiza gráficos y reportes interactivos. |4\. Muestra gráficos y tablas con análisis detallado. |
|5\. Puede filtrar por fechas o categorías. |6\. Actualiza la visualización según filtros aplicados. |

Caso de Uso: CU-13 - Crear Deudas y Préstamos

|**Caso de uso** |CU-13 |
| - | - |
|**Actores** |Cliente |
|**Propósito** |Permitir al cliente registrar nuevas deudas o préstamos para llevar un control financiero. |
|**Tipo** |Principal |
|**Descripción** |El cliente ingresa detalles sobre una deuda o préstamo, incluyendo monto, plazo, tasa de interés y fecha de vencimiento. |
|**Precondición** |<p>- Debe haber iniciado sesión. </p><p>- Debe tener acceso a internet. </p>|
|**Curso normal de eventos** ||
| - | :- |
|**Acciones de actores** |**Acciones de página web** |
|1\. Selecciona "Crear Deuda o Préstamo". |2\. Muestra formulario para ingresar detalles. |
|3\. Ingresa monto, plazo, tasa de interés y fecha. |4\. Valida datos ingresados. |
|5\. Confirma la creación. |6\. Guarda la deuda o préstamo en la base de datos. |
||7\. Muestra mensaje de confirmación. |

Caso de Uso: CU-14 - Editar Deudas y Préstamos

|**Caso de uso** |CU-14 |
| - | - |
|**Actores** |Cliente |
|**Propósito** |Permitir al cliente modificar los detalles de deudas o préstamos registrados previamente. |
|**Tipo** |Secundario |
|**Descripción** |El cliente accede a sus deudas o préstamos y puede actualizar información como monto, plazo, tasa de interés o fecha de vencimiento. |
|**Precondición** |<p>- Debe haber iniciado sesión. </p><p>- Debe tener deudas o préstamos registrados. </p>|
|**Curso normal de eventos** ||
|**Acciones de actores** |**Acciones de página web** |
|1\. Selecciona "Editar Deuda o Préstamo". |2\. Muestra listado de deudas y préstamos. |
|3\. Escoge la deuda o préstamo a modificar. |4\. Muestra formulario con los datos actuales. |
|5\. Modifica los campos necesarios. |6\. Valida la información ingresada. |
|7\. Confirma la edición. |8\. Actualiza los datos en la base de datos. |
||9\. Muestra mensaje de confirmación. |

Caso de Uso: CU-15 - Notificar Pagos y Vencimientos

|**Caso de uso** |CU-15 |
| - | - |
|**Actores** |Cliente |
|**Propósito** |Informar al cliente sobre pagos pendientes y fechas de vencimiento próximas para evitar retrasos. |
|**Tipo** |Principal |
| - | - |
|**Descripción** |El sistema envía notificaciones automáticas al cliente para recordarle pagos próximos o vencidos. |
|**Precondición** |<p>- Debe haber deudas, préstamos o gastos con fechas próximas de pago. </p><p>- El cliente debe tener habilitadas las notificaciones. </p>|
|**Curso normal de eventos** ||
|**Acciones de actores** |**Acciones de página web** |
||1\. El sistema monitorea fechas de vencimientos y pagos. |
|2\. El cliente recibe notificaciones automáticas. |3\. Envía alertas mediante app push. |

Caso de Uso: CU-16 - Exportar Reportes y Movimientos



|**Caso de uso** |CU-12 |
| - | - |
|**Actores** |Cliente |
|**Propósito** |Permitir al cliente generar y descargar informes detallados de sus movimientos y análisis financieros. |
|**Tipo** |Principal |
|**Descripción** |El cliente solicita la exportación de sus datos financieros en formatos como Excel o PDF, incluyendo gráficos y registros. |
|**Precondición** |<p>- El cliente debe haber iniciado sesión. </p><p>- Debe tener movimientos y reportes generados para exportar. </p>|
|**Curso normal de eventos** ||
|**Acciones de actores** |**Acciones de página web** |
|1\. Selecciona la opción "Exportar Reportes". |2\. Muestra las opciones de formato disponibles (Excel, PDF). |
|3\. Elige el formato deseado. |4\. Procesa la solicitud y genera el archivo correspondiente. |
|5\. Descarga el archivo generado. |6\. Muestra confirmación de descarga exitosa. |

3. Modelo<a name="_page22_x85.05_y87.70"></a> Lógico 
1. ### Análisis<a name="_page22_x85.05_y111.50"></a> de Objetos 
1) Iniciar Sesión  

   ![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.007.png)

2) Registrar Usuario 

   ![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.008.png)

3) Recuperar Contraseña  

   ![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.009.png)

4) Editar Perfil 

   ![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.010.png)

5) Configurar Gasto Diario 

   ![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.011.png)

6) Editar Gasto Diario 

   ![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.012.png)

7) Crear Planes de Gastos (Mensuales)  

   ![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.013.png)

8) Editar Planes  

   ![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.014.png)

9) Alertar Sobre Gasto Excesivo 

   ![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.015.jpeg)

10) Registrar gasto manualmente 

    ![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.016.png)

11) Registrar gasto por escaneo 

    ![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.017.png)

12) Visualizar Análisis Financiero 

    ![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.018.jpeg)

13) Crear Deudas y Préstamos 

    ![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.019.jpeg)

14) Editar Deudas y Préstamos 

    ![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.020.jpeg)

15) Notificar Pagos y Vencimientos 

    ![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.021.png)

16) Exportar Reportes y Movimientos 

    ![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.022.jpeg)
2. ### Diagrama<a name="_page25_x85.05_y70.85"></a> de Actividades con Objetos 
![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.023.png)
3. ### Diagrama<a name="_page26_x85.05_y70.85"></a> de Secuencia 
1. ### Secuencia<a name="_page26_x85.05_y94.66"></a> de Autenticación 
![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.024.jpeg)

2. Secuencia de Escaneo con IA 

![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.025.png)

3. Secuencia de Gestión de Planes Financieros 

![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.026.jpeg)

4. Secuencia de Análisis de Gastos 

![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.027.jpeg)

4. Diagrama de Clases 

![](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.028.jpeg)


# <a name="_page28_x85.05_y540.38"></a><a name="_page29_x85.05_y70.85"></a>**CONCLUSIONES** 
La especificación de requerimientos realizada ha permitido establecer de manera clara y detallada las funcionalidades esenciales que debe poseer la aplicación para la gestión financiera personal. Esto asegura que el desarrollo se enfoque en las necesidades reales del usuario, garantizando una herramienta útil y fácil de usar, desde el registro de usuarios hasta la generación de reportes financieros. 

Además, la elaboración de casos de uso centrados en el cliente facilita una experiencia intuitiva y eficiente, ya que cada funcionalidad está cuidadosamente descrita, considerando las condiciones previas y el flujo lógico de interacción. Esto contribuye a que los usuarios puedan administrar sus finanzas de manera práctica, confiando en las alertas, configuraciones y análisis que ofrece la aplicación. 

Por otro lado, contar con una especificación detallada mejora notablemente la comunicación entre los diferentes involucrados en el proyecto, incluyendo desarrolladores, diseñadores y clientes. Esta claridad reduce el riesgo de malentendidos y cambios no planificados, optimizando así el proceso de desarrollo y permitiendo un control más efectivo sobre el alcance del proyecto. 

Finalmente, la documentación estructurada y modular abre la puerta a futuras mejoras y expansiones del sistema, facilitando la incorporación de nuevas funcionalidades o la integración con otros servicios externos. Esto asegura que la aplicación pueda evolucionar y adaptarse a las demandas cambiantes del mercado y de sus usuarios. 
# <a name="_page29_x85.05_y450.82"></a>**RECOMENDACIONES** 
Se recomienda mantener una comunicación constante con los usuarios finales durante el desarrollo para validar que las funcionalidades implementadas satisfagan sus necesidades reales y para recibir retroalimentación continua que permita mejorar la experiencia de uso. Esto ayudará a detectar posibles mejoras o ajustes a tiempo, evitando retrabajos costosos. 

Es importante implementar pruebas exhaustivas, tanto funcionales como de usabilidad, para garantizar que la aplicación funcione correctamente en distintos escenarios y dispositivos. Asimismo, se sugiere automatizar pruebas donde sea posible para acelerar la detección de errores en etapas tempranas del desarrollo. 

Se aconseja también considerar la integración de medidas de seguridad robustas, especialmente en el manejo de datos sensibles como la información financiera y personal de los usuarios, para proteger la privacidad y evitar posibles vulnerabilidades que puedan comprometer la confianza en el sistema. 

Finalmente, se recomienda planificar un mantenimiento y actualización periódica del sistema que permita incorporar nuevas funcionalidades, optimizar el rendimiento y adaptarse a las nuevas tecnologías y requerimientos regulatorios que puedan surgir en el ámbito financiero. 
# <a name="_page30_x85.05_y70.85"></a>**BIBLIOGRAFÍA** 
- Pressman, R. S. (2014). Ingeniería de Software: Un enfoque práctico (7ª ed.). McGraw-Hill.  
- Sommerville, I. (2011). Software Engineering (9th Edition). Addison-Wesley. 
- Fowler, M. (2004). UML Distilled: A Brief Guide to the Standard Object Modeling Language (3rd ed.). Addison-Wesley. 
- Gamma, E., Helm, R., Johnson, R., & Vlissides, J. (1994). Design Patterns: Elements of Reusable Object-Oriented Software. Addison-Wesley. 
- IEEE Computer Society. (1998). IEEE Recommended Practice for Software Requirements Specifications (IEEE Std 830-1998). 
- Beck, K. (2000). Extreme Programming Explained: Embrace Change. Addison-Wesley. 
- Date, C. J. (2003). Introducción a los sistemas de bases de datos (7ª ed.). Pearson Educación. 
- PlantUML. (2023). Recuperado de https://plantuml.com/ 
31 
