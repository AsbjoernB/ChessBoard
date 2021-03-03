int ranks = 7;
int files = 8;

//color lightSquares = color(200, 225, 200);
//color darkSquares = color(100, 200, 100);
color lightSquares = color(240, 217, 181);
color darkSquares = color(181, 136, 99);

void setup()
{
  size(1000, 800);
  background(100);
  noStroke();
  
  for (int r = 0; r < ranks; r++)
  {
    for (int f = 0; f < files; f++)
    {
      if ((r+f) % 2 == 0)
        fill (lightSquares);
      else
        fill(darkSquares);
      rect(r*100, f*100, 100, 100);
    }
  }
}

void draw()
{

}
