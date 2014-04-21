/* TODO title project, etc
 * TODO lookup "static", etc
 * TODO lookup/define terminology - cell/col/row/box/group/option/solution
 * TODO decide col/row first?
 */

class SudokuSolver
{
  //TODO decide if this should be an object. Maybe even cells as Obj?
  //  This might help when storing backups and allow for more flexibility.
  //array holding the notes/solutions
  private boolean[][][] notes = new boolean[9][9][9];

  //checks basic groups. If a solution is already in place in that
  //  col/row/box turns that option in false in all cells
  //TODO check and see if there's a way to tell this is new.
  //  Maybe just do this process after a new number has been placed,
  //  and then just in that cell's  groups
  private void groups ()
  {

  }

  //if no solutions arise from any of the other solving methods,
  //  just save a copy of the current puzzle, assume the lowest col/row
  //  without a solution has the lowest option, then move on
  //If the sanity test ever fails, it will fall back to the latest brute
  //  force attempt, remove the lowest option, and move on
  private void bruteForce ()
  {

  }
  
  //TODO if sudoku becomes it's own class, this should go with it
  //checks to see if the puzzle is sane by checking for cells with 0 opt
  //  If sanity fails, does not automatically return false.
  //  First, sees if a brute force backup exists. If it does,
  //  rolls back to that backup, removes the lowest possible note,
  //  deletes the backup, then rechecks sanity
  //If no backups exist, puzzle is unsolvable and sane returns false
  private boolean sane ()
  {
    
  }

}
