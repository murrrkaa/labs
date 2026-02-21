import { IAppState } from "./IAppState";
import { CApplication } from "../../app/CApplication";
import { CAddShapeCommand } from "../commands/CAddShapeCommand";

export class CAddShapeState implements IAppState {
  constructor(private app: CApplication) {}

  onMouseDownHandler(event: MouseEvent) {
    const point = {
      x: event.offsetX,
      y: event.offsetY,
    };
    const shape = this.app.CreateShape(point);

    const command = new CAddShapeCommand(this.app, shape);
    this.app.Execute(command);
  }
  onMouseMoveHandler(): void {}
  onMouseUpHandler(): void {}
}
