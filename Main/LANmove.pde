class LANmove
{
  int fromPos;
  int toPos;
  Piece capturedPiece;
  
  public LANmove(int fromPos, int toPos, Piece capturedPiece)
  {
    this.fromPos = fromPos;
    this.toPos = toPos;
    this.capturedPiece = capturedPiece;
  }
  
  String getNotation()
  {
    return ("abcdefgh".charAt(fromPos%8) + str(8-fromPos/8) + "abcdefgh".charAt(toPos%8) + str(8-toPos/8));
  }
  
}
 
