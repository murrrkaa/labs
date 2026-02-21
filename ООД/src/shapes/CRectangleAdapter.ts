import { CRectangle } from "./CRectangle";
import { IPoint } from "./IPoint";
import { IShape } from "./IShape";
import { CShapeAdapter } from "./CShapeAdapter";

export class CRectangleAdapter extends CShapeAdapter {
  private rectangle: CRectangle;

  constructor(rectangle: CRectangle) {
    super();
    this.rectangle = rectangle;
  }

  DrawShape(ctx: CanvasRenderingContext2D, isSelected: boolean) {
    const height = this.rectangle.GetHeight();
    const width = this.rectangle.GetWidth();
    const [point1, point2] = this.rectangle.GetPoints();
    ctx.beginPath();
    ctx.fillStyle = this.rectangle.GetFillColor();
    ctx.rect(point1.x, point1.y, width, height);
    ctx.closePath();
    ctx.fill();
    ctx.strokeStyle = this.rectangle.GetStrokeColor();
    ctx.lineWidth = this.rectangle.GetStrokeWidth();
    ctx.stroke();

    if (isSelected) {
      CShapeAdapter.DrawSelectionFrame(ctx, this.rectangle);
    }
  }

  IsPointInside(point: IPoint): boolean {
    const [p1, p2] = this.rectangle.GetPoints();
    const rectX = Math.min(p1.x, p2.x);
    const rectY = Math.min(p1.y, p2.y);
    const width = this.rectangle.GetWidth();
    const height = this.rectangle.GetHeight();

    return (
      point.x >= rectX &&
      point.x <= rectX + width &&
      point.y >= rectY &&
      point.y <= rectY + height
    );
  }

  GetShape(): IShape {
    return this.rectangle;
  }

  Move(dx: number, dy: number) {
    const points = this.rectangle.GetPoints();
    const updatedPoints: IPoint[] = points.map((point) => ({
      x: point.x + dx,
      y: point.y + dy,
    }));
    this.rectangle.SetPoints(updatedPoints);
  }
}
