import { CApplication } from "../../app/CApplication";
import { IToolbarCommand } from "./IToolbarCommand";

export class CChangeLineWidthCommand implements IToolbarCommand {
  constructor(
    private app: CApplication,
    private width: number,
  ) {}

  Execute(): void {
    this.app.StrokeWidth = this.width;
  }
}
