
Uses Graph, Crt;

Program Main;

Const 
  MAX_CITIES = 10;
  SCREEN_WIDTH = 38;
  SCREEN_HEIGHT = 22;

Var 
  city_x: array[0..MAX_CITIES-1] Of BYTE;
  city_y: array[0..MAX_CITIES-1] Of BYTE;
  num_cities: BYTE;
  i: BYTE;

Function CityExists(x, y: BYTE): BOOLEAN;

Var 
  i: BYTE;
Begin
  CityExists := false;
  For i := 0 To MAX_CITIES - 1 Do
    Begin
      If city_x[i] = 255 Then break;
      If (city_x[i] = x) And (city_y[i] = y) Then
        Begin
          CityExists := true;
          exit;
        End;
    End;
End;

Procedure InitCities(num_cities: BYTE);

Var 
  i: BYTE;
  maybe_x, maybe_y: BYTE;
Begin
  For i := 0 To num_cities - 1 Do
    Begin

      While True Do
        Begin
          maybe_x := Random(SCREEN_WIDTH)+2;
          maybe_y := Random(SCREEN_HEIGHT)+2;
          If Not CityExists(maybe_x, maybe_y) Then
            Begin
              city_x[i] := maybe_x;
              city_y[i] := maybe_y;
              break;
            End;
        End;
    End;
End;

Procedure InitFixedCities();
Begin
  city_x[0] := 2; city_y[0] := 2;
  city_x[1] := 14; city_y[1] := 8;
  city_x[2] := 10; city_y[2] := 10;
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
  //InitCities(num_cities);
  InitFixedCities;
  InitGraph(0+16);

  CursorOff;

  DrawCities;

  Repeat
  Until false;
End.
