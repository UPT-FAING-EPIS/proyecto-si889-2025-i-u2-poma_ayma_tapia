---
marp: true
theme: uncover # O el tema base que prefieras, lo sobrescribiremos
paginate: true
header: "**VanGuard Money** - Arquitectura y Diseño Técnico"
footer: "© 2025 - Pág. <!--_footer: {page} / {totalPages}-->"
style: |
  /* Estilo base para todas las diapositivas */
  section {
    background-color: #FFFFFF; /* Fondo blanco */
    color: #34495E; /* Texto principal: Gris azulado oscuro (Wet Asphalt) */
    font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
  }

  /* Estilos para los encabezados */
  h1 {
    color: #2980B9; /* Azul primario (Peter River) */
    text-align: center;
    font-size: 2.2em;
    font-weight: 600;
  }

  h2 {
    color: #16A085; /* Turquesa/Verde Mar (Green Sea) */
    font-size: 1.8em;
    border-bottom: 2px solid #BDC3C7; /* Gris claro para el borde (Silver) */
    padding-bottom: 0.3em;
    margin-top: 1.5em;
    margin-bottom: 0.8em;
    font-weight: 500;
  }

  h3, h4, h5, h6 {
    color: #2C3E50; /* Azul medianoche (Midnight Blue) */
    font-size: 1.4em;
    font-weight: 500;
  }

  /* Estilos para el texto normal y listas */
  p, li {
    color: #34495E; /* Gris azulado oscuro (Wet Asphalt) */
    font-size: 0.95em; /* Ligeramente más grande para mejor lectura */
    line-height: 1.7; /* Mayor interlineado */
  }

  /* Estilos para tablas */
  table {
    color: #34495E;
    width: 100%;
    margin-top: 20px;
    border-collapse: collapse;
  }
  th {
    color: #FFFFFF; /* Texto blanco */
    background-color: #2C3E50; /* Fondo Azul medianoche */
    font-weight: bold;
  }
  td, th {
    border: 1px solid #BDC3C7; /* Borde Gris (Silver) */
    padding: 12px; /* Más padding */
    text-align: left;
  }
  tr:nth-child(even) {
    background-color: #ECF0F1; /* Filas pares con fondo gris muy claro (Clouds) */
  }

  /* Estilos para enlaces */
  a {
    color: #2980B9; /* Azul primario (Peter River) */
    text-decoration: none;
    font-weight: 500;
  }
  a:hover {
    color: #3498DB; /* Azul más claro al pasar el mouse (Belize Hole) */
    text-decoration: underline;
  }

  /* Estilos para bloques de código */
  pre, code {
    background-color: #ECF0F1; /* Fondo gris muy claro (Clouds) */
    color: #2C3E50; /* Texto Azul medianoche */
    border: 1px solid #BDC3C7; /* Borde Gris (Silver) */
    border-radius: 4px;
    padding: 0.6em;
  }
  code { /* Para código inline */
    padding: 0.2em 0.4em;
    font-size: 0.9em;
  }

  /* Elementos de énfasis */
  strong {
    color: #2980B9; /* Azul primario (Peter River) */
    font-weight: 600;
  }

  em {
    color: #16A085; /* Turquesa/Verde Mar (Green Sea) */
    font-style: italic;
  }

  /* Estilo para la portada (clase 'lead') */
  section.lead {
    text-align: center;
    padding-top: 8%;
  }
  section.lead h1 {
    color: #2980B9; /* Azul primario */
    font-size: 2.8em;
  }
  section.lead h2 {
    color: #16A085; /* Turquesa/Verde Mar */
    font-size: 1.5em;
    margin-top: 0.5em;
    border-bottom: none;
  }
  section.lead p {
    color: #34495E;
    font-size: 1em;
    margin-top: 1em;
  }
  .integrantes {
    font-size: 0.8em;
    color: #7F8C8D; /* Gris (Asbestos) */
    margin-top: 30px;
  }
  .integrantes p {
    margin: 5px 0;
    font-size: 0.9em;
    color: #7F8C8D;
  }
  .integrantes strong {
    color: #2C3E50; /* Azul medianoche */
  }

  /* Para la clase 'highlight' */
  .highlight {
    background-color: #ECF0F1; /* Fondo gris muy claro (Clouds) */
    border-left: 5px solid #F39C12; /* Borde Naranja (Orange) como acento */
    padding: 15px;
    border-radius: 4px;
    margin-top: 20px;
  }
  .highlight p, .highlight li {
    color: #2C3E50; /* Texto Azul medianoche dentro del highlight */
  }

  /* Imágenes */
  img {
    max-width: 85%; /* Ligeramente más pequeñas para más aire */
    max-height: 60vh;
    display: block;
    margin-left: auto;
    margin-right: auto;
    border-radius: 4px; /* Bordes redondeados sutiles */
    /* box-shadow: 0 4px 8px rgba(0,0,0,0.08); */ /* Sombra opcional */
  }

  /* Estilo para los iconos de pin y diana */
  .emoji-title {
    font-size: 1.2em;
    margin-right: 8px;
    color: #F39C12; /* Naranja (Orange) para los emojis */
  }
