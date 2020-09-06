package setting;
import haxe.Json;
import sys.io.File;
import tool.AbstractEnumTools;

class KeyConfigPreprocess 
{

	public static function main() 
	{
		var keys:Map<KeyConfigKey, String> = [
			for (key in AbstractEnumTools.getValues(KeyConfigKey))
			{
				key => KeyConfigDefault.resolve(key);
			}
		];
		File.saveContent("bin/settings/key.json", Json.stringify(keys, null, "\t"));
	}
}
