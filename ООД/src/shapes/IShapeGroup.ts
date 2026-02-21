import { IShape } from "./IShape";

export interface IShapeGroup extends IShape {
  GetShapes(): IShape[];
}
