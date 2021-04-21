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
CColor buttonsColor = new CColor();

Textarea moves;

boolean whiteToMove = true;
int moveNum = 1;
>>>>>>> Stashed changes

int selectedSquare = -1;

void setup()
{
  cp5 = new ControlP5(this);
  b = new Board("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR");
  size(1200, 800);
  noStroke();
  boardread();
  buttonsColor
    .setActive(color(196, 160, 130))
    .setForeground(color(188, 148, 115))
    .setBackground(color(181, 136, 99));
  for (int i = 0; i < buttonCount; i++)
  {
    buttons[i] = cp5.addButton("Button"+i)
      .setSize(170, 30)
      .setPosition(825+i*200, 10)
      .setColor(buttonsColor)
      .setFont(createFont("Arial", 17));
  }
  FEN = cp5.addTextarea("FEN")
    .setSize(370, 50)
    .setPosition(825, 50)
    .setFont(createFont("Arial", 17))
    .setLabel("FEN")
    .setText(boardread())
    .hideScrollbar();
  buttons[0].setLabel("Indlaes spil");
  buttons[1].setLabel("Spil herfra");
    .setSize(380, 30)
    .setPosition(810, 50)
    .setFont(createFont("Garamond", 32))
    .setText("oonga boonga");
    
  moves = cp5.addTextarea("moves")
    .setSize(380, 300)
    .setPosition(810, 150)
    .setFont(createFont("Garamond", 32))
    .setText("1. ");
}

void draw()
{
  background(240, 217, 181);
  fill(155, 140, 117);
  rect(800, 0, 20, 800);
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
void keyPressed()
{
  println(moves.getText());
}
void mousePressed()
{
  if (mouseButton == RIGHT)
  {
    selectedSquare = -1;
  }
  else if (mouseButton == LEFT)
  {
    if (mouseX >= 0 && mouseX <= 800 && mouseY >= 0 && mouseY <= 800)
    {
      int x = floor(mouseX/100);
      int y = floor(mouseY/100);
      int newSquare = y*8+x;
      
      // if a square is already selected
      if (selectedSquare != -1)
      {
        if (selectedSquare == newSquare)
          selectedSquare = -1;
        else if (b.pieces[newSquare] != null && b.pieces[selectedSquare].pieceColor == b.pieces[newSquare].pieceColor)
          selectedSquare = newSquare;
        else
        {
          String moveString = "";
          switch (b.pieces[selectedSquare].pieceType)
          {
            case Pawn: break;
            case Bishop: moveString += 'B'; break;
            case Knight: moveString += 'N'; break;
            case Rook: moveString += 'R'; break;
            case Queen: moveString += 'Q'; break;
            case King: moveString += 'K'; break;
          }
          if (b.pieces[newSquare] != null)
          {
            if (b.pieces[selectedSquare].pieceType == PieceType.Pawn)
              moveString += "abcdefgh".charAt(selectedSquare%8);
            moveString += 'x';
          }
          moveString += "abcdefgh".charAt(newSquare%8);
          moveString += 8-newSquare/8;
          println(moveString);
          moves.append(moveString + " ");
          
          if (!whiteToMove)
          {
            moveNum++;
            moves.append("\n"+moveNum+". ");
          }
            
          moveString = "";
          
          // move piece
          b.pieces[newSquare] = b.pieces[selectedSquare];
          b.pieces[selectedSquare] = null;
          selectedSquare = -1;
          
          whiteToMove = !whiteToMove;
        }
        
      }
      // else if no square is selected and piece is clicked
      else if (b.pieces[newSquare] != null && (b.pieces[newSquare].pieceColor == PieceColor.White) == whiteToMove)
      {
        selectedSquare = newSquare;
      }
    }
  }
}

String boardread()
{
  String translate = "";
  int tempVal = 0;
  for (int i = 0; i < b.pieces.length; i++)
  {
    String translate = "";
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
    if (i != 0 && (i+1) % 8 == 0 && i+1 != 64)
    {
      if (tempVal != 0)
      {
        translate = translate+str(tempVal);
        tempVal = 0;
      }
      translate = translate+"/";
    }
  }
  return(translate);
}
