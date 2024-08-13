class Cell {
  public boolean state = false;
  
  Cell() {}
  Cell(boolean state) {
    this.state = state;
  }

  Cell next(Cell[] c) {
    int n = 0;
    for (int i = 0; i < c.length; i++) {
      if (c[i].state) {
        n++;
      }
    }
    
    // first rule
    if (this.state && n < 2) {
      return new Cell(false);
    }

    // second rule
    if (this.state && (n == 2 || n == 3)) {
      return new Cell(true);
    }

    // third rule
    if (this.state && n > 3) {
      return new Cell(false);
    }

    // fourth rule
    if (!this.state && n == 3) {
      return new Cell(true);
    }

    return new Cell();
  }
}
