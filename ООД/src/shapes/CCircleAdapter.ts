import { CCircle } from "./CCircle";
import { IPoint } from "./IPoint";
import { IShape } from "./IShape";
import { CShapeAdapter } from "./CShapeAdapter";

export class CCircleAdapter extends CShapeAdapter {
  private circle: CCircle;

  constructor(circle: CCircle) {
    super();
    this.circle = circle;
  }

  DrawShape(ctx: CanvasRenderingContext2D, isSelected: boolean) {
    const center = this.circle.GetCenter();
    const radius = this.circle.GetRadius();

    ctx.beginPath();
    ctx.fillStyle = this.circle.GetFillColor();
    ctx.arc(center.x, center.y, radius, 0, Math.PI * 2);
    ctx.fill();
    ctx.strokeStyle = this.circle.GetStrokeColor();
    ctx.lineWidth = this.circle.GetStrokeWidth();
    ctx.stroke();

    if (isSelected) {
      CShapeAdapter.DrawSelectionFrame(ctx, this.circle);
    }
  }

  IsPointInside(point: IPoint) {
    const center = this.circle.GetCenter();
    const radius = this.circle.GetRadius();

    const dx = point.x - center.x;
    const dy = point.y - center.y;
    return dx ** 2 + dy ** 2 <= radius ** 2;
  }

  GetShape(): IShape {
    return this.circle;
  }

  Move(dx: number, dy: number) {
    const center = this.circle.GetCenter();
    this.circle.SetCenter({
      x: center.x + dx,
      y: center.y + dy,
    });
  }
}
