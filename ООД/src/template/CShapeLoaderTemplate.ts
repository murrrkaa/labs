import { IShape } from "../shapes/IShape";

export abstract class CShapeLoaderTemplate {
  Load(data: string | ArrayBuffer): IShape[] {
    const rawShapes = this.ParseData(data);
    return rawShapes.map((s) => this.BuildShape(s));
  }

  protected abstract ParseData(data: string | ArrayBuffer): any[];
  protected abstract BuildShape(raw: any): IShape;
}
