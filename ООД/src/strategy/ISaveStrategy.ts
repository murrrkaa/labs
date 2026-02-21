import { IShape } from "../shapes/IShape";

export interface ISaveStrategy {
  Save(shapes: IShape[]): ArrayBuffer | string;
}
