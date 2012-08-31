package com.david5.objects
{
	import org.papervision3d.core.geom.*;
	import org.papervision3d.core.geom.renderables.Triangle3D;
	import org.papervision3d.core.geom.renderables.Vertex3D;
	import org.papervision3d.core.math.NumberUV;
	import org.papervision3d.core.proto.*;	

	public class AlgebraicSurface extends TriangleMesh3D
	{

		/**
		* Number of segments horizontally. Defaults to 1.
		*/
		public var segmentsW :Number;
	
		/**
		* Number of segments vertically. Defaults to 1.
		*/
		public var segmentsH :Number;
	
		/**
		* Default size of Plane if not texture is defined.
		*/
		static public var DEFAULT_SIZE :Number = 500;
	
		/**
		* Default size of Plane if not texture is defined.
		*/
		static public var DEFAULT_SCALE :Number = 1;
	
		/**
		* Default value of gridX if not defined. The default value of gridY is gridX.
		*/
		static public var DEFAULT_SEGMENTS :Number = 10;


		public function AlgebraicSurface(material:MaterialObject3D, 
			segmentsW:Number=0, segmentsH:Number=0, width:Number = 100,  
			height:Number = 100, curvaType:Number = 1)
		{
			
			super(material, new Array(), new Array(), null);

			this.segmentsW = segmentsW || DEFAULT_SEGMENTS; // Defaults to 1
			this.segmentsH = segmentsH || this.segmentsW;   // Defaults to segmentsW
	
			var scale :Number = DEFAULT_SCALE;
	
			if( ! height )
			{
				if( width )
					scale = width;
	
				if( material && material.bitmap )
				{
					width  = material.bitmap.width  * scale;
					height = material.bitmap.height * scale;
				}
				else
				{
					width  = DEFAULT_SIZE * scale;
					height = DEFAULT_SIZE * scale;
				}
			}			
			buildSuperficie(width, height, curvaType);
		}
		private function buildSuperficie(width:Number, height:Number, curvaType:Number):void			
		{
			var gridX    :Number = this.segmentsW;
			var gridY    :Number = this.segmentsH;
			var gridX1   :Number = gridX + 1;
			var gridY1   :Number = gridY + 1;
	
			var vertices :Array  = this.geometry.vertices;
			var faces    :Array  = this.geometry.faces;
	
			var textureX :Number = width /2;
			var textureY :Number = height /2;
	
			var iW       :Number = width / gridX;
			var iH       :Number = height / gridY;	
			
			// Vertices
			var z:Number;
			for( var ix:int = 0; ix < gridX + 1; ix++ )
			{
				for( var iy:int = 0; iy < gridY1; iy++ )
				{
					var x :Number = ix * iW - textureX;
					var y :Number = iy * iH - textureY;
	
					if(curvaType == 1)
						z = 5*Math.sin(y*Math.PI/180)*Math.pow(Math.E, 3*Math.sin(x*Math.PI/180));
					if(curvaType == 2)
					  	z = 1*Math.cos(2*Math.PI*(1/3)*x*Math.PI/180) * y;
					if(curvaType == 3)  	
						z = 40*Math.sin(2*Math.PI*(200/width)*y*Math.PI/180) * Math.sin(2*Math.PI*(200/width)*x*Math.PI/180);
					if(curvaType == 4)
						z = Math.tan(2*Math.PI*(1/width)*y*x)
					if(curvaType == 5)											
						z = 500000000/( Math.pow(x,2)*y + Math.pow(y,3) )
					if(curvaType == 6)											
						z = 100* ( Math.cos(Math.PI*x/180) + Math.cos(Math.PI*y/180) )
					if(curvaType == 7)											
						z = Math.pow( 5*( ( Math.cos(Math.PI*x/180) + Math.cos(Math.PI*y/180) ) ), 2);
					if(curvaType == 8)											
						z = Math.pow( 4*( ( Math.cos(Math.PI*x/180) + Math.cos(Math.PI*y/180) ) ), 3);
					if(curvaType == 9)											
						z = Math.pow( 2*( ( Math.cos(Math.PI*x/180) + Math.cos(Math.PI*y/180) ) ), 4);
					if(curvaType == 10)											
						z = Math.pow( 1.4*( ( Math.cos(Math.PI*x/180) + Math.cos(Math.PI*y/180) ) ), 5);
					if(curvaType == 11)											
						z = Math.pow( 5000*Math.abs( ( Math.cos(Math.PI*x/180) + Math.cos(Math.PI*y/180) ) ), 0.5);
					if(curvaType == 12)											
						z = 20*Math.cos( Math.pow(x*Math.PI/180,2) + Math.pow(y*Math.PI/180,2) )
					if(curvaType == 13)											
						z = Math.pow(2*Math.cos( Math.pow(x*Math.PI/180,2) + Math.pow(y*Math.PI/180,2) ), 7);
					if(curvaType == 14)											
						z = Math.pow(3*Math.sin( Math.pow(x*Math.PI/180,2) + Math.pow(y*Math.PI/180,2) ), 3);
					if(curvaType == 15)											
						z = Math.pow(Math.abs(4*Math.cos( Math.pow(x*Math.PI/180,2) + Math.pow(y*Math.PI/180,2) )), 3);
					if(curvaType == 16)											
						z = 70*Math.cos( Math.abs(x*Math.PI/180) + Math.abs(y*Math.PI/180) );
					if(curvaType == 17)											
						z = 15*Math.cos( Math.abs(x*Math.PI/180) + Math.abs(y*Math.PI/180) ) * ( Math.abs(x*Math.PI/180) + Math.abs(y*Math.PI/180) );
					if(curvaType == 18)											
						z = 50*Math.sin( Math.abs(Math.PI*x/180) - Math.abs(Math.PI*y/180) );
					if(curvaType == 19)											
						z = ( Math.pow(x,4) + Math.pow(y,4) )/50000000;
					if(curvaType == 20)											
						z = ( Math.pow(x,2) - Math.pow(y,2) )/100;
					if(curvaType == 21)											
						z = ( Math.pow(x,3) + Math.pow(y,3) )/100000;
					if(curvaType == 22)											
						z = ( Math.pow(x,2) * Math.pow(y,3) )/5000000000;
					if(curvaType == 23)											
						z = ( Math.pow(x,4) - Math.pow(y,4) )/30000000;
					if(curvaType == 24)											
						z = ( Math.pow(x,2)*y + Math.pow(y,3) )/80000 


					vertices.push( new Vertex3D(x,y,z) );
				}
			}

			var a:Vertex3D;
			var b:Vertex3D;
			var c:Vertex3D;
			var d:Vertex3D;
			var uvA:NumberUV; 
			var uvB:NumberUV;
			var uvC:NumberUV;
			var uvD:NumberUV;

			var uvAx:Number
			var uvBx:Number;
			var uvCx:Number;
			var uvDx:Number;
			var uvAy:Number;
			var uvBy:Number;
			var uvCy:Number;
			var uvDy:Number;
			var menU:Number = vertices[0].x;
			var menV:Number = vertices[0].y;
			var mayU:Number = vertices[0].x;
			var mayV:Number = vertices[0].y;
			for(var i:uint=0; i<vertices.length; i++) //halla el menor y mayor valor de "x" y de "y"
			{
				if( vertices[i].x < menU )
					menU = vertices[i].x;
				if( vertices[i].y < menV )
					menV = vertices[i].y;
				if( vertices[i].x > mayU )
					mayU = vertices[i].x;
				if( vertices[i].y > mayU )
					mayV = vertices[i].y;
			}						
			for(  ix = 0; ix < gridX; ix++ )
			{
				for(  iy= 0; iy < gridY; iy++ )
				{
					a = vertices[ 	ix   * gridY1 +   iy  	];
					b = vertices[ 	ix   * gridY1 + (iy+1)	];
					c = vertices[ (ix+1) * gridY1 +   iy 	];
					d = vertices[ (ix+1) * gridY1 + (iy+1) 	];					
	
					uvAx = Math.abs( (a.x - menU) / (mayU - menU + 0.000001) );
					uvAy = Math.abs( (a.y - menV) / (mayV - menV + 0.000001) );
					uvBx = Math.abs( (b.x - menU) / (mayU - menU + 0.000001) );
					uvBy = Math.abs( (b.y - menV) / (mayV - menV + 0.000001) );
					uvCx = Math.abs( (c.x - menU) / (mayU - menU + 0.000001) );
					uvCy = Math.abs( (c.y - menV) / (mayV - menV + 0.000001) );
					uvDx = Math.abs( (d.x - menU) / (mayU - menU + 0.000001) );
					uvDy = Math.abs( (d.y - menV) / (mayV - menV + 0.000001) );
													
					uvA = new NumberUV(uvAx, uvAy);
					uvB = new NumberUV(uvBx, uvBy);
					uvC = new NumberUV(uvCx, uvCy);
					uvD = new NumberUV(uvDx, uvDy);
					faces.push( new Triangle3D(this, [a,c,b], null, [uvA,uvC,uvB]) );
					faces.push( new Triangle3D(this, [d,b,c], null, [uvD,uvB,uvC]) );					
				}
			}
			this.geometry.ready = true;			
			this.geometry.flipFaces();
		}		
	}
}