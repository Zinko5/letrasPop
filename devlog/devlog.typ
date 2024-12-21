#set heading(numbering: "1.")
#set text(font: "DejaVu Sans")
#set page(margin: (x:70pt, y: 50pt))

= Introducción
LetrasPop surgió como idea un dia a inicios de 2024, inicialmente como una simple pagina web donde cualquier usuario pueda subir letras de canciones; buscando ofrecer un servicio mejor que #link("https://www.letras.com/")[Letras.com], con la idea de dar más libertad a la comunidad de editar y agregar letras de forma rapida y fluida.

Durante los proximos meses, la idea fue evolucionando a un producto más emocionante y creó una nueva ambicion, una revolucion: La implementacion de una funcion que pueda transcribir la letra de las canciones automaticamente

Ninguna otra aplicacion similar (que ofrece letras de canciones) permite hacer la transcripcion automaticamente

El nuevo producto busca funcionar del siguiente modo: 
Un usuario podrá entrar a la página/aplicacion, buscar el nombre de la cancion (o el producto podría detectarla automaticamente), y se le aparecerá la letra si está ya registrada, si no lo está, se transcribirá automaticamente y se quedará registrada para cualquiera que quiera consultarla en el futuro.

El día 15/12/2024, decidí iniciar esta aventura para desarrollar la herramienta que, en mi ilusion, será la mejor existente en su tipo

= Planteamiento inicial
Entre mis ideas de lo que quiero que termine siendo mi por ahora proyecto, quiero que se acceda a través de:
- Una aplicacion web
- Una aplicacion de Android e IOS
Y que tenga las siguientes funcionalidades:
- *Transcripcion automatica de la letra (principal)*
- Reconocimiento automatico de la cancion que se está reproduciendo para ofrecer la letra sin necesidad de buscarla
- Desplazamiento automatico de la letra a través de la pantalla siguiendo mientras se reproducen las estrofas, parrafos, palabras, silabas, lo que sea posible

Para inciar a desarrollar por algún lado, decidí que lo primero que voy a hacer es la aplicacion web implementado solo la funcion de la transcripcion automatica. Este proceso lo realizo principalmente siguiendo las indicaciones de ChatGPT

== Herramientas utilizadas
Al principio tenía pensado usar:
- React JS
- Tailwind
- Axios
- Express JS
- MongoDB
- Vercel para el hotsing de prueba
- AWS para el hosting profesional
- Kubernetes en AWS
- Speechmatics
- Cloudfare
- Loud balancer
- Google AdSenses

Pero tras un análisis más profundo de las herramientas y tecnologias, decidí que las que usaré serán:
- *Typst*: Lenguaje de marcado para registrar el devlog
- *React JS*: Framework para la interfaz web
- *Node JS*: Backend para la lógica del servidor
- *PostgreSQL*: Base de datos relacional para gestionar usuarios, historial y relaciones
- *MongoDB*: Base de datos basada en documentos para guardar las transcripciones y metadatos
- *Speechmatics*: Para realizar las transcripciones automaticas
- *Auth JS*: Para la autentificacion de usuarios
- *Render*: Para el hosting inicial de la página web y la base de datos de PostgreSQL
- *Google Cloud Hosting*: Para el hosting masivo de la página web y la base de datos de PostgreSQL
- *Atlas*: Para el hosting de la datos de MongoDB
- *Google Ads*: Para mostrar publicidad y monetizar el sitio
- *Next JS* Para optimizar el SEO y las páginas estáticas
// Agregar axios
=== El modelo de transcripcion
De los modelos de transcripcion automatica que probé, realice el siguiente ranking basado en la precisión de la letra que dieron como resultado.
1. Speechmatics
2. Whisper AI
3. Google Cloud Speech-to-texts 
La cancion con la que hice la prueba fue "La casa azul - Parade", cancion cuya letra no está registrada en ningun sitio de internet. El resultado de la transcripcion de Speechmatics fue:

// #set block(width: 400pt, inset: (x:30pt, y:15pt), breakable: false, fill: luma(91.85%))
// #show block: set par(leading: 5pt, spacing: 15.5pt)
// #show block: set align(center)

#align(center)[
  #block(width: 400pt, inset: (x:30pt, y:15pt), breakable: false, fill: luma(91.85%))[
    #align(left)[
      #par(leading: 5pt, spacing: 15.5pt)[
        Los pasillos de la Casa Azul me llevaron donde yo nunca, jamás creí que pudiera llegar.

        Y el recuerdo de lo que encontré me hizo regresar a su portal. Sin saber. Sin pensar.

        Veo brillar las luces de la casa azul después de la puesta del sol y los salones se llenan de música y gente.

        Gente feliz tarareando canciones de hace 100 años. Estoy.

        No volveré a salir de aquí.

        No volveré a salir de aquí.

        Voy a salir de aquí.

        Se apagarán las luces de la Casa Azul cuando empiece a amanecer.

        Me dormiré despacio.

        Soñando mis sueños.

        Al otro lado del espejo. Muy despacio.

        Soñando mis sueños. Estoy.

        Ta ta ta ta ta ta ta ta ta ta ta ta ta ta ta ta ta ta.

        La casa azul será mi hogar.

        Ta da ta ta ta ta ta ta ta ta ta ta toc, toc, toc, toc. Sin saber. Sin pensar.

        Cha cha, cha, cha, cha, cha, cha, cha, cha, cha.

        La casa azul será mi hogar.

        Cha cha, cha, cha, cha, cha, cha, cha, cha, cha. 

        La casa azul será mi hogar. Mi. Mi. Mi. Mi, Mi. Mi. Mi. Mi.
      ]
    ]
  ]
]

Mientras que la letra correcta transcita debe ser:

#align(center)[
  #block(width: 400pt, inset: (x:30pt, y:15pt), breakable: false, fill: luma(91.85%))[
    #align(left)[
      #par(leading: 5pt, spacing: 15.5pt)[
        Los pasillos de la Casa Azul\
        Me llevaron donde yo nunca, jamás \
        Creí que pudiera llegar

        Y el recuerdo de lo que encontré\
        Me hizo regresar a su portal\
        Sin saber\
        Sin pensar

        Veo brillar\
        Las luces de la casa azul\
        Después de la puesta del sol

        Y los salones se llenan de música y gente\
        Gente feliz\
        Tarareando canciones de hace 100 años\
        Estoy

        No volveré a salir de aquí\
        No volveré a salir de aquí\
        (No volveré a salir de aquí)

        Se apagarán\
        Las luces de la Casa Azul\
        Cuando empiece a amanecer

        Me dormiré despacio\
        Soñando mis sueños\
        Al otro lado del espejo\
        Muy despacio\
        Soñando mis sueños\
        Estoy

        (Cha cha cha cha cha)\
        (Cha cha cha cha cha)

        La casa azul será mi hogar

        (Cha cha cha cha cha)\
        (Cha cha cha cha cha)

        Sin saber\
        Sin pensar

        (Cha cha cha cha cha)

        (Será)

        La casa azul será mi hogar

        (Cha cha cha cha cha)

        (Será)

        La casa azul será mi hogar
      ]
    ]
  ]
]

Como se puede observar, hay ciertos errores en la transcripcion automatica, pero fueron mínimos en comparación con los otros modelos probados 

= Minimum Viable Product
abc