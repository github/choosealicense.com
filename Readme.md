ChooseALicense.com tiene como objetivo proporcionar información precisa , comprensible y sin prejuicios sobre las licencias populares de código abierto para ayudar a las personas a tomar decisiones informadas sobre los proyectos que inician, mantienen, contribuyen y utilizan.



Catalogamos licencias selectas de código abierto con una colección Jekyll (en _licenses). El catálogo se usa para representar ChooseALicense.com y se vende regularmente al Licenciatario , que GitHub usa para proporcionar un selector de licencias y detección de licencias , una API de licencias y para mostrar descripciones de licencias y metadatos .

Metas
Sea preciso, no crítico y comprensible. Nuestro objetivo es ayudarlo a encontrar una licencia que cumpla con sus objetivos.
La página de inicio debe tener lo suficiente para ayudar a la mayoría de las personas a tomar una decisión sobre qué licencia usar para un proyecto al que contribuyen.
Por lo demás, el sitio contendrá información adicional sobre licencias comunes a comunidades y situaciones específicas.
Colabore y refuerce otras prácticas recomendadas de licencias y proyectos de normas.
No es exhaustivo. Parece un objetivo extraño, pero hay miles de millones de licencias por ahí. Tendremos que filtrar eso a una pequeña lista de los que importan.
Ejecútelo en su máquina
Gestión de dependencias
Puede darse el caso de que su sistema no tenga las dependencias necesarias. Lo necesitará cmakee makeinstalado en su computadora.

Para MacOS, use Homebrew para actualizar sus dependencias (instale Homebrew desde https://brew.sh/ ):

brew instalar hacer cmake
Para Linux / Ubuntu, use la apt-getherramienta para instalar las dependencias:

sudo apt-get install make cmake
Instalación y ejecución de la herramienta
Tenga en cuenta que el tercer comando ( ./script/bootstrap) puede requerir que utilice el sudoacceso para la instalación. Agregue sudojusto antes del tercer comando, si es necesario, pero no use el acceso de root.

git clone https://github.com/github/choosealicense.com.git
 cd choosealicense.com
./script/bootstrap
./script/server
Abre http://localhost:4000en tu navegador favorito.

Agregar una licencia
Para obtener información sobre cómo agregar una licencia, consulte el archivo CONTRIBUTING .

Metadatos de licencia
Las licencias se encuentran en la /_licensescarpeta. Cada licencia tiene una parte frontal de YAML que describe las propiedades de la licencia. El cuerpo del archivo contiene el texto de la licencia en texto plano. Los campos de metadatos disponibles son:

Campos requeridos
title- El nombre completo de la licencia especificado por https://spdx.org/licenses/
spdx-id- Identificador corto especificado por https://spdx.org/licenses/
description - Una descripción de la licencia legible por humanos
how - Instrucciones sobre cómo implementar la licencia
using- Un mapa de 3 proyectos destacados que utilizan la licencia con archivos de LICENCIA sencillos que sirven como ejemplos que los recién llegados pueden seguir y que pueden ser detectados por el licenciatario en forma deproject_name: license_file_url
permissions - Lista con viñetas de reglas de permisos
conditions - Lista con viñetas de reglas de condición
limitations - Lista con viñetas de reglas de limitación
Campos opcionales
featured - Si la licencia debe aparecer en la página principal (el valor predeterminado es falso)
hidden- Si la licencia no es popular ni completa el espectro de licencias de fuertemente condicional a incondicional (por defecto es verdadero)
nickname - Nombre corto habitual si corresponde (por ejemplo, GPLv3)
note - Información adicional sobre las licencias
redirect_from - Ruta (s) relativa (s) desde las que redirigir a la licencia, para evitar romper las URL antiguas
Campos autocompletados
Las licencias de choosealicense.com se importan regularmente a GitHub.com para usarlas como lista de licencias disponibles al crear un repositorio. Cuando creamos un repositorio, reemplazaremos ciertas cadenas de la licencia con variables del repositorio. Estos se pueden utilizar para crear avisos de derechos de autor precisos. Las variables disponibles son:

Campos
fullname - El nombre completo o nombre de usuario del propietario del repositorio
login - El nombre de usuario del propietario del repositorio
email - La dirección de correo electrónico principal del propietario del repositorio.
project - El nombre del repositorio
description - La descripción del repositorio
year - El año actual
projecturl - La URL del repositorio u otro sitio web del proyecto
Propiedades de la licencia
Las propiedades de la licencia (reglas) se almacenan como una lista con viñetas dentro de las licencias de YAML. Cada regla tiene un nombre, por ejemplo, include-copyrightuna etiqueta legible por humanos, por ejemplo Copyright inclusion, y una descripción Include the original copyright with the code. Para agregar una nueva regla, simplemente agréguela _data/rules.ymly haga referencia a ella en la licencia correspondiente.

Reglas
Permisos
commercial-use - Este software y sus derivados pueden utilizarse con fines comerciales.
modifications - Este software puede sufrir modificaciones.
distribution - Este software puede distribuirse.
private-use - Este software se puede utilizar y modificar en privado.
patent-use - Esta licencia proporciona una concesión expresa de derechos de patente por parte de los contribuyentes.
Condiciones
include-copyright - Se debe incluir una copia de la licencia y el aviso de derechos de autor con el software.
include-copyright--source - Se debe incluir una copia de la licencia y el aviso de derechos de autor con el software en formato fuente, pero no es necesario para los archivos binarios.
document-changes - Los cambios realizados en el código deben estar documentados.
disclose-source - El código fuente debe estar disponible cuando se distribuye el software.
network-use-disclose - Los usuarios que interactúan con el software a través de la red tienen derecho a recibir una copia del código fuente.
same-license- Las modificaciones deben publicarse bajo la misma licencia al distribuir el software. En algunos casos, se puede utilizar una licencia similar o relacionada.
same-license--file- Las modificaciones de archivos existentes deben publicarse bajo la misma licencia al distribuir el software. En algunos casos, se puede utilizar una licencia similar o relacionada.
same-license--library- Las modificaciones deben publicarse bajo la misma licencia al distribuir el software. En algunos casos, se puede usar una licencia similar o relacionada, o esta condición puede no aplicarse a trabajos que usan el software como biblioteca.
Limitaciones
trademark-use - Esta licencia declara explícitamente que NO otorga derechos de marca registrada, aunque las licencias sin dicha declaración probablemente no otorguen ningún derecho implícito de marca registrada.
liability - Esta licencia incluye una limitación de responsabilidad.
patent-use - Esta licencia establece explícitamente que NO otorga ningún derecho sobre las patentes de los contribuyentes.
warranty - La licencia establece explícitamente que NO proporciona ninguna garantía.
Licencia
El contenido de este proyecto en sí está autorizado bajo la licencia Creative Commons Attribution 3.0 Unported , y el código fuente subyacente utilizado para formatear y mostrar ese contenido está autorizado bajo la licencia MIT .
