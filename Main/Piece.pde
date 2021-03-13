class Piece
{
  PieceType pieceType;
  PieceColor pieceColor;
  
  Piece(PieceType pieceType, PieceColor pieceColor)
  {
    this.pieceType = pieceType;
    this.pieceColor = pieceColor;
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
