package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxObject;

import flixel.group.FlxGroup.FlxTypedGroup;

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
	var _grpFlowers:FlxTypedGroup<Flower>;

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
			FlxTilemapAutoTiling.OFF,			
			1, 
			1, 
			3
		);
		_mWalls.follow();
		_mWalls.setTileProperties(2, FlxObject.NONE);
		_mWalls.setTileProperties(3, FlxObject.ANY);
		add(_mWalls);
		
		_grpFlowers = new FlxTypedGroup<Flower>();
		add(_grpFlowers);

		_player = new Player();
		var tmpMap:TiledObjectLayer = cast _map.getLayer("player-layer");
		for (e in tmpMap.objects)
		{
			placeEntities(e.name, e.xmlData.x);
		}
		add(_player);

		FlxG.camera.follow(_player, TOPDOWN, 1);

		super.create();
	}

	function placeEntities(entityName:String, entityData:Xml):Void 
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player-obj") {
			_player.x = x; 
			_player.y = y;
		} else if (entityName == "flower") {
			_grpFlowers.add(new Flower(x + 4, y + 4));
		}
	}
	
	function playerTouchFlower(P:Player, F:Flower):Void
	{
		if (P.alive && P.exists && F.alive && F.exists) 
		{
			F.kill();
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(_player, _mWalls);
		FlxG.overlap(_player, _grpFlowers, playerTouchFlower);
	}
}
