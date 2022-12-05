fx_version 'cerulean'
game 'gta5'

author 'Azael Dev <contact@azael.dev> (https://www.azael.dev/)'
description 'DC - Rich Presence'
version '1.1.5'
url 'https://github.com/Azael-Dev/azael_dc-richpresence'

lua54 'yes'

shared_script 'config/shared.config.lua'

server_script 'source/server/main.server.lua'

client_script 'source/client/main.client.lua'

dependencies {
    '/server:4664',
    '/onesync'
}
