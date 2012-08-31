package
{
	import com.david5.objects.AlgebraicSurface;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.papervision3d.cameras.DebugCamera3D;
	import org.papervision3d.core.geom.renderables.Vertex3D;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.materials.special.CompositeMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.view.BasicView;
	import org.papervision3d.view.stats.StatsView;

	public class MainAlgebraicSurface1 extends BasicView
	{
		protected var superficie:AlgebraicSurface;
		protected var material:CompositeMaterial;
		protected var cube:Cube;
		protected var txt:TextField;
		protected var c:uint = 1;

		protected var widthD:Number = 600;
		protected var heightD:Number = 600;
		
		protected var transitionArray:Array = new Array();
		
				
//		[Embed(source="1.jpg")]
//		private var rustAsset:Class;
		
		public function MainAlgebraicSurface1()
		{
			stage.frameRate = 60;
			super.opaqueBackground = true
			super._camera = new DebugCamera3D(viewport);
			var st:StatsView = new StatsView(renderer); st.y=100;
			super.addChild(st);
			buildTransitionArray();
			instructionsOfUse();
			setupScene();
		}
		protected function instructionsOfUse():void
		{
				txt = new TextField();
				txt.autoSize = TextFieldAutoSize.LEFT; import flash.text.TextFieldAutoSize;
				txt.text = "Press spacebar to transform the mesh" //+ c.toString();
				txt.multiline = true;
				txt.setTextFormat( new TextFormat("Arial", 20, 0xffffff) );
				txt.y = 200;
				super.addChild(txt);			
		}
		protected function buildTransitionArray():void
		{
			transitionArray[0] = "easenone";
			transitionArray.push("linear");
			transitionArray.push("easeinquad");
			transitionArray.push("easeoutquad");
			transitionArray.push("easeinoutquad");
			transitionArray.push("easeoutinquad");
			transitionArray.push("easeincubic");
			transitionArray.push("easeoutcubic");
			transitionArray.push("easeinoutcubic");
			transitionArray.push("easeoutincubic");
			transitionArray.push("easeinquart");
			transitionArray.push("easeoutquart");
			transitionArray.push("easeinoutquart");
			transitionArray.push("easeoutinquart");
			transitionArray.push("easeinquint");
			transitionArray.push("easeoutquint");
			transitionArray.push("easeinoutquint");
			transitionArray.push("easeinsine");			
			transitionArray.push("easeoutsine");
			transitionArray.push("easeinoutsine");
			transitionArray.push("easeoutinsine");
			transitionArray.push("easeincirc");
			transitionArray.push("easeoutcirc");
			transitionArray.push("easeinoutcirc");
			transitionArray.push("easeoutincirc");
		}
			
		protected function setupScene():void
		{
			var width:Number = 600;
			var height:Number = 600;
			//var curveType:uint = 12;
			
			var matW:WireframeMaterial = new WireframeMaterial(0xffffff,0.3);
			matW.doubleSided = true;
			var matL:MaterialsList = new MaterialsList();
			matL.addMaterial( matW, "all");			
			cube = new Cube(matL, width, (width+height)/2,  height);
			//scene.addChild(cube)
			
			//var matB:BitmapMaterial = new BitmapMaterial(Bitmap(new rustAsset()).bitmapData);
			var material:CompositeMaterial = new CompositeMaterial();			
			material.addMaterial(matW);
			//material.addMaterial(matB);
											
			material.doubleSided = true;
			
			superficie = new AlgebraicSurface(material, 20,20, widthD, heightD, c);
			scene.addChild(superficie);
			
			stage.addEventListener(KeyboardEvent.KEY_UP, keyEvent);			
						
			super.startRendering();			
		}		
		protected function keyEvent(event:KeyboardEvent):void		
		{
			if(event.keyCode == 32)
			{
				if (c>23)
					c=0;
				c++
			
				var superficie2:AlgebraicSurface = new AlgebraicSurface(material, 20,20, widthD, heightD, c);
			
				var verticesA:Array = superficie.geometry.vertices;
				var verticesB:Array = superficie2.geometry.vertices;
				var facesA:Array = superficie.geometry.faces;
				var facesB:Array = superficie2.geometry.faces;


				import caurina.transitions.Tweener;
				for(var i:uint=0; i<verticesA.length-1; i++)
				{
					var a:Vertex3D = verticesA[i];
					var b:Vertex3D = verticesB[i]

					var tiempo:Number =  Math.abs(1*Math.random())+ 0.2;
					var transicion:String = transitionArray[Math.floor( (transitionArray.length-1)*Math.random() )];
					var escala:Number = Math.abs(1*Math.random())+1
					Tweener.addTween( a, {x:b.x, y:b.y, z:b.z, 
										  time:tiempo, 
										  transition:transicion} )
				}
			}
		}
		override protected function onRenderTick(event:Event=null):void
		{
			superficie.yaw(2);
			superficie.pitch(1);
			super.onRenderTick(event);
		}
	}
}