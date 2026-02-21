import { ICommand } from "./ICommand";
import { IShapeAdapter } from "../../shapes/IShapeAdapter";
import { IMemento } from "../../shapes/IMemento";
import { CApplication } from "../../app/CApplication";

export class CMoveShapeCommand implements ICommand {
  private beforeSelected!: IShapeAdapter[];

  constructor(
    private app: CApplication,
    private shapeAdapter: IShapeAdapter,
    private before: IMemento,
  ) {}

  Execute() {
    const canvas = this.app.GetCanvasManager();
    this.beforeSelected = canvas.GetSelectedAdapters();
  }

  Undo() {
    const canvas = this.app.GetCanvasManager();
    const shape = this.shapeAdapter.GetShape();
    shape.Restore(this.before);
    canvas.SetSelectedAdapters(this.beforeSelected);
    canvas.RedrawCanvas();
  }

  IsModified(): boolean {
    return true;
  }
}
