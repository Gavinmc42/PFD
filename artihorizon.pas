unit artihorizon;

{$mode objfpc}{$H+}

interface

uses
  Threads,
  Console,
  SysUtils,
  OpenVG,       {Include the OpenVG unit so we can use the various types and structures}
  VGShapes,     {Include the VGShapes unit to give us access to all the functions}
  VC4;          {Include the VC4 unit to enable access to the GPU}

var

 HoriX:VGfloat;
 HoriY:VGfloat;
 Horisize:VGfloat;

 HleftX:VGfloat;
 HrightX:VGfloat;

 HbottomY:VGfloat;
 HtopY:VGfloat;

 HoriLL:VGfloat;
 HoriLR:VGfloat;


 PolyX:array[0..3] of VGfloat;
 PolyY:array[0..3] of VGfloat;

procedure horizon(var HoriX, HoriY, Horisize, yaw, roll, pitch: Integer);



implementation

procedure horizon(var HoriX, HoriY, Horisize, yaw, roll, pitch: Integer);

   var rolloffset:VGfloat;
   var pitchoffset:VGfloat;
begin



   //HoriX:=500;
   //HoriY:=500;
   //Horisize:=300;

   HleftX:= HoriX - Horisize /2;
   HrightX:= HoriX + Horisize /2;
   HtopY:= HoriY + Horisize /2;
   HbottomY:= HoriY - Horisize /2;

   rolloffset:= Horisize / 2 * sin(roll * pi / 180);
   pitchoffset:= Horisize / 2 * sin(pitch * pi / 180);

   HoriLR:=Horisize / 2 + rolloffset - pitchoffset;
   HoriLL:=Horisize / 2 - rolloffset - pitchoffset;


   {bluw sky}
   VGShapesFill(80,80,255,1.0);

   PolyX[0]:=HleftX;
   PolyX[1]:=HrightX;
   PolyX[2]:=HrightX;
   PolyX[3]:=HleftX;

   PolyY[0]:=HtopY;
   PolyY[1]:=HtopY;
   PolyY[2]:=HbottomY + HoriLR;
   PolyY[3]:=HbottomY + HoriLL;

   VGShapesPolygon(@PolyX,@PolyY,4);

   {brown ground   }
   VGShapesFill(128,80,20,1.0);

   PolyX[0]:=HleftX;
   PolyX[1]:=HrightX;
   PolyX[2]:=HrightX;
   PolyX[3]:=HleftX;

   PolyY[0]:=HbottomY;
   PolyY[1]:=HbottomY;
   PolyY[2]:=HbottomY + HoriLR;
   PolyY[3]:=HbottomY + HoriLL;

   VGShapesPolygon(@PolyX,@PolyY,4);

   {white markings}

   VGShapesStroke(255,255,255,1);
   VGShapesFill(255,255,255,1);
   VGShapesStrokeWidth(Horisize / 60);

   {left wing}
   VGShapesLine(HleftX + Horisize / 6 , HbottomY + Horisize / 2, HleftX + Horisize / 2.5 , HbottomY + Horisize / 2);
   VGShapesLine(HleftX + Horisize / 2.5 , HbottomY + Horisize / 2, HleftX + Horisize / 2.5 , HbottomY + Horisize / 2 - Horisize / 20);

   {right wing}
   VGShapesLine(HrightX - Horisize / 2.5 , HbottomY + Horisize / 2, HrightX - Horisize / 6 , HbottomY + Horisize / 2);
   VGShapesLine(HrightX - Horisize / 2.5 , HbottomY + Horisize / 2, HrightX - Horisize / 2.5 , HbottomY + Horisize / 2 - Horisize / 20);

   {Bezel, hides bad code output }
   VGShapesStrokeWidth(Horisize / 6);
   VGShapesStroke(60,60,60,1);
   VGShapesFill(0,0,0,0);
   VGShapesRoundrect(HoriX - (Horisize / 2 + Horisize / 12) , HoriY - (Horisize / 2 + Horisize / 12) , Horisize + Horisize / 6,  Horisize + Horisize / 6, Horisize / 4 , Horisize / 4 );


 end;



end.

