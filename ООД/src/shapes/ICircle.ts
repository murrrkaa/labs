import { IShape } from "./IShape";
import { IPoint } from "./IPoint";

export interface ICircle extends IShape {
  GetCenter(): IPoint;
  GetRadius(): number;
  SetCenter(point: IPoint): void;
}
