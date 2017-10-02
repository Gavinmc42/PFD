program PFD;

{$mode objfpc}{$H+}

{ VideoCore IV example - OpenVG Demo                                           }


uses
  RaspberryPi, {Include RaspberryPi2 to make sure all standard functions are included}
  GlobalConst,
  GlobalTypes,
  Threads,
  Console,
  SysUtils,
  OpenVG,       {Include the OpenVG unit so we can use the various types and structures}
  VGShapes,     {Include the VGShapes unit to give us access to all the functions}
  VC4,
  artihorizon;          {Include the VC4 unit to enable access to the GPU}

var
 Width:Integer;  {A few variables used by our shapes example}
 Height:Integer;
 

 ArtiHoriX:Integer;
 ArtiHoriY:Integer;
 ArtiHorisize:Integer;

 yawangle:Integer;
 rollangle:Integer;
 pitchangle:Integer;

 WindowHandle:TWindowHandle;

 
begin
 {Create a console window as usual}
 WindowHandle:=ConsoleWindowCreate(ConsoleDeviceGetDefault,CONSOLE_POSITION_FULL,True);

 ConsoleWindowWriteLn(WindowHandle,'Starting PFD Demo');

 Width:=ConsoleWindowGetWidth(WindowHandle);
 Height:=ConsoleWindowGetHeight(WindowHandle);

 {Initialize OpenVG and the VGShapes unit}
 VGShapesInit(Width,Height); 
 
 {set some values for testing}

 ArtiHoriX:=500;
 ArtiHoriY:=500;
 ArtiHorisize:=300;
 yawangle:=0;
 rollangle:=10;
 pitchangle:=10;
 
 {Start a picture the full width and height of the screen}
 VGShapesStart(Width,Height);
 
 {Make the background black}
 VGShapesBackground(0,0,0);

 {add PFD instruments}


 while true do
   begin

     horizon(ArtiHoriX, ArtiHoriY, ArtiHorisize, yawangle, rollangle, pitchangle);
     rollangle:= rollangle + 1;
     {End our picture and render it to the screen}
     VGShapesEnd;
     Sleep(100);

   end;

 {Clear our screen, cleanup OpenVG and deinitialize VGShapes}
 VGShapesFinish;
 
 {VGShapes calls BCMHostInit during initialization, we should also call BCMHostDeinit to cleanup}
 BCMHostDeinit;
 
 ConsoleWindowWriteLn(WindowHandle,'Completed VGShapes Demo');
 
 {Halt the main thread here}
 ThreadHalt(0);
end.

