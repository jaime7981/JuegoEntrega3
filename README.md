# JuegoEntrega3

## Carpetas Importantes
 - mobile_app -> Aplicacion Mobil en Flutter
 - web_app -> dockerized django web app (REST API), postgres (db) and nginx (web engine)
 - mobile_web_app_api.postman_collection.json -> postman api endpoints examples

## Instrucciones de uso app mobil
 - Tener instalado flutter
 - Pararse en la carpeta mobile_app
 - Correr comando `flutter run`
 - Se tiene que correr en emulador de celular o en celular propio
 - El testeo se ha realizado en celulares android, pero debiese poder correr en ios tambien (repito, no ha sido testeado en ios).

## Instrucciones de juego
- Añadir amigos (pues sólo puedes invitar amigos a tus partidas).
- En 'My Games', escribir un nombre y crear una partida (no invitar usuarios aquí, pues técnicamente el juego no ha sido creado).
- Una vez creado, en el lobby puedes invitar a todos los amigos que quieras dandole al botón 'Invite' junto a al nombre o id de tu amigo.
- Cuando estes listo, dale a 'Start Game' y el juego comenzará. Se le asignará a un jugador el estado 'Answering' (quien deberá descubrir la respuesta correcta), mientras que el resto estará en estado 'Writting' (o tratando de escribir respuestas engañosas).
- Una vez subidas las respuestas, el jugador en 'Answering' deberá escoger la respuesta que crea correcta (y asegurarse de hacerlo una sola vez). Se le dirá si la respuesta es correcta o no, y tendrá la opción de ir al Lobby.
- Actualizar el lobby para ver los puntajes actualizados, y repetir el proceso hasta terminar el juego!

 ### Consejos de uso: 
 - Actualizar el lobby para ver los puntajes actualizados. 
 - En caso de no actualizarse los botones de 'Answering'/'Writing', salir del lobby y volver a entrar para ver algún cambio.
