class Piece
{
  PieceType pieceType;
  PieceColor pieceColor;
  PImage img;
  Piece(PieceType pieceType, PieceColor pieceColor)
  {
    this.pieceType = pieceType;
    this.pieceColor = pieceColor;
    if (pieceColor == pieceColor.White)
    {
      switch(pieceType)
      {
      case Pawn:
        img = loadImage("PawnW.png");

        break;

      case Bishop:
        img = loadImage("BishopW.png");

        break;

      case Knight:
        img = loadImage("HorseyW.png");

        break; 

      case Rook:
        img = loadImage("RookW.png");

        break;

      case Queen:
        img = loadImage("QueenW.png");

        break;

      case King:
        img = loadImage("KingW.png");

        break;
      }
    } else
    {
      switch(pieceType)
      {
      case Pawn:
        img = loadImage("PawnB.png");

        break;

      case Bishop:
        img = loadImage("BishopB.png");

        break;

      case Knight:
        img = loadImage("HorseyB.png");

        break; 

      case Rook:
        img = loadImage("RookB.png");

        break;

      case Queen:
        img = loadImage("QueenB.png");

        break;

      case King:
        img = loadImage("KingB.png");

        break;
      }
    }
  }
}

enum PieceColor
{
  White, 
    Black
}
enum PieceType
{
  Pawn, 
    Bishop, 
    Knight, 
    Rook, 
    Queen, 
    King
}
