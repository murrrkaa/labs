import { IMemento } from "./IMemento";
import { IShapeVisitor } from "../visitor/IShapeVisitor";

export enum ShapeTypeEnum {
  TRIANGLE = "TRIANGLE",
  RECTANGLE = "RECTANGLE",
  CIRCLE = "CIRCLE",
}

export type ShapeTypeKeys = keyof typeof ShapeTypeEnum;

export interface IBoundingBox {
  minX: number;
  maxX: number;
  minY: number;
  maxY: number;
}

export interface IShape {
  ComputePerimeter(): number;
  ComputeArea(): number;
  ToFileString(): string;

  GetBoundingBox(): IBoundingBox;

  SetFillColor(color: string): void;
  SetStrokeColor(color: string): void;
  SetStrokeWidth(width: number): void;

  Save(): IMemento;
  Restore(memento: IMemento): void;

  Accept(visitor: IShapeVisitor): void;
}
