import { IShapeVisitor } from "./IShapeVisitor";
import { CCircle } from "../shapes/CCircle";
import { CRectangle } from "../shapes/CRectangle";
import { CTriangle } from "../shapes/CTriangle";

export class CShapeStyleVisitor implements IShapeVisitor {
  constructor(
    private fillColor: string,
    private strokeColor: string,
    private strokeWidth: number,
  ) {}

  VisitCircle(circle: CCircle) {
    circle.SetFillColor(this.fillColor);
    circle.SetStrokeColor(this.strokeColor);
    circle.SetStrokeWidth(this.strokeWidth);
  }

  VisitRectangle(rect: CRectangle) {
    rect.SetFillColor(this.fillColor);
    rect.SetStrokeColor(this.strokeColor);
    rect.SetStrokeWidth(this.strokeWidth);
  }

  VisitTriangle(triangle: CTriangle) {
    triangle.SetFillColor(this.fillColor);
    triangle.SetStrokeColor(this.strokeColor);
    triangle.SetStrokeWidth(this.strokeWidth);
  }
}
