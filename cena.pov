global_settings {
  assumed_gamma 2.2
}

#include "shapes.inc"
#include "colors.inc"
#include "metals.inc"
#include "woods.inc"

#declare MyRadius = 2  ;
#declare XPosition = 0  ; 
#declare ZPosition = 1  ;     
#declare Raio = 25;  
#declare N_Esferas = 24   ;
#declare WhiteBall = sphere { < XPosition, MyRadius, ZPosition > MyRadius pigment {White} }
#declare LightX = 0;
#declare LightY = 40;
#declare LightZ = -40;
#declare SRadius = 0;
#declare SFalloff = 11;  

camera {
   location <30, 55, -85>
   direction <0, 0, 2>
   look_at <0, 0, 1>
}

light_source {<800, 600, -200> colour White}

light_source {
    <LightX, LightY, LightZ> color White
    spotlight
    point_at <0, 0, 0>
    tightness 0
    radius SRadius
    falloff SFalloff 
}

light_source {
   <-10, 20, -10> color White

   area_light <4, 0, 0>, <0, 0, 4>, 9, 9
   adaptive 1
   jitter
}

#declare BaseDoPeao =
union {
    intersection {
       sphere {<0, 0, 0>, 2.5}
       plane {-y, 0}
    }
}  

#declare Peao = union {
   sphere {<0, 7, 0>, 1.5}
   sphere {<0, 0, 0>, 1
      scale <1.2, 0.3, 1.2>
      translate 5.5*y
   }

   intersection {
      plane {y, 5.5}
      object {
         Hyperboloid_Y
         translate 5*y
         scale <0.5, 1, 0.5>
      }
      plane {-y, -2.5}
   }

   sphere { <0, 0, 0>, 1
      scale <2, 0.5, 2>
      translate <0, 2.3, 0>
   }
   object {BaseDoPeao}
}

#declare Madeira = texture {
    T_Silver_3B
}

#declare PeaoBranco = object {
   Peao
   texture {
      Madeira
      pigment {quick_color red 0.95 green 0.62}
   }
}

object {
    plane{y,0}
    pigment {checker color rgb <1,1,1> color rgb <0,0,0>}
    scale 6
}

#declare BallCount = 0;

#while (BallCount < 2*pi) 
	#declare MyRadius = MyRadius + 0    ;
	#declare XPosition = Raio*cos(BallCount)  ;
	#declare ZPosition = Raio*sin(BallCount)  ;
	#declare WhiteBall = sphere { < XPosition, MyRadius, ZPosition > MyRadius texture {Madeira}}   ;
	#declare BallCount = BallCount + 2*pi/N_Esferas   ;          
	object { WhiteBall }
#end

PeaoBranco  

