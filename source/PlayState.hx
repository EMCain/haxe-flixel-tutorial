package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxObject;

import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;

import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledObjectLayer;

class PlayState extends FlxState
{
	var _player:Player;
	var _map:TiledMap;
	var _mWalls:FlxTilemap;
	override public function create():Void
	{
		_map = new TiledMap("assets/data/tutorial-level.tmx");
		_mWalls = new FlxTilemap(); 
		_mWalls.loadMapFromArray(
			cast(_map.getLayer("walls"), TiledTileLayer).tileArray,
			_map.width, 
			_map.height,
			AssetPaths.tiles__png, 
			_map.tileWidth, 
			_map.tileHeight, 
			FlxTilemapAutoTiling.OFF,			1, 
			1, 
			3
		);
		_mWalls.follow();
		_mWalls.setTileProperties(2, FlxObject.NONE);
		_mWalls.setTileProperties(3, FlxObject.ANY);
		add(_mWalls);
		

		_player = new Player();
		var tmpMap:TiledObjectLayer = cast _map.getLayer("player-layer");
		for (e in tmpMap.objects)
		{
			placeEntities(e.name, e.xmlData.x);
		}

		add(_player);


		super.create();
	}

	function placeEntities(entityName:String, entityData:Xml):Void 
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player-obj") {
			_player.x = x; 
			_player.y = y;
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(_player, _mWalls);
	}
}
