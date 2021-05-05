void SaveFile(String file)
{
  String content = boardread() + "\n" + FEN.getText();
}
void ReadFile(String file)
{
  String[] lines = loadStrings(file);
  b = new Board(lines[0]);
  
  lines = subset(lines, 1);
  moveText.setText(join(lines,"\n"));
}
