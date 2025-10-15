
Unit Mst;

Interface

Procedure Compute(xx: PByte; yy: PByte; count: BYTE);

Implementation

Const 
  MAX_EDGES = 20;

Var 
  edge_1 : array[0..MAX_EDGES-1] Of BYTE;
  edge_2 : array[0..MAX_EDGES-1] Of BYTE;
  edge_dist : array[0..MAX_EDGES-1] Of BYTE;

Procedure Clear;
Begin
  FillChar(edge_1, MAX_EDGES * SizeOf(BYTE), 255);
  FillChar(edge_2, MAX_EDGES * SizeOf(BYTE), 255);
  FillChar(edge_dist, MAX_EDGES * SizeOf(BYTE), 255);
End;

Procedure CalculateEdges(xx: PByte; yy: PByte; count: BYTE);

Var 
  i, j, k: BYTE;
  xdiff, ydiff: BYTE;
  dist: BYTE;
Begin
  k := 0;
  For i:=0 To count-1 Do
    Begin
      For j:=i+1 To count-1 Do
        Begin
          xdiff := Abs(xx[i] - xx[j]);
          ydiff := Abs(yy[i] - yy[j]);
          dist := xdiff + ydiff;

          edge_1[k] := i;
          edge_2[k] := j;
          edge_dist[k] := dist;
          Inc(k);
        End;
    End;
End;

Procedure Debug_DumpEdges;

Var 
  i: BYTE;
Begin
  i := 0;
  While True Do
    Begin
      If edge_1[i] = 255 Then break;
      WriteLn('Edge from ', edge_1[i]:2, ' to ', edge_2[i]:2, ' distance ', edge_dist[i]:3);
      Inc(i);
    End;
End;

Procedure Compute(xx: PByte; yy: PByte; count: BYTE);
Begin
  Clear;
  CalculateEdges(xx, yy, count);

  Debug_DumpEdges;
End;

End.
