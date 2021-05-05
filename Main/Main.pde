import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.utils.*;
import controlP5.*;
UiBooster booster = new UiBooster();
ControlP5 cp5;


//color lightSquares = color(200, 225, 200);
//color darkSquares = color(100, 200, 100);
color lightSquares = color(240, 217, 181);
color darkSquares = color(181, 136, 99);
int buttonCount = 3;
Button [] buttons = new Button [buttonCount];
Textarea FEN; 
Board b;
CColor buttonsColor = new CColor();

int moveIndex = -1;
ArrayList<LANmove> moveList = new ArrayList<LANmove>();
Textarea moveText;


String gameNotation;
boolean whiteToMove = true;
int moveNum = 1;
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
      .setSize(360, 30)
      .setPosition(830, 40*i)
      .setColor(buttonsColor)
      .setFont(createFont("Arial", 17));
  }
  
  buttons[0].setLabel("Start spil");
  buttons[1].setLabel("Indlaes spil");
  buttons[2].setLabel("Gem spil");

  moveText = cp5.addTextarea("moves")
    .setSize(370, 300)
    .setPosition(825, 150)
    .setFont(createFont("Garamond", 32))
    .setText("1. ")
    .setColor(0);
}

// sørger for at alting sættes tilbage til startværdierne, når et spil f.eks. indlæses
void gameInit()
{
  moveNum = 1;
  moveIndex = -1;
  moveList.clear();
  moveText.setText("1.");
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
      
      fill(0);
      text(f*8+r, r*100+50, f*100+50);
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
  // move back)
  if (keyCode == LEFT)
  {
    if (moveIndex >= 0)
    {
      LANmove move = moveList.get(moveIndex);
      b.pieces[move.fromPos] = b.pieces[move.toPos];
      b.pieces[move.toPos] = move.capturedPiece;
      moveIndex--;
    }
  }
  // move forward
  else if (keyCode == RIGHT)
  {
    if (moveIndex < moveList.size()-1)
    {
      moveIndex++;
      LANmove move = moveList.get(moveIndex);
      b.pieces[move.toPos] = b.pieces[move.fromPos];
      b.pieces[move.fromPos] = null;
    }
  }
  // start
  else if (keyCode == DOWN)
  {
    while (moveIndex < moveList.size()-1)
    {
      moveIndex++;
      LANmove move = moveList.get(moveIndex);
      b.pieces[move.toPos] = b.pieces[move.fromPos];
      b.pieces[move.fromPos] = null;
    }
  }
  // end
  else if (keyCode == UP)
  {
    while (moveIndex >= 0)
    {
      LANmove move = moveList.get(moveIndex);
      b.pieces[move.fromPos] = b.pieces[move.toPos];
      b.pieces[move.toPos] = move.capturedPiece;
      moveIndex--;
    }
  }
}
void mousePressed()
{
  if (mouseButton == RIGHT)
  {
    selectedSquare = -1;
  } else if (mouseButton == LEFT)
  {
    if (mouseX >= 0 && mouseX <= 800 && mouseY >= 0 && mouseY <= 800)
    {
      int x = floor(mouseX/100);
      int y = floor(mouseY/100);
      int newSquare = y*8+x;

      // if a square is already selected
      if (selectedSquare != -1)
      {
        // deselect
        if (selectedSquare == newSquare)
          selectedSquare = -1;
        // select new square
        else if (b.pieces[newSquare] != null && b.pieces[selectedSquare].pieceColor == b.pieces[newSquare].pieceColor)
          selectedSquare = newSquare;

        // move piece
        else if (moveIndex == moveList.size()-1)
        {
          moveIndex++;
          LANmove move = new LANmove(selectedSquare, newSquare, b.pieces[newSquare]); 
          moveList.add(move);
          moveText.append(move.getNotation() + " ");

          if (!whiteToMove)
          {
            moveNum++;
            moveText.append("\n"+moveNum+". ");
          }
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

void controlEvent(ControlEvent theEvent)
{
  if (theEvent.getController().getName().equals("Button0"))
  {
    //gameNotation = booster.showTextInputDialog("Indtast FEN notation");
    FilledForm gameNotation = booster.createForm("FEN").addText("FEN Notation", "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR").show();
    if (gameNotation != null && !gameNotation.equals(""))
    {
      gameInit();
      b = new Board(gameNotation.getByIndex(0).asString());
    }
  }
  if (theEvent.getController().getName().equals("Button1"))
  {
    selectInput("Indlæs spil", "ReadFile");
  }
  if (theEvent.getController().getName().equals("Button2"))
  {
    selectOutput("Gem spil", "SaveFile");
  }
}
