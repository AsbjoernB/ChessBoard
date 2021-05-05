void SaveFile(File file)
{
  String[] content = new String[] {boardread() + "\n" + FEN.getText()};
  saveStrings(file, content);
}
void ReadFile(File file)
{
  String[] lines = loadStrings(file);
  b = new Board(lines[0]);
  
  lines = subset(lines, 1);
  moveText.setText(join(lines,"\n"));
}
