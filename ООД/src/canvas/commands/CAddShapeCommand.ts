import { ICommand } from "./ICommand";
import { IShape } from "../../shapes/IShape";
import { CApplication } from "../../app/CApplication";
import { IShapeAdapter } from "../../shapes/IShapeAdapter";

export class CAddShapeCommand implements ICommand {
  private befoteSelected!: IShapeAdapter[];
  constructor(
    private app: CApplication,
    private shape: IShape,
  ) {}

  Execute() {
    const canvasManager = this.app.GetCanvasManager();
    this.befoteSelected = canvasManager.GetSelectedAdapters();

    canvasManager.AddShape(this.shape);
  }

  Undo() {
    const canvasManager = this.app.GetCanvasManager();
    canvasManager.SetSelectedAdapters(this.befoteSelected);

    canvasManager.RemoveShape(this.shape);
  }

  IsModified(): boolean {
    return true;
  }
}
