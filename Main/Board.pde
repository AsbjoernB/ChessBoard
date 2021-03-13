class Board
{
  Piece[] pieces = new Piece[64];
  
  Board(String FEN)
  {
  }
  
  void AddPiece(int pos, PieceType type, PieceColor col)
  {
    pieces[pos] = new Piece(type, col);
  }
  
}
