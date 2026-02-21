import { IShape } from "./IShape";
import { IPoint } from "./IPoint";

export interface IRectangle extends IShape {
  GetPoints(): IPoint[];
  GetWidth(): number;
  GetHeight(): number;
  SetPoints(points: IPoint[]): void;
}
