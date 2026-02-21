import { CApplication } from "../../app/CApplication";
import { IToolbarState } from "./IToolbarState";
import { CAddShapeState } from "../../canvas/states/CAddShapeState";

export class CAddShapeToolState implements IToolbarState {
  constructor(private app: CApplication) {}

  Select(): void {
    this.app.State = new CAddShapeState(this.app);
  }
}
