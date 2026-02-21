import { IToolbarCommand } from "./IToolbarCommand";
import { CApplication } from "../../app/CApplication";

export class CChangeFillColorCommand implements IToolbarCommand {
  constructor(
    private app: CApplication,
    private color: string,
  ) {}

  Execute(): void {
    this.app.FillColor = this.color;
  }
}
