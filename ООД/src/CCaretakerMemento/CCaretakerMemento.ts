import { ICommand } from "../canvas/commands/ICommand";

export class CCaretakerMemento {
  private mementos: ICommand[] = [];

  ExecuteCommand(command: ICommand) {
    command.Execute();

    if (command.IsModified()) {
      this.mementos.push(command);
    }
  }

  Undo() {
    const command = this.mementos.pop();
    if (command) command?.Undo();
  }
}
