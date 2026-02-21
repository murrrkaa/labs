import { CShapeLoaderTemplate } from "./CShapeLoaderTemplate";
import { CShapeBuilder } from "./CShapeBuilder";
import { IShape } from "../shapes/IShape";

export class CBinaryShapeLoader extends CShapeLoaderTemplate {
  private builder = new CShapeBuilder();

  protected ParseData(data: ArrayBuffer): any[] {
    const decoder = new TextDecoder();
    const json = decoder.decode(data);
    return JSON.parse(json);
  }

  protected BuildShape(raw: any): IShape {
    return this.builder.Build(raw);
  }
}
