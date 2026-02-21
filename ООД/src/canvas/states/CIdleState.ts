import { IAppState } from "./IAppState";
import { CApplication } from "../../app/CApplication";

export class CIdleState implements IAppState {
  constructor(private app: CApplication) {}

  onMouseDownHandler(): void {}
  onMouseMoveHandler(): void {}
  onMouseUpHandler(): void {}
}
