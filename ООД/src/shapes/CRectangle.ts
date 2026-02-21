import { IPoint } from "./IPoint";
import { CShape } from "./CShape";
import { IBoundingBox, ShapeTypeEnum } from "./IShape";
import { IRectangle } from "./IRectangle";
import {
  SHAPE_FILL_COLOR,
  SHAPE_STROKE_COLOR,
  SHAPE_STROKE_WIDTH,
} from "../constants/constants";
import { IMemento } from "./IMemento";
import { IShapeVisitor } from "../visitor/IShapeVisitor";

export class CRectangle extends CShape implements IRectangle {
  private point1: IPoint;
  private point2: IPoint;
  private fillColor: string = SHAPE_FILL_COLOR;
  private strokeColor: string = SHAPE_STROKE_COLOR;
  private strokeWidth: number = SHAPE_STROKE_WIDTH;

  constructor(point1: IPoint, point2: IPoint) {
    super(ShapeTypeEnum.RECTANGLE);
    this.point1 = point1;
    this.point2 = point2;
  }

  ComputePerimeter(): number {
    return 2 * (this.GetWidth() + this.GetHeight());
  }

  ComputeArea(): number {
    return this.GetWidth() * this.GetHeight();
  }

  ToFileString(): string {
    return `${this.typeShape}: P=${this.ComputePerimeter().toFixed(2)}; S=${this.ComputeArea().toFixed(2)}`;
  }

  GetPoints(): IPoint[] {
    return [this.point1, this.point2];
  }

  GetWidth(): number {
    return Math.abs(this.point2.x - this.point1.x);
  }

  GetHeight(): number {
    return Math.abs(this.point2.y - this.point1.y);
  }

  GetBoundingBox(): IBoundingBox {
    return {
      minX: Math.min(this.point1.x, this.point2.x),
      maxX: Math.max(this.point1.x, this.point2.x),
      minY: Math.min(this.point1.y, this.point2.y),
      maxY: Math.max(this.point1.y, this.point2.y),
    };
  }

  SetPoints(updatedPoints: IPoint[]) {
    this.point1 = updatedPoints[0];
    this.point2 = updatedPoints[1];
  }

  SetFillColor(color: string) {
    if (color) this.fillColor = color;
  }

  SetStrokeColor(color: string) {
    if (color) this.strokeColor = color;
  }

  SetStrokeWidth(width: number) {
    if (width) this.strokeWidth = width;
  }

  GetStrokeWidth(): number {
    return this.strokeWidth;
  }

  GetFillColor(): string {
    return this.fillColor;
  }

  GetStrokeColor(): string {
    return this.strokeColor;
  }

  Save(): IMemento {
    return {
      point1: { ...this.point1 },
      point2: { ...this.point2 },
      fillColor: this.fillColor,
      strokeColor: this.strokeColor,
      strokeWidth: this.strokeWidth,
    };
  }

  Restore(mementoShape: IMemento) {
    const mementoRectangle = mementoShape as any;
    this.point1 = { ...mementoRectangle.point1 };
    this.point2 = { ...mementoRectangle.point2 };
    this.fillColor = mementoRectangle.fillColor;
    this.strokeColor = mementoRectangle.strokeColor;
    this.strokeWidth = mementoRectangle.strokeWidth;
  }

  Accept(visitor: IShapeVisitor) {
    visitor.VisitRectangle(this);
  }
}
