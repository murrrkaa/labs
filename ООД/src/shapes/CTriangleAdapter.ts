import { CTriangle } from "./CTriangle";
import { IPoint } from "./IPoint";
import { IShape } from "./IShape";
import { CShapeAdapter } from "./CShapeAdapter";

export class CTriangleAdapter extends CShapeAdapter {
  private triangle: CTriangle;

  constructor(triangle: CTriangle) {
    super();
    this.triangle = triangle;
  }

  DrawShape(ctx: CanvasRenderingContext2D, isSelected: boolean) {
    const [point1, point2, point3] = this.triangle.GetPoints();

    ctx.beginPath();
    ctx.fillStyle = this.triangle.GetFillColor();
    ctx.moveTo(point1.x, point1.y);
    ctx.lineTo(point2.x, point2.y);
    ctx.lineTo(point3.x, point3.y);
    ctx.closePath();
    ctx.fill();
    ctx.strokeStyle = this.triangle.GetStrokeColor();
    ctx.lineWidth = this.triangle.GetStrokeWidth();
    ctx.stroke();

    if (isSelected) {
      CShapeAdapter.DrawSelectionFrame(ctx, this.triangle);
    }
  }

  IsPointInside(point: IPoint): boolean {
    const [vertex1, vertex2, vertex3] = this.triangle.GetPoints();

    const area1 = this.ComputeAreaWithPoint(point, vertex1, vertex2);
    const area2 = this.ComputeAreaWithPoint(point, vertex2, vertex3);
    const area3 = this.ComputeAreaWithPoint(point, vertex3, vertex1);

    return area1 + area2 + area3 <= this.triangle.ComputeArea();
  }

  private ComputeAreaWithPoint(
    cursorPoint: IPoint,
    vertex1: IPoint,
    vertex2: IPoint,
  ) {
    return (
      Math.abs(
        (vertex1.x - cursorPoint.x) * (vertex2.y - cursorPoint.y) -
          (vertex2.x - cursorPoint.x) * (vertex1.y - cursorPoint.y),
      ) / 2
    );
  }

  GetShape(): IShape {
    return this.triangle;
  }

  Move(dx: number, dy: number) {
    const points = this.triangle.GetPoints();
    const updatedPoints = points.map((point) => ({
      x: point.x + dx,
      y: point.y + dy,
    }));
    this.triangle.SetPoints(updatedPoints);
  }
}
