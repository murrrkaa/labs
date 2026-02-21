import { CShape } from "./CShape";
import { IPoint } from "./IPoint";
import { IBoundingBox, ShapeTypeEnum } from "./IShape";
import { ITriangle } from "./ITriangle";
import {
  SHAPE_FILL_COLOR,
  SHAPE_STROKE_COLOR,
  SHAPE_STROKE_WIDTH,
} from "../constants/constants";
import { IMemento } from "./IMemento";
import { IShapeVisitor } from "../visitor/IShapeVisitor";

export class CTriangle extends CShape implements ITriangle {
  private point1: IPoint;
  private point2: IPoint;
  private point3: IPoint;
  private fillColor: string = SHAPE_FILL_COLOR;
  private strokeColor: string = SHAPE_STROKE_COLOR;
  private strokeWidth: number = SHAPE_STROKE_WIDTH;

  constructor(point1: IPoint, point2: IPoint, point3: IPoint) {
    super(ShapeTypeEnum.TRIANGLE);
    this.point1 = point1;
    this.point2 = point2;
    this.point3 = point3;
  }

  ComputePerimeter(): number {
    const distance1 = this.ComputeDistanceBetweenPoints(
      this.point1,
      this.point2,
    );
    const distance2 = this.ComputeDistanceBetweenPoints(
      this.point2,
      this.point3,
    );
    const distance3 = this.ComputeDistanceBetweenPoints(
      this.point3,
      this.point1,
    );

    return distance1 + distance2 + distance3;
  }

  ComputeArea(): number {
    return (
      Math.abs(
        this.point1.x * (this.point2.y - this.point3.y) +
          this.point2.x * (this.point3.y - this.point1.y) +
          this.point3.x * (this.point1.y - this.point2.y),
      ) / 2
    );
  }

  ToFileString(): string {
    return `${this.typeShape}: P=${this.ComputePerimeter().toFixed(2)}; S=${this.ComputeArea().toFixed(2)}`;
  }

  GetPoints(): IPoint[] {
    return [this.point1, this.point2, this.point3];
  }

  GetBoundingBox(): IBoundingBox {
    return {
      minX: Math.min(this.point1.x, this.point2.x, this.point3.x),
      maxX: Math.max(this.point1.x, this.point2.x, this.point3.x),
      minY: Math.min(this.point1.y, this.point2.y, this.point3.y),
      maxY: Math.max(this.point1.y, this.point2.y, this.point3.y),
    };
  }

  SetPoints(updatedPoints: IPoint[]) {
    this.point1 = updatedPoints[0];
    this.point2 = updatedPoints[1];
    this.point3 = updatedPoints[2];
  }

  private ComputeDistanceBetweenPoints(point1: IPoint, point2: IPoint): number {
    return Math.sqrt((point2.x - point1.x) ** 2 + (point2.y - point1.y) ** 2);
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
      point3: { ...this.point3 },
      fillColor: this.fillColor,
      strokeColor: this.strokeColor,
      strokeWidth: this.strokeWidth,
    };
  }

  Restore(mementoShape: IMemento) {
    const mementoTriangle = mementoShape as any;
    this.point1 = { ...mementoTriangle.point1 };
    this.point2 = { ...mementoTriangle.point2 };
    this.point3 = { ...mementoTriangle.point3 };
    this.fillColor = mementoTriangle.fillColor;
    this.strokeColor = mementoTriangle.strokeColor;
    this.strokeWidth = mementoTriangle.strokeWidth;
  }

  Accept(visitor: IShapeVisitor) {
    visitor.VisitTriangle(this);
  }
}
