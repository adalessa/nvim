# Configuration Para Neovim

Esta es mi configuracion para neovim.
La uso en mi cotidiano y podes verlos en mis videos de [youtube](https://youtube.com/@Alpha_Dev) y directos en [twtich](https://twitch.tv/theAlphaDeveloper)

El objetivo de mi configuracion es ayudarme en mi trabajo cotidiano convirtiendo neovim en la mejor herramienta para poder programar.

## TODO add screenshot

## Opciones, Autocomandos y Keymaps

Opciones relacionadas al editor se encuentran en `./lua/config/options.lua`
Configuraciones relacionadas a keymaps relacionadas al editor y no a plugins se encuentran en `./lua/config/keymaps.lua`
Autocomandos que quiero registrar se encuentran en `./lua/config/autocmds.lua`
En el mismo directorio se encuentra la configuracion para "Diagnostic" donde configuro los iconos a mostrar para los errores que pueden ser por LSP u otras herramientas, dado que neovim lo maneja como un modulo aparte me gusta tenerlo por serparado.

Todas estas configuraciones las cargo con el evento `VeryLazy` utilizando un autocomando.

## Plugins
