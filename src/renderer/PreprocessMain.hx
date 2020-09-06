package ;
import locale.LocalePreprocess;
import setting.KeyConfigPreprocess;

class PreprocessMain 
{

	public static function main():Void
	{
		LocalePreprocess.main();
		KeyConfigPreprocess.main();
	}
}