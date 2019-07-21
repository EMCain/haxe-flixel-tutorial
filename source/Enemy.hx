package;

import flixel.FlxSprite; 

class Enemy extends FlxSprite
{
    public var speed:Float = 140; 
    public var etype(default, null):String; 

    public function new(X:Float=0, Y:Float=0, EType:String) {
        super(X, Y);
        etype = EType; 
        loadGraphic("assets/images/slime-" + etype + ".png", true, 16, 16);
        animation.add("all", [0, 1, 2, 3], 6, false); 
        drag.x = drag.y = 10;
        width = 8;
        height = 8;
        offset.x = 4;
    }
    override public function draw():Void
    {
        animation.play("all");
        super.draw();
    }
}