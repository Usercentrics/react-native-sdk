import { BannerLogo } from ".";


export class FirstLayerStyleSettings {
    layout?: UsercentricsLayout;
    headerImage?: HeaderImageSettings;
    title?: TitleSettings;
    message?: MessageSettings;
    buttonLayout?: ButtonLayout;
    backgroundColorHex?: String;
    cornerRadius?: Number;
    overlayColorHex?: String;

    constructor(layout?: UsercentricsLayout,
        headerImage?: HeaderImageSettings,
        title?: TitleSettings,
        message?: MessageSettings,
        buttonLayout?: ButtonLayout,
        backgroundColorHex?: String,
        cornerRadius?: Number,
        overlayColorHex?: String
    ) {
        this.layout = layout
        this.headerImage = headerImage;
        this.title = title;
        this.message = message;
        this.buttonLayout = buttonLayout;
        this.backgroundColorHex = backgroundColorHex;
        this.cornerRadius = cornerRadius;
        this.overlayColorHex = overlayColorHex;
    }
}

export class HeaderImageSettings {
    isExtended: Boolean;
    isHidden: Boolean;
    image?: BannerLogo;
    height?: Number;
    alignment?: SectionAlignment

    private constructor(isExtended: Boolean,
        isHidden: Boolean,
        image?: BannerLogo,
        height?: Number,
        alignment?: SectionAlignment) {
        this.isExtended = isExtended;
        this.isHidden = isHidden;
        this.image = image;
        this.height = height;
        this.alignment = alignment;
    }

    static extended(image: BannerLogo): HeaderImageSettings {
        return new HeaderImageSettings(true, false, image)
    }

    static logo(image: BannerLogo, height?: Number, alignment?: SectionAlignment): HeaderImageSettings {
        return new HeaderImageSettings(false, false, image, height, alignment)
    }

    static hidden(): HeaderImageSettings {
        return new HeaderImageSettings(false, true)
    }
}

export class TitleSettings {
    fontName?: string;
    textSize?: number;
    textColorHex?: String;
    textAlignment?: SectionAlignment;

    constructor(fontName?: string, textSize?: number, textColorHex?: String, textAlignment?: SectionAlignment) {
        this.fontName = fontName;
        this.textSize = textSize;
        this.textColorHex = textColorHex;
        this.textAlignment = textAlignment;
    }
}

export class MessageSettings {
    fontName?: string;
    textSize?: number;
    textColorHex?: String;
    textAlignment?: SectionAlignment;
    linkTextColorHex?: String;
    linkTextUnderline?: Boolean;

    constructor(fontName?: string,
        textSize?: number,
        textColorHex?: String,
        textAlignment?: SectionAlignment,
        linkTextColorHex?: String,
        linkTextUnderline?: Boolean) {
        this.fontName = fontName;
        this.textSize = textSize;
        this.textColorHex = textColorHex;
        this.textAlignment = textAlignment;
        this.linkTextColorHex = linkTextColorHex;
        this.linkTextUnderline = linkTextUnderline;
    }
}

export class ButtonLayout {
    buttons: ButtonSettings[][]
    layout: InternalButtonLayout

    private constructor(buttons: ButtonSettings[][], layout: InternalButtonLayout) {
        this.buttons = buttons;
        this.layout = layout;
    }

    static row(buttons: ButtonSettings[]): ButtonLayout {
        return new ButtonLayout([buttons], InternalButtonLayout.row)
    }

    static column(buttons: ButtonSettings[]): ButtonLayout {
        return new ButtonLayout([buttons], InternalButtonLayout.column)
    }

    static grid(buttons: ButtonSettings[][]): ButtonLayout {
        return new ButtonLayout(buttons, InternalButtonLayout.grid)
    }
}

enum InternalButtonLayout {
    row = "ROW",
    grid = "GRID",
    column = "COLUMN"
}

export class ButtonSettings {
    buttonType: ButtonType;
    fontName?: string;
    textSize?: number;
    textColorHex?: String;
    backgroundColorHex?: String;
    cornerRadius?: number;

    // Affects only Android
    isAllCaps?: Boolean

    constructor(buttonType: ButtonType,
        fontName?: string,
        textSize?: number,
        textColorHex?: String,
        backgroundColorHex?: String,
        cornerRadius?: number,
        isAllCaps?: Boolean) {
        this.buttonType = buttonType
        this.fontName = fontName
        this.textSize = textSize
        this.textColorHex = textColorHex
        this.backgroundColorHex = backgroundColorHex
        this.cornerRadius = cornerRadius
        this.isAllCaps = isAllCaps
    }
}

export enum ButtonType {
    acceptAll = "ACCEPT_ALL",
    denyAll = "DENY_ALL",
    more = "MORE",
    save = "SAVE"
}

export enum SectionAlignment {
    left = "START",
    right = "END",
    center = "CENTER"
}

export enum UsercentricsLayout {
    full = "FULL",
    sheet = "SHEET",
    popupCenter = "POPUP_CENTER",
    popupBottom = "POPUP_BOTTOM"
}