---

<!-- Portada -->
<!-- _class: lead -->
# **VanGuard Money**
## App de Gestión Financiera para el Registro y Análisis de Gastos Personales

<br>

<p style="font-size:1.1em; color: #16A085;">Curso: Patrones de Software</p> <!-- Turquesa -->
<p style="font-size:1em; color: #34495E;">Docente: Ing. Patrick Cuadros</p>

--- 

<div class="integrantes">
  <p><strong>Integrantes:</strong></p>
  <p>Ayma Choque, Erick Yoel (2021072616)</p>
  <p>Poma Machicado, Fabiola Estefani (2021070030)</p>
  <p>Tapia Vargas, Dylan Yariet (2021072630)</p>
</div>

![bg right width:250](/documentos_md/img/logo.png)

---

## <span class="emoji-title">📌</span>Planteamiento del Problema

En la actualidad, muchas personas tienen dificultades para llevar un control adecuado de sus gastos personales, lo que les impide optimizar sus recursos financieros.

A pesar de la disponibilidad de herramientas en línea, muchas de estas no se adaptan a las necesidades específicas de cada usuario, presentando interfaces complejas o limitadas en funcionalidades.

### Consecuencias:
*   Pérdida de control sobre las finanzas personales.
*   Falta de motivación para seguir un presupuesto debido a la falta de visibilidad o personalización en las aplicaciones existentes.

---

## <span class="emoji-title">🎯</span>Alcance y Justificación

### Alcance:
El sistema tiene como objetivo automatizar el registro de egresos, permitiendo a los usuarios gestionar sus finanzas personales de manera eficiente. La solución abarcará:
*   Creación de una interfaz accesible y fácil de usar para registrar y categorizar transacciones.
*   Generación de reportes automáticos de hábitos de consumo basados en el tiempo.
*   Integración de funciones para establecer presupuestos en planes por categoria

---

### Justificación:
El desarrollo de esta solución es esencial debido a la creciente necesidad de herramientas automatizadas para el manejo eficiente de las finanzas personales. Una herramienta como esta no solo mejorará la gestión financiera, sino que también promoverá hábitos de consumo más responsables y permitirá a los usuarios identificar oportunidades de ahorro, reduciendo el tiempo invertido en tareas manuales.

---

## <span class="emoji-title">🎯</span>Objetivo Principal
<div class="highlight">
<p>Desarrollar una aplicación intuitiva para gestionar los gastos personales, permitiendo a los usuarios registrar, analizar y visualizar sus finanzas de manera clara y eficiente, con el objetivo de fomentar hábitos de ahorro y planificación financiera.</p>
</div>

---

## <span class="emoji-title">✅</span>Objetivos Secundarios

