void SaveFile(File file)
{
  String[] content = new String[] {boardread() + "\n" + FEN.getText()};
  saveStrings(file, content);
}
void ReadFile(File file)
{
  gameInit();
  
  String[] lines = loadStrings(file);
  b = new Board(lines[0]);
  
  
  lines = subset(lines, 1);
  moveText.setText(join(lines,"\n"));
  for (String line : lines)
  {
    String[] s = line.split(" ");
    String whiteMove = s[1];
    int fromPos = whiteMove.charAt(0)-102 + parseInt("" + whiteMove.charAt(1));
    int toPos = whiteMove.charAt(2)-102 + parseInt("" + whiteMove.charAt(3));
    
  }
}
