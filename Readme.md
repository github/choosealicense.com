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
Puede darse el caso de que su sistema no tenga las dependencias necesarias. Necesitará cmakee makeinstalarlo en su computadora.

For MacOS, use Homebrew to update your dependencies (install Homebrew from https://brew.sh/):

brew install make cmake
For Linux/Ubuntu, use the apt-get tool to install the dependencies:

sudo apt-get install make cmake
Installing and Running the tool
Note that the third command (./script/bootstrap) may require you to use sudo access for installation. Add sudo right before the third command, if need be, but don't use root access.

git clone https://github.com/github/choosealicense.com.git
cd choosealicense.com
./script/bootstrap
./script/server
Open http://localhost:4000 in your favorite browser.

Adding a license
For information on adding a license, see the CONTRIBUTING file.

License metadata
Las licencias se encuentran en la /_licensescarpeta. Cada licencia tiene una parte frontal de YAML que describe las propiedades de la licencia. El cuerpo del archivo contiene el texto de la licencia en texto sin formato. Los campos de metadatos disponibles son:

Campos requeridos
title- El nombre completo de la licencia especificado por https://spdx.org/licenses/
spdx-id- Identificador corto especificado por https://spdx.org/licenses/
description - Una descripción legible por humanos de la licencia.
how - Instrucciones sobre cómo implementar la licencia.
using- Un mapa de 3 proyectos notables que utilizan la licencia con archivos de LICENCIA sencillos que sirven como ejemplos que los recién llegados pueden seguir y que pueden ser detectados por el licenciatario en forma deproject_name: license_file_url
permissions - Lista con viñetas de reglas de permisos
conditions - Lista con viñetas de reglas de condición
limitations - Lista con viñetas de reglas de limitación
Campos opcionales
featured - Si la licencia debe aparecer en la página principal (el valor predeterminado es falso)
hidden- Si la licencia no es popular ni completa el espectro de licencias de fuertemente condicional a incondicional (por defecto es verdadero)
nickname - Nombre corto habitual si corresponde (p. Ej., GPLv3)
note - Información adicional sobre las licencias
redirect_from - Ruta (s) relativa (s) para redirigir a la licencia, para evitar romper las URL antiguas
Campos rellenados automáticamente
Las licencias de choosealicense.com se importan regularmente a GitHub.com para usarlas como lista de licencias disponibles al crear un repositorio. Cuando creamos un repositorio, reemplazaremos ciertas cadenas de la licencia con variables del repositorio. Estos se pueden utilizar para crear avisos de derechos de autor precisos. Las variables disponibles son:

Los campos
fullname - The full name or username of the repository owner
login - The repository owner's username
email - The repository owner's primary email address
project - The repository name
description - The description of the repository
year - The current year
projecturl - The repository URL or other project website
License properties
The license properties (rules) are stored as a bulleted list within the licenses YAML front matter. Each rule has a name e.g., include-copyright, a human-readable label, e.g., Copyright inclusion, and a description Include the original copyright with the code. To add a new rule, simply add it to _data/rules.yml and reference it in the appropriate license.

Rules
Permissions
commercial-use - This software and derivatives may be used for commercial purposes.
modifications - This software may be modified.
distribution - This software may be distributed.
private-use - This software may be used and modified in private.
patent-use - Esta licencia proporciona una concesión expresa de derechos de patente por parte de los contribuyentes.
Condiciones
include-copyright - Se debe incluir una copia de la licencia y el aviso de derechos de autor con el software.
include-copyright--source - Se debe incluir una copia de la licencia y el aviso de derechos de autor con el software en formato fuente, pero no es necesario para los archivos binarios.
document-changes - Los cambios realizados en el código deben estar documentados.
disclose-source - El código fuente debe estar disponible cuando se distribuye el software.
network-use-disclose - Los usuarios que interactúan con el software a través de la red tienen derecho a recibir una copia del código fuente.
same-license- Las modificaciones deben publicarse bajo la misma licencia al distribuir el software. En algunos casos, se puede utilizar una licencia similar o relacionada.
same-license--file- Las modificaciones de archivos existentes deben publicarse bajo la misma licencia al distribuir el software. En algunos casos, se puede utilizar una licencia similar o relacionada.
same-license--library- Las modificaciones deben publicarse bajo la misma licencia al distribuir el software. En algunos casos, se puede usar una licencia similar o relacionada, o esta condición puede no aplicarse a las obras que usan el software como biblioteca.
Limitaciones
trademark-use - Esta licencia establece explícitamente que NO otorga derechos de marca registrada, aunque las licencias sin dicha declaración probablemente no otorguen ningún derecho implícito de marca registrada.
liability - Esta licencia incluye una limitación de responsabilidad.
patent-use - Esta licencia establece explícitamente que NO concede ningún derecho sobre las patentes de los contribuyentes.
warranty - La licencia establece explícitamente que NO proporciona ninguna garantía.
Licencia
El contenido de este proyecto en sí está sujeto a la licencia Creative Commons Attribution 3.0 Unported , y el código fuente subyacente que se utiliza para formatear y mostrar ese contenido está sujeto a la licencia MIT .
