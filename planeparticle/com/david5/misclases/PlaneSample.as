package com.david5.misclases
{
	import flash.events.Event;
	
	import org.papervision3d.core.geom.Particles;
	import org.papervision3d.core.geom.renderables.Particle;
	import org.papervision3d.core.geom.renderables.Vertex3D;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.materials.special.Letter3DMaterial;
	import org.papervision3d.materials.special.ParticleMaterial;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.objects.special.ParticleField;
	import org.papervision3d.typography.Text3D;
	import org.papervision3d.typography.fonts.HelveticaRoman;
	import org.papervision3d.view.BasicView;
	import org.papervision3d.view.stats.StatsView;


	public class PlaneSample extends BasicView
	{
		protected var partField			:ParticleField;
		protected var vParticles		:Particles;
		protected var vParticlesPlano	:Particles;
		protected var plane				:Plane;
		protected var cont				:Number;
		
		public function PlaneSample(viewportWidth:Number=640, viewportHeight:Number=480, scaleToStage:Boolean=true, interactive:Boolean=false, cameraType:String="Debug")
		{
			super(viewportWidth, viewportHeight, scaleToStage, interactive, cameraType);
			super.opaqueBackground = true;
			super.addChild( new StatsView(renderer) )
			setupScene();
		}
		protected function setupScene():void
		{
			//plano sin material
			var size:Number = 30;
			var ancho:Number = 50000;
			var planeMaterial:WireframeMaterial	   = new WireframeMaterial(0xffffff,.5);
			planeMaterial.doubleSided=true;
			plane								   = new Plane(planeMaterial, ancho/10, ancho, size-1, size-1);
			scene.addChild(plane);

			//particula roja			
			var partMaterial	 :ParticleMaterial = new ParticleMaterial(0xFF0000,1);
			vParticles 			   				   = new Particles("partMaterial");
			vParticles.addParticle( new Particle(partMaterial, 30, 0,0,1000) );
			scene.addChild(vParticles);
			
/*			//verticeA del plano con particula AMARILLA			
			var vs:Array = plane.geometry.vertices;
			var vA:Vertex3D = vs[0] as Vertex3D;
			var planePartMaterial:ParticleMaterial = new ParticleMaterial(0xFacb00,1);
			vParticlesPlano 					   = new Particles("planePartMaterial");
			vParticlesPlano.addParticle(new Particle(planePartMaterial,
														50,  	//tamaño
														vA.x, 	//x
														vA.y, 	//y
														vA.z));	//z
			scene.addChild(vParticlesPlano);														
*/			//verticeB del plano con particula AMARILLA
			var vs:Array = plane.geometry.vertices;
			var v:Vertex3D;
			var planePartMaterial:ParticleMaterial;
			var color:Number;
			for (var i:Number = 0; i< plane.geometry.vertices.length; i++)
			{										
				v= vs[i] as Vertex3D;
				color = 0xFFFFFF * (1-i/plane.geometry.vertices.length);
				planePartMaterial = new ParticleMaterial(color,1);
				vParticlesPlano   = new Particles("planePartMaterial");
				vParticlesPlano.addParticle(new Particle(planePartMaterial,
															ancho/(size*20),  	//tamaño
															v.x, 	//x
															v.y, 	//y
															v.z));	//z
				scene.addChild(vParticlesPlano);
			}
			//particulas verde limon
			var material:ParticleMaterial = new ParticleMaterial(0x0FFF0f,1);
			partField = new ParticleField(material, 5000, 50,10000,200000,10000);
			//partField.y = 20000; 
			scene.addChild(partField);		

			//particulas rojas
			var materialoBS:ParticleMaterial = new ParticleMaterial(0xFF0000,1);
			partField = new ParticleField(materialoBS, 10, 3000,10000,200000,10000);
			//partField.y = 20000; 
			scene.addChild(partField);		
			
			startRendering();			
		}
		override protected function onRenderTick(event:Event=null):void
		{
			plane.yaw(5);
			
			camera.y= camera.y + 500;
					
			if (Math.abs(camera.y) > 40001)
				camera.y = -40000				
					
			super.onRenderTick(event);
		}		
	}
}