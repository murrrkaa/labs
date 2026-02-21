import { CApplication } from "../../app/CApplication";
import { IToolbarCommand } from "./IToolbarCommand";

export class CChangeStrokeColorCommand implements IToolbarCommand {
  constructor(
    private app: CApplication,
    private color: string,
  ) {}

  Execute(): void {
    this.app.StrokeColor = this.color;
  }
}
