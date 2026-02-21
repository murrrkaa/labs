import { IShapeAdapter } from "./IShapeAdapter";
import { IShape } from "./IShape";
import {
  FRAME_COLOR,
  FRAME_LINE_DASH_LENGTH,
  FRAME_LINE_DASH_SPACE,
  FRAME_LINE_WIDTH,
  FRAME_PADDING,
  FRAME_PADDING_HALF,
  MARKER_FILL,
  MARKER_HALF,
  MARKER_SIZE,
  MARKER_STROKE_STYLE,
  MARKER_WIDTH,
} from "../constants/constants";
import { IPoint } from "./IPoint";

export abstract class CShapeAdapter implements IShapeAdapter {
  static DrawSelectionFrame(ctx: CanvasRenderingContext2D, shape: IShape) {
    const { minX, minY, maxX, maxY } = shape.GetBoundingBox();

    const w = maxX - minX;
    const h = maxY - minY;

    ctx.save();
    ctx.setLineDash([FRAME_LINE_DASH_LENGTH, FRAME_LINE_DASH_SPACE]);
    ctx.strokeStyle = FRAME_COLOR;
    ctx.lineWidth = FRAME_LINE_WIDTH;
    ctx.strokeRect(
      minX - FRAME_PADDING_HALF,
      minY - FRAME_PADDING_HALF,
      w + FRAME_PADDING,
      h + FRAME_PADDING,
    );
    ctx.restore();

    const markers = [
      [minX - FRAME_PADDING_HALF, minY - FRAME_PADDING_HALF],
      [minX + w + FRAME_PADDING_HALF, minY - FRAME_PADDING_HALF],
      [minX - FRAME_PADDING_HALF, minY + h + FRAME_PADDING_HALF],
      [minX + w + FRAME_PADDING_HALF, minY + h + FRAME_PADDING_HALF],
    ];

    ctx.fillStyle = MARKER_FILL;
    ctx.strokeStyle = MARKER_STROKE_STYLE;
    ctx.lineWidth = MARKER_WIDTH;

    for (let [mx, my] of markers) {
      ctx.beginPath();
      ctx.rect(mx - MARKER_HALF, my - MARKER_HALF, MARKER_SIZE, MARKER_SIZE);
      ctx.fill();
      ctx.stroke();
    }
  }

  abstract DrawShape(ctx: CanvasRenderingContext2D, isSelected: boolean): void;
  abstract IsPointInside(point: IPoint): boolean;

  abstract GetShape(): IShape;
  abstract Move(dx: number, dy: number): void;
}
