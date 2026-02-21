import { CCircle } from "../shapes/CCircle";
import { CRectangle } from "../shapes/CRectangle";
import { CTriangle } from "../shapes/CTriangle";

export interface IShapeVisitor {
  VisitCircle(circle: CCircle): void;
  VisitRectangle(rect: CRectangle): void;
  VisitTriangle(triangle: CTriangle): void;
}
