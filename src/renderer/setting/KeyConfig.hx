package setting;
import electron.renderer.Remote;
import haxe.DynamicAccess;
import haxe.Json;
import js.Node;
import js.node.Path;
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
			{
				var path = "settings/key.json";
				path = if (untyped Remote.app.isPackaged) 
				{
					Path.join(Path.dirname(untyped Remote.app.getPath("module")), path);
				}
				else
				{
					Path.join(Node.process.cwd(), path);
				}
			}
			
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
		return null;//KeyConfigDefault.resolve(key);
	}
}
