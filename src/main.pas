
Uses Graph, Crt;

Program Main;

Const 
  MAX_CITIES = 10;
  SCREEN_WIDTH = 35;
  SCREEN_HEIGHT = 20;

Var 
  city_x: array[0..MAX_CITIES-1] Of BYTE;
  city_y: array[0..MAX_CITIES-1] Of BYTE;
  num_cities: BYTE;
  i: BYTE;

Procedure InitCities(num_cities: BYTE);

Var 
  i: BYTE;
Begin
  For i := 0 To num_cities - 1 Do
    Begin
      city_x[i] := Random(SCREEN_WIDTH);
      city_y[i] := Random(SCREEN_HEIGHT);
    End;
End;

Procedure DrawCities();
Begin
  For i := 0 To MAX_CITIES - 1 Do
    Begin
      If city_x[i] = 255 Then break;
      GotoXY(city_x[i], city_y[i]);
      Write('X');
    End;
End;

Begin
  FillChar(city_x, MAX_CITIES * SizeOf(BYTE), 255);
  FillChar(city_y, MAX_CITIES * SizeOf(BYTE), 255);

  Randomize;
  num_cities := 3;
  InitCities(num_cities);
  InitGraph(0+16);
  CursorOff;

  DrawCities;

  Repeat
  Until false;
End.
