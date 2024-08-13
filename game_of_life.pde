int scl = 35;
int cols;
int rows;

Cell[][] cells;
Cell[][] next_cells;

boolean running = false;

void setup() {
  fullScreen();
  //size(600, 600);
  stroke(150);
  
  cols = width / scl;
  rows = height / scl;
  cells = new Cell[cols][rows];
  next_cells = new Cell[cols][rows];

  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      cells[x][y] = new Cell();
      next_cells[x][y] = new Cell();
    }
  }
}

void draw() {
  if (frameCount % 10 != 0) return;

  background(0);

  cells = copyCells(next_cells);
  
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      Cell cell = cells[x][y];
      
      if (running) {
        Cell[] neighbours = new Cell[8];
        neighbours[0] = validateXY(x - 1, y - 1) ? cells[x - 1][y - 1] : (new Cell());
        neighbours[1] = validateXY(x    , y - 1) ? cells[x    ][y - 1] : (new Cell());
        neighbours[2] = validateXY(x + 1, y - 1) ? cells[x + 1][y - 1] : (new Cell());
        neighbours[3] = validateXY(x + 1, y    ) ? cells[x + 1][y    ] : (new Cell());
        neighbours[4] = validateXY(x + 1, y + 1) ? cells[x + 1][y + 1] : (new Cell());
        neighbours[5] = validateXY(x    , y + 1) ? cells[x    ][y + 1] : (new Cell());
        neighbours[6] = validateXY(x - 1, y + 1) ? cells[x - 1][y + 1] : (new Cell());
        neighbours[7] = validateXY(x - 1, y    ) ? cells[x - 1][y    ] : (new Cell());
        next_cells[x][y] = cell.next(neighbours);
      }
      
      fill(cell.state ? 255 : 0);
      rect(x * scl, y * scl, scl, scl);
    }
  }
}

void keyPressed() {
  if (keyCode == 32) {
    running = !running;
  }
}

void mousePressed() {
  int x = floor(mouseX / scl);
  int y = floor(mouseY / scl);
  cells[x][y].state = !cells[x][y].state;
  next_cells[x][y].state = cells[x][y].state;
}

Cell[][] copyCells(Cell[][] c) {
  Cell[][] copy = new Cell[cols][rows];
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      copy[x][y] = new Cell(c[x][y].state);
    }
  }
  return copy;
}

boolean validateXY(int x, int y) {
  boolean value = !(x < 0 || y < 0 || x >= cols || y >= rows);
  return value;
}
