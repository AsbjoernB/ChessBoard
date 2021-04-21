//color lightSquares = color(200, 225, 200);
//color darkSquares = color(100, 200, 100);
color lightSquares = color(240, 217, 181);
color darkSquares = color(181, 136, 99);
import controlP5.*;
ControlP5 cp5;
int buttonCount = 2;
Button [] buttons = new Button [buttonCount];
Textarea FEN; 
Board b;

int selectedSquare = -1;

void setup()
{
  cp5 = new ControlP5(this);
  b = new Board("rn2Qk2/6p1/1pp4p/p7/P7/2q5/2P2PPP/4R1K1");
  size(1200, 800);
  noStroke();
  println(int('9'));
  println(b.pieces[0].pieceType);
  for (int i = 0; i < buttonCount; i++)
  {
    buttons[i] = cp5.addButton("Button"+i)
      .setSize(190, 30)
      .setPosition(805+i*200, 10);
  }
  FEN = cp5.addTextarea("FEN")
    .setSize(380, 30)
    .setPosition(810, 50)
    .setFont(createFont("Garamond", 32))
    .setText("oonga boonga");
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
      //rect((i%8)*100+25, floor(i/8)*100+25, 50, 50);
      image(b.pieces[i].img, (i%8)*100, floor(i/8)*100);
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
    boardread();
  }
}

void boardread()
{
  String translate = "";
  int tempVal = 0;
  for (int i = 0; i < b.pieces.length; i++)
  {
    if (b.pieces[i] != null)
    {
      if (i > 0 && b.pieces[i-1] == null)
      {
        if (tempVal != 0 )
        {
          translate = translate+str(tempVal);
          tempVal = 0;
        }
      }
      if (b.pieces[i].pieceColor == PieceColor.White)
      {
        switch(b.pieces[i].pieceType)
        {
        case Pawn:
          translate = translate+"P";

          break;

        case Bishop:
          translate = translate+"B";

          break;

        case Knight:
          translate = translate+"N";

          break; 

        case Rook:
          translate = translate+"R";

          break;

        case Queen:
          translate = translate+"Q";

          break;

        case King:
          translate = translate+"K";

          break;
        }
      } else
      {
        switch(b.pieces[i].pieceType)
        {
        case Pawn:
          translate = translate+"p";

          break;

        case Bishop:
          translate = translate+"b";

          break;

        case Knight:
          translate = translate+"n";

          break; 

        case Rook:
          translate = translate+"r";

          break;

        case Queen:
          translate = translate+"q";

          break;

        case King:
          translate = translate+"k";

          break;
        }
      }
    } else
    {
      tempVal++;
    }
    if (i != 0 && (i+1) % 8 == 0)
    {
      if (tempVal != 0)
      {
        translate = translate+str(tempVal);
        tempVal = 0;
      }
      translate = translate+"/";
    }
  }

  println(translate);
}
