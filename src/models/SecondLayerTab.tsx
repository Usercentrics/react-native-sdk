/**
 * A tab of the second layer that can be opened directly.
 *
 * - `services`: the Services tab of GDPR and CCPA layouts.
 * - `partners`: the Vendors tab of TCF layouts.
 *
 * A tab the current layout does not have, or no tab at all, opens the default tab.
 */
export enum SecondLayerTab {

    services = "SERVICES",
    partners = "PARTNERS"
}
