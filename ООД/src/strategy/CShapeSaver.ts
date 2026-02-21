import { IShape } from "../shapes/IShape";
import { ISaveStrategy } from "./ISaveStrategy";

export class ShapeSaver {
  constructor(private strategy: ISaveStrategy) {}

  SaveShapes(shapes: IShape[], filename: string) {
    const fileContent = this.strategy.Save(shapes);
    let blob: Blob;

    if (fileContent instanceof ArrayBuffer) {
      blob = new Blob([fileContent], { type: "application/octet-stream" });
    } else {
      blob = new Blob([fileContent], { type: "text/plain" });
    }

    const link = document.createElement("a");
    link.href = URL.createObjectURL(blob);
    link.download = filename;
    link.click();
    URL.revokeObjectURL(link.href);
  }
}
