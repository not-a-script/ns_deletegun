fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

name 'Not a Delete Gun'
author 'Not a Script'
version '1.0.1'
repository 'https://github/notascript/ns_deletegun'

shared_scripts {
    'shared/utils.lua',
    'shared/config.lua'
}
server_script {
    'server/framework.lua',
    'server/server.lua'
} 
client_script {
    'client/client.lua'
}

escrow_ignore {
    '**/*.lua'
}

dependencies {
    '/onesync',
    '/server:8900',
}
