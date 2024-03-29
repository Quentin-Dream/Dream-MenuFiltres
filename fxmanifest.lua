fx_version 'cerulean'
games { 'gta5' };

ui_page 'html/ui.html'

client_scripts {
    "config.lua",
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
    "client/client.lua"
}

server_scripts {
    "server/server.lua"
}


files {
    'html/ui.html',
    'html/img/image.png',
    'html/css/app.css',
    'html/scripts/app.js'
}
