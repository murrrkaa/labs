import { ICanvasManager } from "./ICanvasManager";
import { IShape } from "../shapes/IShape";
import { CCircle } from "../shapes/CCircle";
import { CCircleAdapter } from "../shapes/CCircleAdapter";
import { CTriangle } from "../shapes/CTriangle";
import { CRectangleAdapter } from "../shapes/CRectangleAdapter";
import { CRectangle } from "../shapes/CRectangle";
import { CTriangleAdapter } from "../shapes/CTriangleAdapter";
import { IShapeAdapter } from "../shapes/IShapeAdapter";
import { CShapeGroup } from "../shapes/CShapeGroup";
import { CShapeGroupAdapter } from "../shapes/CShapeGroupAdapter";
import { CGroupController } from "../controllers/groupController/CGroupController";
import { CSelectionController } from "../controllers/selectionController/CSelectionController";
import { IPoint } from "../shapes/IPoint";
import {
  CANVAS_CONTEXT,
  CANVAS_TABINDEX,
  EVENT_CLICK,
  EVENT_KEYDOWN,
  EVENT_MOUSEDOWN,
  EVENT_MOUSEMOVE,
  EVENT_MOUSEUP,
  KEYBOARD_GROUP,
  KEYBOARD_UNGROUP,
} from "../constants/constants";
import { CApplication } from "../app/CApplication";
import { CChangeGroupCommand } from "./commands/CChangeGroupCommand";

export class CCanvasManager implements ICanvasManager {
  private app: CApplication;
  private canvas: HTMLCanvasElement;
  private ctx: CanvasRenderingContext2D;
  private adapters: IShapeAdapter[] = [];
  private selectedAdapters: IShapeAdapter[] = [];

  constructor(canvasId: string, app: CApplication) {
    this.app = app;
    this.canvas = document.getElementById(canvasId) as HTMLCanvasElement;
    this.ctx = this.canvas.getContext(
      CANVAS_CONTEXT,
    ) as CanvasRenderingContext2D;
    this.canvas.tabIndex = CANVAS_TABINDEX;

    this.canvas.addEventListener(EVENT_CLICK, (e: MouseEvent) =>
      this.HandleClickCanvas(e),
    );

    this.canvas.addEventListener(EVENT_KEYDOWN, (e: KeyboardEvent) =>
      this.HandleKeydownCanvas(e),
    );

    this.canvas.addEventListener(EVENT_MOUSEDOWN, (e: MouseEvent) =>
      this.app.State.onMouseDownHandler(e),
    );

    this.canvas.addEventListener(EVENT_MOUSEMOVE, (e: MouseEvent) =>
      this.app.State.onMouseMoveHandler(e),
    );

    this.canvas.addEventListener(EVENT_MOUSEUP, (e: MouseEvent) =>
      this.app.State.onMouseUpHandler(e),
    );
  }

  AddShape(shape: IShape) {
    let adapter: IShapeAdapter | null = null;
    if (shape instanceof CCircle) adapter = new CCircleAdapter(shape);
    if (shape instanceof CTriangle) adapter = new CTriangleAdapter(shape);
    if (shape instanceof CRectangle) adapter = new CRectangleAdapter(shape);
    if (!adapter) return;

    this.adapters.push(adapter);
    this.selectedAdapters = [adapter];

    this.RedrawCanvas();
  }

  RemoveShape(shape: IShape) {
    const index = this.adapters.findIndex(
      (adapter) => adapter.GetShape() === shape,
    );
    if (index !== -1) {
      this.adapters.splice(index, 1);

      this.selectedAdapters = this.selectedAdapters.filter(
        (adapter) => adapter.GetShape() !== shape,
      );

      this.RedrawCanvas();
    }
  }

  GetAdapters(): IShapeAdapter[] {
    return [...this.adapters];
  }

  SetAdapters(adapters: IShapeAdapter[]): void {
    this.adapters = [...adapters];
  }

  DrawShapes(shapes: IShape[]) {
    this.adapters = shapes
      .map((shape) => this.CreateAdapter(shape))
      .filter((shape) => !!shape);

    this.DrawAdapters();
  }

  GetSelectedAdapters() {
    return [...this.selectedAdapters];
  }

  SetSelectedAdapters(adapters: IShapeAdapter[]) {
    this.selectedAdapters = [...adapters];
  }

  private DrawAdapters() {
    this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
    this.adapters.forEach((adapter) => {
      const isSelected = this.selectedAdapters.includes(adapter);
      adapter.DrawShape(this.ctx, isSelected);
    });
  }

  private HandleClickCanvas(e: MouseEvent) {
    this.canvas.focus();
    const cursorPoint = this.GetCursorPoint(e);
    this.selectedAdapters = CSelectionController.SelectionShape(
      e,
      cursorPoint.x,
      cursorPoint.y,
      this.adapters,
      this.selectedAdapters,
    );
    this.RedrawCanvas();
  }

  private HandleKeydownCanvas(e: KeyboardEvent) {
    if (e.ctrlKey && e.key.toLowerCase() === KEYBOARD_GROUP) {
      const command = new CChangeGroupCommand(this.app, (adapters, selected) =>
        CGroupController.GroupSelectedShapes(adapters, selected),
      );
      this.app.Execute(command);
    }
    if (e.ctrlKey && e.key.toLowerCase() === KEYBOARD_UNGROUP) {
      const command = new CChangeGroupCommand(this.app, (adapters, selected) =>
        CGroupController.UngroupSelectedShape(adapters, selected),
      );
      this.app.Execute(command);
    }
  }

  private CreateAdapter(shape: IShape): IShapeAdapter | null {
    if (shape instanceof CCircle) return new CCircleAdapter(shape);
    if (shape instanceof CTriangle) return new CTriangleAdapter(shape);
    if (shape instanceof CRectangle) return new CRectangleAdapter(shape);

    if (shape instanceof CShapeGroup) {
      const innerAdapters = shape
        .GetShapes()
        .map((shape) => this.CreateAdapter(shape))
        .filter((adapter) => adapter !== null);

      return new CShapeGroupAdapter(shape, innerAdapters);
    }

    return null;
  }

  GetCursorPoint(e: MouseEvent): IPoint {
    const rect = this.canvas.getBoundingClientRect();
    const cursorX = e.clientX - rect.left;
    const cursorY = e.clientY - rect.top;

    return {
      x: cursorX,
      y: cursorY,
    };
  }

  RedrawCanvas() {
    this.DrawAdapters();
  }
}
