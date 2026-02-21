import { IAppState } from "./IAppState";
import { IPoint } from "../../shapes/IPoint";
import { CApplication } from "../../app/CApplication";
import { CShapeAdapter } from "../../shapes/CShapeAdapter";
import { CMoveShapeCommand } from "../commands/CMoveShapeCommand";
import { IMemento } from "../../shapes/IMemento";

export class CMoveShapeState implements IAppState {
  private lastMousePosition: IPoint | null = null;
  private isDragging: boolean = false;
  private draggedAdapter: CShapeAdapter | null = null;

  private totalDx: number = 0;
  private totalDy: number = 0;

  private beforeMemento!: IMemento;

  constructor(private app: CApplication) {}

  onMouseDownHandler(event: MouseEvent): void {
    const canvas = this.app.GetCanvasManager();
    const { x, y } = canvas.GetCursorPoint(event);

    for (let i = canvas.GetAdapters().length - 1; i >= 0; i--) {
      const adapter = canvas.GetAdapters()[i];
      const isSelected = canvas.GetSelectedAdapters().includes(adapter);
      if (isSelected && adapter.IsPointInside({ x, y })) {
        this.isDragging = true;
        this.lastMousePosition = {
          x,
          y,
        };
        this.draggedAdapter = adapter;
        this.beforeMemento = adapter.GetShape().Save();

        canvas.GetAdapters().splice(i, 1);
        canvas.GetAdapters().push(adapter);
        break;
      }
    }
  }

  onMouseMoveHandler(event: MouseEvent): void {
    const canvas = this.app.GetCanvasManager();
    const { x: cursorX, y: cursorY } = canvas.GetCursorPoint(event);

    if (!this.isDragging || !this.draggedAdapter || !this.lastMousePosition)
      return;

    const dx = cursorX - this.lastMousePosition.x;
    const dy = cursorY - this.lastMousePosition.y;

    this.draggedAdapter?.Move(dx, dy);
    this.lastMousePosition = { x: cursorX, y: cursorY };

    this.totalDx += dx;
    this.totalDy += dy;

    canvas.RedrawCanvas();
  }

  onMouseUpHandler(event: MouseEvent): void {
    if (this.draggedAdapter && (this.totalDx || this.totalDy)) {
      const command = new CMoveShapeCommand(
        this.app,
        this.draggedAdapter,
        this.beforeMemento,
      );
      this.app.Execute(command);
    }

    this.isDragging = false;
    this.lastMousePosition = null;
    this.draggedAdapter = null;
  }
}
