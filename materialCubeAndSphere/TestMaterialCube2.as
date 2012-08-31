package
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.papervision3d.cameras.DebugCamera3D;
	import org.papervision3d.materials.BitmapFileMaterial;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.materials.special.CompositeMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.objects.primitives.Sphere;
	import org.papervision3d.view.BasicView;
	import org.papervision3d.view.stats.StatsView;

	public class TestMaterialCube2 extends BasicView
	{
		protected var cube:Cube;
		protected var es:Sphere;
		protected var es2:Sphere;
		protected var es3:Sphere;
		
		public function TestMaterialCube2()
		{
			super.opaqueBackground = true;
			super._camera = new DebugCamera3D(viewport);
			var s:StatsView = new StatsView(renderer);
			s.y=100
			super.addChild(s);
			
			setupScene();
		}
		
		protected function setupScene():void
		{
			var material:BitmapFileMaterial = new BitmapFileMaterial("texturaNegra.jpg");
			material.doubleSided = true;
			var materialList:MaterialsList = new MaterialsList();
			materialList.addMaterial(material, "all");
			
			cube = new Cube(materialList, 256, 256, 256, 5, 5, 5);
			scene.addChild(cube);
			
			material.smooth = true;
			es = new Sphere(material, 1100, 20, 20)
			
			scene.addChild(es);

			var compMat:CompositeMaterial = new CompositeMaterial();
			compMat.addMaterial( new WireframeMaterial(0x095306, 30, 5) );
			compMat.addMaterial( new ColorMaterial(0x9BF791, 0.2) ); 			
			es2 = new Sphere(compMat, 10, 3, 2);
			scene.addChild(es2)
			
			material.precise = true;
			es3 = new Sphere(material, 5000, 10, 10)
	//		scene.addChild(es3)
			
			var txt:TextField = new TextField();
			txt.autoSize = TextFieldAutoSize.RIGHT;
			txt.text = "**************************David Daniel**************************"
			txt.multiline = true;
			txt.setTextFormat( new TextFormat( "Arial", 16, 0xffffff) );
			super.addChild(txt);
			txt.x = 100;
			
			super.startRendering();
				
		}
		override protected function onRenderTick(event:Event=null):void
		{
			cube.yaw(2)
			cube.pitch(3)
			
			es3.yaw(2)
			es3.pitch(3)
			es.yaw(25)
			es2.yaw(25)
			if(camera.z == -10)
				camera.z = -1000;
			super.onRenderTick(event);
		}
	}
}