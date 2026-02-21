import { CShapeLoaderTemplate } from "./CShapeLoaderTemplate";
import { CShapeBuilder } from "./CShapeBuilder";
import { IShape } from "../shapes/IShape";

export class CTextShapeLoader extends CShapeLoaderTemplate {
  private builder = new CShapeBuilder();

  protected ParseData(data: string): any[] {
    return data.split("\n").map((line) => JSON.parse(line));
  }

  protected BuildShape(raw: any): IShape {
    return this.builder.Build(raw);
  }
}
