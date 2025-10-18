
Unit Mst;

Interface

Procedure Compute(xx: PByte; yy: PByte; count: BYTE);

Implementation

Const 
  MAX_EDGES = 20;

Var 
  num_vertices: BYTE;
  edge_1 : array[0..MAX_EDGES-1] Of BYTE;
  edge_2 : array[0..MAX_EDGES-1] Of BYTE;
  edge_dist : array[0..MAX_EDGES-1] Of BYTE;
  parent: array[0..MAX_EDGES-1] Of BYTE;
  rank: array[0..MAX_EDGES-1] Of BYTE;
  components: BYTE;

Procedure Clear;
Begin
  FillChar(edge_1, MAX_EDGES * SizeOf(BYTE), 255);
  FillChar(edge_2, MAX_EDGES * SizeOf(BYTE), 255);
  FillChar(edge_dist, MAX_EDGES * SizeOf(BYTE), 255);
End;

Procedure CalculateEdges(xx: PByte; yy: PByte);

Var 
  i, j, k: BYTE;
  xdiff, ydiff: BYTE;
  dist: BYTE;
Begin
  k := 0;
  For i:=0 To num_vertices Do
    Begin
      For j:=i+1 To num_vertices Do
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

Procedure Swap(a, b: BYTE);

Var 
  temp: BYTE;
Begin
  temp := edge_dist[a];
  edge_dist[a] := edge_dist[b];
  edge_dist[b] := temp;

  temp := edge_1[a];
  edge_1[a] := edge_1[b];
  edge_1[b] := temp;

  temp := edge_2[a];
  edge_2[a] := edge_2[b];
  edge_2[b] := temp;
End;

Procedure UnionFind_Init;

Var i: BYTE;
Begin
  For i := 0 To num_vertices Do
    Begin
      parent[i] := i;
      rank[i] := 0;
    End;
  components := num_vertices + 1;
End;

Function UnionFind_Find(a: BYTE): BYTE;
Begin
  If parent[a] <> a Then
    Begin
      parent[a] := UnionFind_Find(parent[a]);
    End;
  UnionFind_Find := parent[a];
End;

Procedure UnionFind_Union(a, b: BYTE);

Var 
  root_a, root_b: BYTE;
Begin
  root_a := UnionFind_Find(a);
  root_b := UnionFind_Find(b);

  If root_a = root_b Then Exit;
  Dec(components);
  If rank[root_a] > rank[root_b] Then
    parent[root_b] := root_a
  Else
    If rank[root_a] < rank[root_b] Then
      parent[root_a] := root_b
  Else
    Begin
      parent[root_b] := root_a;
      Inc(rank[root_a]);
    End;
End;

// Simple bubble sort.
// Not many edges, so performance is not a concern. We optimize for size.
Procedure SortEdges;

Var 
  i, j: BYTE;
  temp: BYTE;
Begin
  For i := 0 To MAX_EDGES - 2 Do
    Begin
      For j := 0 To MAX_EDGES - 2 - i Do
        Begin
          If edge_dist[j+1] = 255 Then break;
          If edge_dist[j] > edge_dist[j+1] Then
            Begin
              Swap(j, j+1);
            End;
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
  WriteLn('----');
End;

Procedure Debug_UnionFind;

Var 
  i: BYTE;
Begin
  For i := 0 To num_vertices Do
    Begin
      WriteLn('Edge ', i:2, ' parent ', parent[i]:2, ' rank ', rank[i]:2);
    End;
  WriteLn('Components ', components:2);
  WriteLn('----');
End;

Procedure Compute(xx: PByte; yy: PByte; count: BYTE);

Var f: BYTE;
Begin
  Clear;
  num_vertices := count-1;
  CalculateEdges(xx, yy);

  Debug_DumpEdges;
  SortEdges;
  Debug_DumpEdges;

  UnionFind_Init;
  Debug_UnionFind;

  f := UnionFind_Find(0);
  WriteLn('Found ', f:2);
  f := UnionFind_Find(1);
  WriteLn('Found ', f:2);
  f := UnionFind_Find(2);
  WriteLn('Found ', f:2);
  WriteLn('----');

  UnionFind_Union(0, 1);

  f := UnionFind_Find(0);
  WriteLn('Found ', f:2);
  f := UnionFind_Find(1);
  WriteLn('Found ', f:2);
  f := UnionFind_Find(2);
  WriteLn('Found ', f:2);
  WriteLn('----');

End;

End.
