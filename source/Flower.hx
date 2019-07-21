package; 

import flixel.FlxSprite; 
import flixel.FlxG; 

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Flower extends FlxSprite
{
    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y); 
    }

    override public function kill():Void
    {
        alive = false; 
        FlxTween.tween(
            this,
            { alpha: 0, y: y - 16 },
            .33, 
            { ease: FlxEase.circOut, onComplete: finishKill }
        );
    }

    function finishKill(_):Void
    {
        exists = false;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        loadGraphic(AssetPaths.flower__png, false, 8, 8);

    }
}