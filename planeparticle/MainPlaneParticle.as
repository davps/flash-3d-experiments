package
{
	import com.david5.misclases.PlaneSample;
	import flash.display.StageDisplayState;
	
	import flash.display.Sprite;

	public class MainPlaneParticle extends Sprite
	{
		protected var particulas:PlaneSample;
		public function MainPlaneParticle()
		{			
			particulas = new PlaneSample();			
			super.addChild(particulas);
		}		
	}
}