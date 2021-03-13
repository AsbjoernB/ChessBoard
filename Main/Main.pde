//color lightSquares = color(200, 225, 200);
//color darkSquares = color(100, 200, 100);
color lightSquares = color(240, 217, 181);
color darkSquares = color(181, 136, 99);

Board b = new Board();

void setup()
{
  size(1200, 800);
  background(80, 80, 100);
  noStroke();
  
  for (int r = 0; r < 8; r++)
  {
    for (int f = 0; f < 8; f++)
    {
      if ((r+f) % 2 == 0)
        fill (lightSquares);
      else
        fill(darkSquares);
      rect(r*100, f*100, 100, 100);
    }
  }
  
  b.AddPiece(32, PieceType.Rook, PieceColor.White);
  
  for (int i = 0; i < 64; i++)
  {
    if (b.pieces[i] != null)
    {
      fill(255,0,0);
      rect((i%8)*100, floor(i/8)*100, 100, 100);
    }
  }
}

void draw()
{

}
