export enum PurposeListStyle {
    boxed = "BOXED",
    flat = "FLAT"
}

/**
 * @deprecated BannerInitCustomization is deprecated and will be removed in a future release.
 * Configure banner appearance via the Usercentrics dashboard instead.
 */
export class BannerInitCustomization {

    paddingTop?: number;
    paddingBottom?: number;
    paddingStart?: number;
    paddingEnd?: number;
    lineSpacingMultiplier?: number;
    titleFontSize?: number;
    bodyFontSize?: number;
    linkFontSize?: number;
    titleFontBold?: boolean;
    headerPaddingTop?: number;
    headerPaddingSides?: number;
    headerPaddingBetweenElements?: number;
    buttonBorderColor?: string;
    buttonBorderWidth?: number;
    purposeListStyle?: PurposeListStyle;
    stickyHeader?: boolean;
    hideLanguageSwitcher?: boolean;
    buttonHeightDp?: number;
    buttonHorizontalPaddingDp?: number;
    buttonSpacingDp?: number;
    linkUnderline?: boolean;
    showSecondLayerCloseButton?: boolean;
    tabFontSize?: number;
    tabActiveColor?: string;
    denyAllButtonBackground?: string;
    acceptAllButtonBackground?: string;
    linkColor?: string;

    constructor({
                    paddingTop = undefined,
                    paddingBottom = undefined,
                    paddingStart = undefined,
                    paddingEnd = undefined,
                    lineSpacingMultiplier = undefined,
                    titleFontSize = undefined,
                    bodyFontSize = undefined,
                    linkFontSize = undefined,
                    titleFontBold = undefined,
                    headerPaddingTop = undefined,
                    headerPaddingSides = undefined,
                    headerPaddingBetweenElements = undefined,
                    buttonBorderColor = undefined,
                    buttonBorderWidth = undefined,
                    purposeListStyle = undefined,
                    stickyHeader = undefined,
                    hideLanguageSwitcher = undefined,
                    buttonHeightDp = undefined,
                    buttonHorizontalPaddingDp = undefined,
                    buttonSpacingDp = undefined,
                    linkUnderline = undefined,
                    showSecondLayerCloseButton = undefined,
                    tabFontSize = undefined,
                    tabActiveColor = undefined,
                    denyAllButtonBackground = undefined,
                    acceptAllButtonBackground = undefined,
                    linkColor = undefined
                }: {
        paddingTop?: number,
        paddingBottom?: number,
        paddingStart?: number,
        paddingEnd?: number,
        lineSpacingMultiplier?: number,
        titleFontSize?: number,
        bodyFontSize?: number,
        linkFontSize?: number,
        titleFontBold?: boolean,
        headerPaddingTop?: number,
        headerPaddingSides?: number,
        headerPaddingBetweenElements?: number,
        buttonBorderColor?: string,
        buttonBorderWidth?: number,
        purposeListStyle?: PurposeListStyle,
        stickyHeader?: boolean,
        hideLanguageSwitcher?: boolean,
        buttonHeightDp?: number,
        buttonHorizontalPaddingDp?: number,
        buttonSpacingDp?: number,
        linkUnderline?: boolean,
        showSecondLayerCloseButton?: boolean,
        tabFontSize?: number,
        tabActiveColor?: string,
        denyAllButtonBackground?: string,
        acceptAllButtonBackground?: string,
        linkColor?: string
    } = {}) {
        this.paddingTop = paddingTop;
        this.paddingBottom = paddingBottom;
        this.paddingStart = paddingStart;
        this.paddingEnd = paddingEnd;
        this.lineSpacingMultiplier = lineSpacingMultiplier;
        this.titleFontSize = titleFontSize;
        this.bodyFontSize = bodyFontSize;
        this.linkFontSize = linkFontSize;
        this.titleFontBold = titleFontBold;
        this.headerPaddingTop = headerPaddingTop;
        this.headerPaddingSides = headerPaddingSides;
        this.headerPaddingBetweenElements = headerPaddingBetweenElements;
        this.buttonBorderColor = buttonBorderColor;
        this.buttonBorderWidth = buttonBorderWidth;
        this.purposeListStyle = purposeListStyle;
        this.stickyHeader = stickyHeader;
        this.hideLanguageSwitcher = hideLanguageSwitcher;
        this.buttonHeightDp = buttonHeightDp;
        this.buttonHorizontalPaddingDp = buttonHorizontalPaddingDp;
        this.buttonSpacingDp = buttonSpacingDp;
        this.linkUnderline = linkUnderline;
        this.showSecondLayerCloseButton = showSecondLayerCloseButton;
        this.tabFontSize = tabFontSize;
        this.tabActiveColor = tabActiveColor;
        this.denyAllButtonBackground = denyAllButtonBackground;
        this.acceptAllButtonBackground = acceptAllButtonBackground;
        this.linkColor = linkColor;
    }
}
