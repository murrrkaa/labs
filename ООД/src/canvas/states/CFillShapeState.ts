import { IAppState } from "./IAppState";
import { CApplication } from "../../app/CApplication";
import { CFillShapeCommand } from "../commands/CFillShapeCommand";

export class CFillShapeState implements IAppState {
  constructor(private app: CApplication) {}

  onMouseDownHandler(event: MouseEvent): void {
    const canvas = this.app.GetCanvasManager();

    const point = {
      x: event.offsetX,
      y: event.offsetY,
    };

    let clickedAdapter = null;

    const adapters = canvas.GetAdapters();

    for (let i = adapters.length - 1; i >= 0; i--) {
      if (adapters[i].IsPointInside(point)) {
        clickedAdapter = adapters[i];
        break;
      }
    }

    if (clickedAdapter) {
      const shape = clickedAdapter.GetShape();

      const command = new CFillShapeCommand(this.app, shape);
      this.app.Execute(command);
    }
  }
  onMouseMoveHandler(): void {}
  onMouseUpHandler(): void {}
}
