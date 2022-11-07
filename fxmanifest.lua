fx_version "cerulean"

game 'gta5'

lua54 'yes'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'nh_cfg.lua',
	'nh_sv.lua'
}

client_scripts {
	'nh_cfg.lua',
	'nh_cl.lua'
}