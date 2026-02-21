import { CApplication } from "../../app/CApplication";
import { IShapeAdapter } from "../../shapes/IShapeAdapter";
import { ICommand } from "./ICommand";

export class CChangeGroupCommand implements ICommand {
  private beforeAdapters!: IShapeAdapter[];
  private beforeSelected!: IShapeAdapter[];
  private afterAdapters!: IShapeAdapter[];
  private afterSelected!: IShapeAdapter[];

  constructor(
    private app: CApplication,
    private performChange: (
      adapters: IShapeAdapter[],
      selectedAdapters: IShapeAdapter[],
    ) => { adapters: IShapeAdapter[]; selectedAdapters: IShapeAdapter[] },
  ) {}

  Execute() {
    const canvas = this.app.GetCanvasManager();

    this.beforeAdapters = [...canvas.GetAdapters()];
    this.beforeSelected = [...canvas.GetSelectedAdapters()];

    const result = this.performChange(
      canvas.GetAdapters(),
      canvas.GetSelectedAdapters(),
    );

    canvas.SetAdapters(result.adapters);
    canvas.SetSelectedAdapters(result.selectedAdapters);
    canvas.RedrawCanvas();

    this.afterAdapters = [...result.adapters];
    this.afterSelected = [...result.selectedAdapters];
  }

  Undo() {
    const canvas = this.app.GetCanvasManager();
    canvas.SetAdapters([...this.beforeAdapters]);
    canvas.SetSelectedAdapters([...this.beforeSelected]);
    canvas.RedrawCanvas();
  }

  IsModified(): boolean {
    return (
      this.beforeAdapters !== this.afterAdapters ||
      this.beforeSelected !== this.afterSelected
    );
  }
}
