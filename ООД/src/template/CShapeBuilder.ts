import { CCircle } from "../shapes/CCircle";
import { CRectangle } from "../shapes/CRectangle";
import { CTriangle } from "../shapes/CTriangle";
import { IShape } from "../shapes/IShape";
import { CShapeGroup } from "../shapes/CShapeGroup";

export class CShapeBuilder {
  private shape!: IShape;

  Build(raw: any): IShape {
    if (raw.center) return this.BuildCircle(raw);
    if (raw.point3) return this.BuildTriangle(raw);
    if (raw.point2) return this.BuildRectangle(raw);
    if (raw.shapes) return this.BuildGroupShapes(raw);

    throw new Error("Неизвестный тип фигуры");
  }

  private BuildGroupShapes(data: any) {
    const shapes = data.shapes.map((item: any, index: number) => {
      return this.Build(item);
    });
    this.shape = new CShapeGroup(shapes);
    return this.shape;
  }

  private BuildCircle(data: any) {
    this.shape = new CCircle(data.center, data.radius);
    return this.SetStyle(this.shape, data);
  }

  private BuildRectangle(data: any) {
    this.shape = new CRectangle(data.point1, data.point2);
    return this.SetStyle(this.shape, data);
  }

  private BuildTriangle(data: any) {
    this.shape = new CTriangle(data.point1, data.point2, data.point3);
    return this.SetStyle(this.shape, data);
  }

  private SetStyle(shape: IShape, data: any) {
    shape.SetFillColor(data.fillColor);
    shape.SetStrokeColor(data.strokeColor);
    shape.SetStrokeWidth(data.strokeWidth);
    return shape;
  }
}
