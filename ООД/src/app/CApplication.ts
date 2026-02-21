import { CCanvasManager } from "../canvas/CCanvasManager";
import { CShapeProcessor } from "../shapes/CShapeProcessor";
import {
  APP_FILL_COLOR,
  APP_STROKE_COLOR,
  APP_STROKE_WIDTH,
  CANVAS_ID,
  CIRCLE_DEFAULT_RADIUS,
} from "../constants/constants";
import { IShape, ShapeTypeEnum } from "../shapes/IShape";
import { IPoint } from "../shapes/IPoint";
import { CCircle } from "../shapes/CCircle";
import { CRectangle } from "../shapes/CRectangle";
import { CTriangle } from "../shapes/CTriangle";
import { IAppState } from "../canvas/states/IAppState";
import { CIdleState } from "../canvas/states/CIdleState";
import { CCaretakerMemento } from "../CCaretakerMemento/CCaretakerMemento";
import { ICommand } from "../canvas/commands/ICommand";
import { CToolbar } from "../toolbar/CToolbar";

export class CApplication {
  private static appInstance: CApplication;

  private canvasManager: CCanvasManager;
  private shapeProcessor: CShapeProcessor;
  private state: IAppState;
  private commandManager: CCaretakerMemento;
  private toolbar!: CToolbar;

  private currentShapeType: ShapeTypeEnum = ShapeTypeEnum.CIRCLE;
  private strokeColor: string = APP_STROKE_COLOR;
  private fillColor: string = APP_FILL_COLOR;
  private strokeWidth: number = APP_STROKE_WIDTH;

  private constructor() {
    this.canvasManager = new CCanvasManager(CANVAS_ID, this);
    this.shapeProcessor = new CShapeProcessor();
    this.state = new CIdleState(this);
    this.commandManager = new CCaretakerMemento();
  }

  static GetInstance(): CApplication {
    if (!CApplication.appInstance)
      CApplication.appInstance = new CApplication();
    return CApplication.appInstance;
  }
  set Toolbar(toolbar: CToolbar) {
    this.toolbar = toolbar;
  }

  GetCanvasManager(): CCanvasManager {
    return this.canvasManager;
  }

  GetShapeProcessor(): CShapeProcessor {
    return this.shapeProcessor;
  }

  get State(): IAppState {
    return this.state;
  }

  set State(state: IAppState) {
    this.state = state;
  }

  get CurrentShapeType(): ShapeTypeEnum {
    return this.currentShapeType;
  }

  set CurrentShapeType(currentShapeType: ShapeTypeEnum) {
    this.currentShapeType = currentShapeType;
  }

  get StrokeColor(): string {
    return this.strokeColor;
  }

  set StrokeColor(strokeColor: string) {
    this.strokeColor = strokeColor;
  }

  get StrokeWidth(): number {
    return this.strokeWidth;
  }

  set StrokeWidth(strokeWidth: number) {
    this.strokeWidth = strokeWidth;
  }

  get FillColor(): string {
    return this.fillColor;
  }

  set FillColor(fillColor: string) {
    this.fillColor = fillColor;
  }

  CreateShape(point: IPoint): IShape {
    let shape;
    switch (this.currentShapeType) {
      case ShapeTypeEnum.CIRCLE:
        shape = new CCircle(point, CIRCLE_DEFAULT_RADIUS);
        break;
      case ShapeTypeEnum.RECTANGLE:
        shape = new CRectangle(
          { x: point.x - 110, y: point.y - 70 },
          { x: point.x + 110, y: point.y + 70 },
        );
        break;
      case ShapeTypeEnum.TRIANGLE:
        shape = new CTriangle(
          { x: point.x - 60, y: point.y + 60 },
          { x: point.x + 60, y: point.y + 60 },
          { x: point.x, y: point.y - 60 },
        );
        break;
    }
    shape.SetStrokeColor(this.strokeColor);
    shape.SetFillColor(this.fillColor);
    shape.SetStrokeWidth(this.strokeWidth);
    return shape;
  }

  Execute(command: ICommand) {
    this.commandManager.ExecuteCommand(command);
  }

  Undo() {
    this.commandManager.Undo();
  }
}
