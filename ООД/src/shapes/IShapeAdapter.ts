import { IPoint } from "./IPoint";
import { IShape } from "./IShape";

export interface IShapeAdapter {
  DrawShape(ctx: CanvasRenderingContext2D, isSelected: boolean): void;
  IsPointInside(point: IPoint): boolean;

  GetShape(): IShape;
  Move(dx: number, dy: number): void;
}
