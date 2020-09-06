package operation;
import golden_layout.ContentItem;
import js.html.Element;

class BulkOperation 
{
	public static function iterDisplayingPlayers(func:DrawlogPlayer->Void):Void
	{
		_iterDisplayingPlayers(Main.goldenLayout.root, func);
	}
	
	private static function _iterDisplayingPlayers(item:ContentItem, func:DrawlogPlayer->Void):Void
	{
		if (item == null) { return; }
		if (item.isStack)
		{
			_iterDisplayingPlayers(item.getActiveContentItem(), func);
			return;
		}
		if (item.isComponent)
		{
			var element:Element = item.element.get(0);
			var player = Drawlog.getPlayer(element.getElementsByClassName("drawlog-player")[0]);
			func(player);
		}
		for (item in item.contentItems)
		{
			_iterDisplayingPlayers(item, func);
		}
	}
	
	public static function togglePlay():Void
	{
		iterDisplayingPlayers(player -> player.togglePlay());
	}
	public static function fastForward():Void
	{
		iterDisplayingPlayers(
			player -> if (player.fastforwarding) {
				player.finishFastforward();
			} else {
				player.startFastforward();
			}
		);
	}
	public static function fastBackward():Void
	{
		iterDisplayingPlayers(
			player -> if (player.rewinding) {
				player.finishRewind();
			} else {
				player.startRewind();
			}
		);
	}
	public static function stepForward():Void
	{
		iterDisplayingPlayers(player -> player.step(1));
	}
	public static function stepBackward():Void
	{
		iterDisplayingPlayers(player -> player.step(-1));
	}
	public static function stepFastForward():Void
	{
		iterDisplayingPlayers(player -> player.step(10));
	}
	public static function stepFastBackward():Void
	{
		iterDisplayingPlayers(player -> player.step(-10));
	}
}
