package electron.main;
/**
	> Instantiates a special "other items proxy", which nests TouchBar elements inherited from Chromium at the space indicated by the proxy. By default, this proxy is added to each TouchBar at the end of the input. For more information, see the AppKit docs on NSTouchBarItemIdentifierOtherItemsProxy
	
	Note: Only one instance of this class can be added per TouchBar.
	
	Process: Main
	@see http://electronjs.org/docs/api/touch-bar-other-items-proxy
**/
@:jsRequire("electron", "TouchBarOtherItemsProxy") extern class TouchBarOtherItemsProxy extends js.node.events.EventEmitter<electron.main.TouchBarOtherItemsProxy> {
	function new():Void;
}
@:enum abstract TouchBarOtherItemsProxyEvent<T:(haxe.Constraints.Function)>(js.node.events.EventEmitter.Event<T>) to js.node.events.EventEmitter.Event<T> {

}
