package setting;
import electron.renderer.Remote;
import haxe.DynamicAccess;
import haxe.Json;
import locale.StringKey;
import sys.FileSystem;
import sys.io.File;

class KeyConfig 
{
	public static var resources:Array<DynamicAccess<String>> = [];
	public static function load():Void
	{
		var names = [
			untyped Remote.app.getPath("userData") + "/settings/key.json",
			"settings/key.json"
		];
		
		for (name in names)
		{
			if (FileSystem.exists(name))
			{
				resources.push(Json.parse(File.getContent(name)));
			}
		}
	}
	
	public static function get(key:KeyConfigKey):String
	{
		for (resource in resources)
		{
			var key:String = cast key;
			if (!resource.exists(key)) continue;
			var value = resource.get(key);
			if (value == null) continue;
			return value;
		}
		return KeyConfigDefault.resolve(key);
	}
}
