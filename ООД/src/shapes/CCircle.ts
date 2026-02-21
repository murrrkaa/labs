import { CShape } from "./CShape";
import { IPoint } from "./IPoint";
import { IBoundingBox, ShapeTypeEnum } from "./IShape";
import { ICircle } from "./ICircle";
import {
  SHAPE_FILL_COLOR,
  SHAPE_STROKE_COLOR,
  SHAPE_STROKE_WIDTH,
} from "../constants/constants";
import { IMemento } from "./IMemento";
import { IShapeVisitor } from "../visitor/IShapeVisitor";

export class CCircle extends CShape implements ICircle {
  private center: IPoint;
  private radius: number;
  private fillColor: string = SHAPE_FILL_COLOR;
  private strokeColor: string = SHAPE_STROKE_COLOR;
  private strokeWidth: number = SHAPE_STROKE_WIDTH;

  constructor(center: IPoint, radius: number) {
    super(ShapeTypeEnum.CIRCLE);
    this.center = center;
    this.radius = radius;
  }

  ComputePerimeter(): number {
    return 2 * Math.PI * this.radius;
  }

  ComputeArea(): number {
    return Math.PI * this.radius ** 2;
  }

  ToFileString(): string {
    return `${this.typeShape}: P=${this.ComputePerimeter().toFixed(2)}; S=${this.ComputeArea().toFixed(2)}`;
  }

  GetCenter(): IPoint {
    return this.center;
  }

  GetRadius(): number {
    return this.radius;
  }

  SetCenter(point: IPoint) {
    this.center = point;
  }

  GetBoundingBox(): IBoundingBox {
    return {
      minX: this.center.x - this.radius,
      minY: this.center.y - this.radius,
      maxX: this.center.x + this.radius,
      maxY: this.center.y + this.radius,
    };
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
      center: { ...this.center },
      radius: this.radius,
      fillColor: this.fillColor,
      strokeColor: this.strokeColor,
      strokeWidth: this.strokeWidth,
    };
  }

  Restore(mementoShape: IMemento) {
    const mementoCircle = mementoShape as any;
    this.center = { ...mementoCircle.center };
    this.radius = mementoCircle.radius;
    this.fillColor = mementoCircle.fillColor;
    this.strokeColor = mementoCircle.strokeColor;
    this.strokeWidth = mementoCircle.strokeWidth;
  }

  Accept(visitor: IShapeVisitor) {
    visitor.VisitCircle(this);
  }
}
