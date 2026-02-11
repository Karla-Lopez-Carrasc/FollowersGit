## Aplicación de Seguidores de GitHub

Desarrolla una aplicación que permita mostrar a los seguidores de un usuario de GitHub, basado en el nombre de usuario ingresado.
--
## Pantalla de Búsqueda
La pantalla contará con:
• Un TextField para ingresar el nombre de usuario.
• Un botón con el título “Get Followers”.
• El botón deberá permanecer oculto mientras el TextField esté vacío.
• Al ingresar un nombre de usuario válido, el botón se hará visible y podrá ser presionado.
<img width="477" height="907" alt="Captura de pantalla 2026-02-07 a la(s) 12 57 57 p m" src="https://github.com/user-attachments/assets/57b5b3a0-371e-4c78-b829-d93220d906c3" />

--
## Pantalla de Información del Usuario
• La barra de navegación mostrará el nombre del usuario buscado.
• Se utilizará un CollectionView para mostrar:
• La imagen de perfil de cada seguidor.
• El nombre del seguidor.
<img width="477" height="907" alt="Captura de pantalla 2026-02-07 a la(s) 12 58 31 p m" src="https://github.com/user-attachments/assets/c241db6c-7c90-4fc3-be14-243b56653fcc" />

--
## Manejo de Errores:
Se deben presentar alertas nativas para informar al usuario de cualquier error que pueda
ocurrir, como: Usuario no encontrado, error al pasear la información de la API, problemas de
conexión a internet, etc
<img width="477" height="907" alt="Captura de pantalla 2026-02-07 a la(s) 12 58 50 p m" src="https://github.com/user-attachments/assets/b8468855-fa3c-4583-8f5b-cd66b8726538" />

--
## Funcionalidades Adicionales (Punto Extra)

Favoritos:
• En la pantalla de información se añadirá un botón para agregar al usuario a favoritos.
• Los usuarios marcados como favoritos deberán almacenarse de forma persistente usando
UserDefaults.

Nueva Sección: Tab Favoritos
• Se agregará un nuevo tab en la interfaz para la sección de Favoritos.
• En esta pantalla, se mostrará una tabla con:
•La imagen de perfil del usuario.
•El nombre del usuario.
•Al seleccionar un usuario de la lista, se navegará nuevamente a la pantalla de información,
mostrando los detalles del usuario seleccionado.
Para obtener la información, consultar la documentación de la api de Github
<img width="477" height="907" alt="Captura de pantalla 2026-02-07 a la(s) 12 59 21 p m" src="https://github.com/user-attachments/assets/b6d94723-07c6-42df-8492-38946f0f167a" />
<img width="477" height="907" alt="Captura de pantalla 2026-02-07 a la(s) 1 00 11 p m" src="https://github.com/user-attachments/assets/d34970a7-a8b4-48e4-aa7e-744724faed3d" />
