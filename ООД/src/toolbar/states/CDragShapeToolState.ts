import { CApplication } from "../../app/CApplication";
import { IToolbarState } from "./IToolbarState";
import { CMoveShapeState } from "../../canvas/states/CMoveShapeState";

export class CDragShapeToolState implements IToolbarState {
  constructor(private app: CApplication) {}

  Select(): void {
    this.app.State = new CMoveShapeState(this.app);
  }
}
