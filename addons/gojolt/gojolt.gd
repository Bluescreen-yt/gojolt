@tool
extends EditorPlugin
## simple wrapper for game jolt api


const PROJECT_SETTINGS_PREFIX := "Gojolt" ## prefix for project settings
const VERSION := "v1_2" ## version of the gamejolt api

static var gamejolt_user_name : String = "none"
static var gamejolt_user_token : String = "none"

func _enable_plugin() -> void:
	# Add autoloads here.
	pass


func _disable_plugin() -> void:
	pass


func _enter_tree() -> void:
	_add_setting( "disable_this", true )
	_add_setting( "base_api_path", "https://api.gamejolt.com/api/game" )
	_add_setting( "game_id", "1234567" )
	_add_setting( "key", "1234567" )
	
	
	if ProjectSettings.get_setting( PROJECT_SETTINGS_PREFIX+"/disable_this" ):
		print_rich( "[color=cyan]Hello from GoJolt! please go check project settings to configure the plugin and dissable this message![/color]" )


func _exit_tree() -> void:
	pass


## makes http request to gamejolt api
static func _make_game_jolt_request(endpoint: String, data: Dictionary, get_or_post:bool):
	var game_id = ProjectSettings.get_setting( PROJECT_SETTINGS_PREFIX+"/game_id" )
	var api_key = ProjectSettings.get_setting( PROJECT_SETTINGS_PREFIX+"/key" )
	
	var base = ProjectSettings.get_setting( PROJECT_SETTINGS_PREFIX+"/base_api_path" ) ## base path
	var requestString = base+"/"+VERSION+"/"+endpoint+"/" ## will look something like: https://api.gamejolt.com/api/game/v1_2/example-endpoint/
	requestString += "?game_id="
	
	if get_or_post:
		pass


## adds settings with PROJECT_SETTINGS_PREFIX
func _add_setting(name: String, default: Variant):
	name = PROJECT_SETTINGS_PREFIX+'/'+name
	
	if not ProjectSettings.has_setting(name):
		ProjectSettings.set_setting(name, default)
	
	ProjectSettings.set_initial_value(name, default)
	ProjectSettings.set_as_basic(name, true)
	ProjectSettings.save()
