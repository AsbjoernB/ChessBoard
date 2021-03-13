//color lightSquares = color(200, 225, 200);
//color darkSquares = color(100, 200, 100);
color lightSquares = color(240, 217, 181);
color darkSquares = color(181, 136, 99);

Board b = new Board("");

int selectedSquare = -1;

void setup()
{
  size(1200, 800);
  noStroke();
  b.AddPiece(32, PieceType.Rook, PieceColor.White);
  b.AddPiece(23, PieceType.Rook, PieceColor.White);
  b.AddPiece(44, PieceType.Rook, PieceColor.Black);
  b.AddPiece(0, PieceType.Rook, PieceColor.Black);
  

  println(int('9'));
}

void draw()
{
  background(80, 80, 100);
  
  // draw board
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
  
  // draw pieces and selected square
  for (int i = 0; i < 64; i++)
  {
    // draw selected square
    if (i == selectedSquare)
    {
      fill(100);
      rect((i%8)*100, floor(i/8)*100, 100, 100);
    }
    
    // draw pieces
    if (b.pieces[i] != null)
    {
      if (b.pieces[i].pieceColor == PieceColor.White)
        fill(250);
      else
        fill(10);
      rect((i%8)*100+25, floor(i/8)*100+25, 50, 50);
    }
  }
}

void mousePressed()
{
  
  if (mouseX >= 0 && mouseX <= 800 && mouseY >= 0 && mouseY <= 800)
  {
    int x = floor(mouseX/100);
    int y = floor(mouseY/100);
    int newSquare = y*8+x;
    
    // if no square is selected and a piece was clicked
    if (selectedSquare == -1)
    {
      if (b.pieces[newSquare] != null)
      {
        selectedSquare = newSquare;
      }
    }
    
    // else if a square is already selected
    else if (b.pieces[selectedSquare] != null)
    {
      // move piece
      selectedSquare = -1;
    }
    
    println(selectedSquare);
  }
}