*   Registrar los gastos diarios, organizados por categorías (comida, transporte, entretenimiento, etc.).
*   Analizar los gastos mediante gráficos y estadísticas para identificar patrones de consumo y posibles áreas de ahorro.
*   Establecer presupuestos mensuales para cada categoría de gasto, con alertas si se superan los límites establecidos.
*   Desarrollar una interfaz amigable y accesible, con visualizaciones claras y fáciles de entender.

---

<!-- Índice mejorado -->
## **Índice Técnico**

| **Sección**                    | **Enfoque**                          |
|--------------------------------|--------------------------------------|
| 1. Diagrama de Casos de Uso    | Vista funcional del sistema          |
| 2. Diagrama de Clases          | Lógica de negocio y relaciones       |
| 3. Arquitectura del Sistema    | Módulos principales y flujo de datos |
| 4. Infraestructura de Despliegue | Infraestructura y servicios cloud    |

---

<!-- Diagrama de Casos de Uso -->
## **1. Diagrama de Casos de Uso**
![width:600px height:500px](/documentos_md/img/Aspose.Words.ad70b158-151a-428b-b3be-f6b38ab73bfd.006.jpeg)

---

<!-- Diagrama de Clases -->
## **2. Diagrama de Clases**
[![](https://img.plantuml.biz/plantuml/svg/pLllRXkv4VzkmE-mpNreqjH0xzgcg90w9ykIwwljw2Gb-LBWGEtI4Y-xoot9TQgx-YdwA7s4Ux7EaFk7It9Naeq2zG4vP_dZS3Z_E3DalfMA25LcwUd9hzIMPZGgKiBoqnFvcUK54IIBrYJ-l16yp9C9Jxc8lfhf7niIfqJAwEVJaoYwSD7Jty--cLtg8IuIAghFN__vJsykly7FCvwh9Vk9Hb__xlJaqIPR02soeJs4Pt_4_pp2R_HFGrZjKXgjUPfesgSdYYduSCd81bOWKKAZ2J1FPNGMVIJvfYGYkUKvtKKltuiDoTbF9E6l_fulcLJKuA-eLEoN_-JHZEKaZnaL99fJ8NbEKbpXrz5VXdyGCXdFnz5ySNqtkPwFRmwQL4lZHGOAUc64OWH_kniNXVaGHQzn-EMhKVJ0ML9zMfSiJV3R9vPigAg-ifmfHb8GFKotPppY7otv6HDq3J9wNoZ6SzaiH0hsDxeRHKibMBwfFXQ2_qXZTPqutpCg9Td0tvSq1sLvuwGekjyUAuKTBixBQNHzDrkCfylLuiDazM4nFawkCHUqaclp3GnEKVcYthCH28XhWTz5_Hdurq0nYgwu6UeEo55q0nRqLezTW2pFc_5A2pSy9YZUhbXmFar0_h521PcXTsRiiQEgXcFjnJx3A-tSBRy_W-Ch5Zz6ATjibHuTHVf_bqGH7vOGyNa_AaOVNCO6Dsd_Od5isBKuqp0POgqGB2DYLr7onoMDUPuC8ThOrK-a5FSafftnCACh-ayJJuBCRYb9KfRJ6o8sAAGQ762A9xjRq6gP3S9IigRfCYDfwi5wL5ygbhgsEkCY8uf_1-4fA68Y99sHM9M2p0JFhiTePxUaUETZ7o1M94HHf0MMME8aYl0rvwaF1vO549uBdW2KIqHg9m3gvpxyNZCwAOMWURnhhRrN8nyDEpssKpCxXN2OUhuJGiw1w1SuIGu2ZpCmAjydGz05_KS97kpJhRLuV9Yx7A_UBuyBRi09SODRnXFg6Sm7ISKj3bXIBLdYnIMAWlM-vWGzt_cOiemfUaMaud3m2iP7KSBBjMNqzpJUaecW9DOX488BNR6i6JyxQv0DUozVjRF1SF6G0lh681jG0r6y0m0JR8PYNkm-CRKDJ0nOtJmbEPMkW0BoAQL_ok4v24a9Nt55Kay8S03G3HUCICtWMpFpjnNi_51XlGQdOm-ywvQM1AqT3CdGWXqYHKWhzAx6acroo9bmtDaVG9OaJVW2A91SKHSIadOTF9uky9ndQq7lGB8n6fupgcKPaA4AQgYesQaYMStUkQz3ToLR0PrD3UgWWpnG3HEGBGIUf1DuMQxs2jaIhn6Q9wq24f60zyRLYjOoHuh24W9QIRdMyW_OaEAmMtVJABVgSqrmy9m4GtbWiP_MbMgxD4EjACv-8F1vr2J126h7xcizj816DQqWz9ccCBQO2FCk80bqc-iSuv0-iSPvOfz7inBFshSu6Hm_0MgGCbfM1y50KHnz8W5S_NsfB2JM0kS1xguutwJqA9ukULncDE-d3YhNE3YY7CBQxj-roB98Qg9Ti4KmOE6DJWBgFKI5bfxCjW9RCZRUsLG0LNzQvgIGMwxShUsL5SY37W33EC3J5Ee6E2CirFSb5Jj_yLe35LbfpS10Pnc2Wlrd7dQfFmUf1zHndO4RvdCMVwOYe9523umCpA02Ya2KHc3QUWLPCYnjiJrZARKCfuEUG98YI3yuvXb4EYdr10Tce_87Ak3KmthkpH_wJE7fMTvyCLrExrRZoVKl_xx3_iJrzDFj-ylfpP6f7-u55ANBIpS5V63qYvC6ahNKYNkbBDpTHq0v9_1NJDvmai0-kud6LrG8BcvrjK-zxDWEU5HL1BhD2ZCqHIhUGCuLkz-XHTAS2jaT3nLj4Am3l9kONbdUo8xxBS8BsYOKjGc8n6aOzF2SIvmYQCziImmftx0sx5j6XFHQOnDqWxiM-v4DGIzIUpW-4F5DE8BZz9uD405DNG8pe1B8yCEetXmwg9Xx9rAFlDXjnGbDfax5sdJLylfzY8uY86NIa5wPcDYFe5w1L68RWfW8FWY1S3p69Bv1MRot9XYJD2vJMEwYJ7G0hw9Lang5GYzPGhP6HL3up8_Ber2mVfgwDZHZEMk0oGvgHHPR3WN61acPz4AA7JI0UTscS28pDYpEFHHsJNf1XLbDUuhcpBG-UavpIHueIYwdYPDv39lwE2VfJhBd6_i6gsUtxd3j_H2GO_AwAkytUR0hWp25Uzl4wMMXdh2a6O7D6tSQAcUR6RSqb-KXCnh3dvWIOwShJzcnVKqO31rHMo9KhJNDVFDb84V96PGwprORiK-WKVT0ieAxn5Igxerqjcwyn5Nn0kemE5_eSRfUc7NsAlklV1SkttMOfttrUvL7fefbN7fsPUMH0N5FwcBncHAlv3FdOjAMdvPH1At_ObSRqf1ej95reVxk6qLSxAgkgkSn0y5Yoo7j2SUAedjcZjn3r38vD-IC_2ZKi4pCadCE6LNCqFdywhxC2kpWWRtnEPfgKQBe-yJQE6Ur6qka0SytHzU4un8aZqFzZ2Lv05UGotApmPitdhT1o4-qkmAT9amHWVrgT9WrIvxhqAz_15eOEFPuAOM5pKan37JCyRkAkfVuchHYngYvnkkCrNtcUc8d4SLpQzemCt1iFRyyMKuMq-dTORM9tOo1h0e2_r3viTGGIsEjr88tcxZlBVzYbHU1qQR2iCSwDjImY47yHRkyOUm6ysoNCsrDN6JwNlGgvMkImgzlyH9c2GLOQ_i8r1tq2S-Lm4fTc5iUL1OmtNwsPnHLH-UOIMVjxttIWf4VjYHFKgetvLfOEsnAYbvG3fwwmKugNrJbYejwh7_fohA6FqkSUFLmb3J_3-NV9xUkT8CAU1oou2stxeIxAKv0vWUoh8Ugd692n13A90vxG5VTr6O0-Nq9vSWuRWw3Bgp7oCo1-Spj6Y9u-0o0cjIZVyEjCj5s3dIJ-XX_vXvMP7r1lD1d0NH93wW1o2TAF-_3t88xRFU1T2f-i0xhylNf4i3Ghwl79Iz5J27dJhdNWMeTqa1ZCX0KzTry3m9NQylQTh733DOqNvuJ58yoRRCSqjddoKkgLF1aRQNomUqVXOLtqtIX3evbs9rDARQUkVHYcl5Fz2dCz9vuakWxslz1Z6-yWZUPtBu88gy46pmn83lsnDjZJsqsxCdcc0reCf37wpqCHUcc5keFbsOFcX84WdmpO2b7RBIHtYLLU37WRhV_Ql98KLGbthxpe174aG5WnHCkfnieHKnH-6ILNUhY8QqIYpwzceNsxCMW-WysV6rLNEnmHQUMivtQlvFzeYcvLxAJ4bA2xA9KglDyIO4_UfVJFCVgL68l_YFOo0GqZy-_cl6U2ujznKIeMQ6vmg2WBTTYB3uqQBpMhxjMeNqyrE-Qi5RBTPBJxd4jOwZUpBndxgAIXa5PUyYwTpVFM46NM8VIVur5kiAtVBRsGbSc1wi9Kmjl-KGNvS4s85hMhi2dW3YmWb-FMlseIxx5z0Ogv_TtqsNx37XwMF6Ce5l2yYYX1JwcnJV8ylJ4l08-EpjltwSw7rVcAQOkuhcWaQ2flXIKMrO0WUQLQ0Kt3pFzx-qxI4CB9HYbP4U5Iz5vllERixFsiSaeGcU1L1yuibzUu2Bj6xHHb96S5MLAJa-yMto4EalinrlljsmmRgHf3ic8vLigc8hmQKdt2lJqf7iZ-lPVi2kdhnj0UEsw0CQxd0clvJVpGhIw_UiWnc-wXXTqsf91q42hpHDkAMbKwKGQvRV4j8rPvZ02DAZ7lJ94cAVV2klVSI4wzEXWSC9nvErtjXNGl_iP9EjSE0nX0zto8VXG6_HPy_mzewPDmHBm8JDWpAUgQhJjMAqqVx3R6_B7xIw6FseN_Vvejw0EqEwKcm7gTeNMtJpQU6lofoTskx2syLQQbVISFbWlhjEvqSRj64_7QooSwqQEfThhUiRhcB-zkkSHzVgT2hPtEqxHDi2eKy8WSiX8NNUnwm6S6_2ZQegNUWz8sLDxyp3TLxlrQBrVvpxezEHREEdrFzFwBm00)]

---

<!-- Arquitectura del Sistema -->
## **3. Arquitectura del Sistema**
![width:600px height:500px](/documentos_md/img/Aspose.Words.63e5ea3e-59bc-4c76-bbc2-f838f7afb3c6.029.jpeg)

---

<!-- Diagrama de Despliegue -->
## **4. Infraestructura de Despliegue**
![width:600px height:500px](/documentos_md/img/Aspose.Words.63e5ea3e-59bc-4c76-bbc2-f838f7afb3c6.031.jpeg)

---

## Conclusión con Estilo

 "VanGuard Money" es una aplicación móvil intuitiva que simplifica la gestión de finanzas personales. Mediante el registro inteligente de gastos, la planificación presupuestaria y análisis visuales claros, empodera a los usuarios para controlar sus finanzas, optimizar sus recursos y fomentar hábitos de ahorro de manera eficiente.
