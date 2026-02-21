import { ICommand } from "./ICommand";
import { CApplication } from "../../app/CApplication";
import { IShape } from "../../shapes/IShape";
import { IMemento } from "../../shapes/IMemento";
import { CShapeStyleVisitor } from "../../visitor/CShapeStyleVisitor";
import { IShapeAdapter } from "../../shapes/IShapeAdapter";

export class CFillShapeCommand implements ICommand {
  private before!: IMemento;
  private befoteSelected!: IShapeAdapter[];

  constructor(
    private app: CApplication,
    private shape: IShape,
  ) {}

  Execute() {
    this.before = this.shape.Save();
    const canvasManager = this.app.GetCanvasManager();
    this.befoteSelected = canvasManager.GetSelectedAdapters();
    const visitor = new CShapeStyleVisitor(
      this.app.FillColor,
      this.app.StrokeColor,
      this.app.StrokeWidth,
    );

    this.shape.Accept(visitor);

    canvasManager.RedrawCanvas();
  }

  Undo() {
    this.shape.Restore(this.before);
    this.app.GetCanvasManager().SetSelectedAdapters(this.befoteSelected);
    this.app.GetCanvasManager().RedrawCanvas();
  }

  IsModified(): boolean {
    const after = this.shape.Save();

    return JSON.stringify(this.before) !== JSON.stringify(after);
  }
}
