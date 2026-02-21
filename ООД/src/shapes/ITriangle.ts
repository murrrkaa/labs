import { IShape } from "./IShape";
import { IPoint } from "./IPoint";

export interface ITriangle extends IShape {
  GetPoints(): IPoint[];
  SetPoints(points: IPoint[]): void;
}
