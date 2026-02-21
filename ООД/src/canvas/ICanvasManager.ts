import { IShape } from "../shapes/IShape";

export interface ICanvasManager {
  DrawShapes(shapes: IShape[]): void;
}
