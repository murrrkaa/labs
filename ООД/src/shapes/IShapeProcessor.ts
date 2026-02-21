import { IShape } from "./IShape";

export interface IShapeProcessor {
  ReadShapesFromFile(filename: string): void;
  WriteInfoShapesToFile(filename: string): void;
  GetShapes(): IShape[];
}
