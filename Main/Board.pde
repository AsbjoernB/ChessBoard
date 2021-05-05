class Board
{
  Piece[] pieces = new Piece[64];
  String FEN;

  Board(String FEN)
  {
    this.FEN = FEN;
    
    int boardPos = 0; 
    for (int i = 0; i < FEN.length(); i++)
    { 
      char c = FEN.charAt(i);
      if(c == ' ')
      {
        break;
      }
      if (int(c) >= 48 && int(c) <= 57)
      {
        int temp;
        temp = int(c)-48;
        boardPos += temp;
        continue;
      }
      if (c == '/')
      {
        continue;
      }
      PieceColor pieceCol;
      PieceType pieceType = PieceType.Pawn;
      if (c == Character.toUpperCase(c))
      {
        pieceCol = PieceColor.White;
      } else
      {
        pieceCol = PieceColor.Black;
      }
      switch(Character.toLowerCase(c))
      {
      case 'p':
        pieceType = PieceType.Pawn;
        break;
      case 'b':
        pieceType = PieceType.Bishop;
        break;
      case 'n':
        pieceType = PieceType.Knight;
        break;
      case 'r':
        pieceType = PieceType.Rook;
        break;
      case 'q':
        pieceType = PieceType.Queen;
        break;
      case 'k':
        pieceType = PieceType.King;
        break;
      }
      AddPiece(boardPos, pieceType, pieceCol);
      boardPos++;
    }
  }

  void AddPiece(int pos, PieceType type, PieceColor col)
  {
    pieces[pos] = new Piece(type, col);
  }
}
