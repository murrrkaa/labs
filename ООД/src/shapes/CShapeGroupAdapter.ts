import { IShapeAdapter } from "./IShapeAdapter";
import { CShapeGroup } from "./CShapeGroup";
import { IPoint } from "./IPoint";
import { IShape } from "./IShape";
import { CShapeAdapter } from "./CShapeAdapter";

export class CShapeGroupAdapter implements IShapeAdapter {
  private group: CShapeGroup;
  private groupAdapters: IShapeAdapter[];

  constructor(group: CShapeGroup, groupAdapters: IShapeAdapter[]) {
    this.group = group;
    this.groupAdapters = groupAdapters;
  }

  DrawShape(ctx: CanvasRenderingContext2D, isSelected: boolean) {
    this.groupAdapters.forEach((adapter) => adapter.DrawShape(ctx, false));
    if (isSelected) {
      CShapeAdapter.DrawSelectionFrame(ctx, this.group);
    }
  }

  IsPointInside(point: IPoint) {
    return this.groupAdapters.some((a) => a.IsPointInside(point));
  }

  GetShape(): IShape {
    return this.group;
  }

  GetShapeAdapters(): IShapeAdapter[] {
    return this.groupAdapters;
  }

  Move(dx: number, dy: number) {
    this.groupAdapters.forEach((adapter) => adapter.Move(dx, dy));
  }
}
