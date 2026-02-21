import { IBoundingBox, IShape } from "./IShape";
import { IMemento } from "./IMemento";
import { IShapeVisitor } from "../visitor/IShapeVisitor";

export abstract class CShape implements IShape {
  protected typeShape: string;

  protected constructor(typeShape: string) {
    this.typeShape = typeShape;
  }

  abstract ComputePerimeter(): number;
  abstract ComputeArea(): number;
  abstract ToFileString(): string;
  abstract GetBoundingBox(): IBoundingBox;

  abstract SetFillColor(color: string): void;
  abstract SetStrokeColor(color: string): void;

  abstract GetFillColor(): string;
  abstract GetStrokeColor(): string;

  abstract SetStrokeWidth(width: number): void;
  abstract GetStrokeWidth(): number;

  abstract Save(): IMemento;
  abstract Restore(memento: IMemento): void;

  abstract Accept(visitor: IShapeVisitor): void;
}
