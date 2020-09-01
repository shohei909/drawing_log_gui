package locale;
import electron.renderer.Remote;
import haxe.DynamicAccess;
import haxe.Json;
import js.Browser;
import locale.StringKey;
import sys.FileSystem;
import sys.io.File;

class Locale 
{
	public static var resources:Array<DynamicAccess<String>> = [];
	public static function load():Void
	{
		var names = ["en"];
		inline function addLang(lang1:String):Void
		{
			var lang2 = lang1.split("-")[0];
			if (names.indexOf(lang2) == -1) names.unshift(lang2);
			if (names.indexOf(lang1) == -1) names.unshift(lang1);
		}
		addLang(Browser.window.navigator.language);
		addLang(untyped Remote.app.getLocale());
		
		for (name in names)
		{
			var path = "locale/" + name + ".json";
			if (FileSystem.exists(path))
			{
				resources.push(Json.parse(File.getContent(path)));
			}
		}
	}
	
	public static function get(key:StringKey):String
	{
		var key:String = cast key;
		for (resource in resources)
		{
			if (resource.exists(key))
			{
				return resource.get(key);
			}
		}
		return "(" + key + ")";
	}
}
