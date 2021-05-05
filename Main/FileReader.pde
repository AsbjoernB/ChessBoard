void SaveFile(File file)
{
  if (file == null)
    return;
  
  String[] content = new String[] {b.FEN};
  content = splice(content, moveText.getText().split("\n"), 1);
  saveStrings(file.getAbsolutePath(), content);
}
void ReadFile(File file)
{
  if (file == null)
    return;
  
  gameInit();
  
  println(moveIndex);
  String[] lines = loadStrings(file);
  b = new Board(lines[0]);


  lines = subset(lines, 1);
  moveText.setText(join(lines, "\n"));
  moveNum = lines.length;
  
  // loops all LAN moves
  for (String line : lines)
  {
    String[] moves = line.split(" ");
    for (int i = 1; i < moves.length; i++)
    {
      println(moves[i]);
      int fromPos = (moves[i].charAt(0)-97) + (8-parseInt("" + moves[i].charAt(1)))*8;
      int toPos = (moves[i].charAt(2)-97) + (8-parseInt("" + moves[i].charAt(3)))*8;
      println(fromPos, toPos);
      Piece capturedPiece = b.pieces[toPos];
      
      b.pieces[toPos] = b.pieces[fromPos];
      b.pieces[fromPos] = null;
       
      moveList.add(new LANmove(fromPos, toPos, capturedPiece));
      moveIndex++;
    }
  }
  whiteToMove = !(moveIndex % 2 == 0);
  println(moveIndex);
  
}
