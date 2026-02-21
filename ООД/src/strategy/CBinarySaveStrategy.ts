import { IShape } from "../shapes/IShape";
import { ISaveStrategy } from "./ISaveStrategy";

export class CBinarySaveStrategy implements ISaveStrategy {
  Save(shapes: IShape[]): ArrayBuffer {
    const json = JSON.stringify(shapes.map((s) => s.Save()));
    const encoder = new TextEncoder();
    return encoder.encode(json).buffer;
  }
}
