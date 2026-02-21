import { IPoint } from "./IPoint";

export interface ICircleMemento {
  center: IPoint;
  radius: number;
  fillColor: string;
  strokeColor: string;
  strokeWidth: number;
}

export interface IRectangleMemento {
  point1: IPoint;
  point2: IPoint;
  fillColor: string;
  strokeColor: string;
  strokeWidth: number;
}

export interface ITriangleMemento {
  point1: IPoint;
  point2: IPoint;
  point3: IPoint;
  fillColor: string;
  strokeColor: string;
  strokeWidth: number;
}

export interface IShapeGroupMemento {
  shapes: IMemento[];
}

export type IMemento =
  | ICircleMemento
  | IRectangleMemento
  | ITriangleMemento
  | IShapeGroupMemento;
