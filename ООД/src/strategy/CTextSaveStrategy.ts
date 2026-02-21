import { ISaveStrategy } from "./ISaveStrategy";
import { IShape } from "../shapes/IShape";

export class CTextSaveStrategy implements ISaveStrategy {
  Save(shapes: IShape[]): string {
    return shapes.map((shape) => JSON.stringify(shape.Save())).join("\n");
  }
}
