import { UsercentricsLogo, UsercentricsFont, BannerSettings } from ".";

export class FirstLayerOptions {
    layout: UsercentricsLayout;
    bannerSettings?: BannerSettings;
    styleSettings?: FirstLayerStyleSettings;

    constructor(layout: UsercentricsLayout, bannerSettings?: BannerSettings, styleSettings?: FirstLayerStyleSettings) {
        this.layout = layout;
        this.bannerSettings = bannerSettings;
        this.styleSettings = styleSettings;
    }
}

export class FirstLayerStyleSettings {
    headerImage?: HeaderImageSettings;
    title?: TitleSettings;
    message?: MessageSettings;
    buttonLayout?: ButtonLayout;

    constructor(headerImage?: HeaderImageSettings,
        title?: TitleSettings,
        message?: MessageSettings,
        buttonLayout?: ButtonLayout) {
        this.headerImage = headerImage;
        this.title = title;
        this.message = message;
        this.buttonLayout = buttonLayout;
    }
}

export class HeaderImageSettings {
    isExtended: Boolean;
    isHidden: Boolean;
    image?: UsercentricsLogo;
    height?: Number;
    alignment?: SectionAlignment

    private constructor(isExtended: Boolean,
        isHidden: Boolean,
        image?: UsercentricsLogo,
        height?: Number,
        alignment?: SectionAlignment) {
        this.isExtended = isExtended;
        this.isHidden = isHidden;
        this.image = image;
        this.height = height;
        this.alignment = alignment;
    }

    static extended(image: UsercentricsLogo): HeaderImageSettings {
        return new HeaderImageSettings(true, false, image)
    }

    static logo(image: UsercentricsLogo, height?: Number, alignment?: SectionAlignment): HeaderImageSettings {
        return new HeaderImageSettings(false, false, image, height, alignment)
    }

    static hidden(): HeaderImageSettings {
        return new HeaderImageSettings(false, true)
    }
}

export class TitleSettings {
    font?: UsercentricsFont;
    textColorHex?: String;
    textAlignment?: SectionAlignment;

    constructor(font?: UsercentricsFont, textColorHex?: String, textAlignment?: SectionAlignment) {
        this.font = font;
        this.textColorHex = textColorHex;
        this.textAlignment = textAlignment;
    }
}

export class MessageSettings {
    font?: UsercentricsFont;
    textColorHex?: String;
    textAlignment?: SectionAlignment;
    linkTextColorHex?: String;
    linkTextUnderline?: Boolean;

    constructor(font?: UsercentricsFont,
        textColorHex?: String,
        textAlignment?: SectionAlignment,
        linkTextColorHex?: String,
        linkTextUnderline?: Boolean) {
        this.font = font;
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

    static row(buttons: [ButtonSettings]): ButtonLayout {
        return new ButtonLayout([buttons], InternalButtonLayout.row)
    }

    static column(buttons: [ButtonSettings]): ButtonLayout {
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
    font?: UsercentricsFont;
    textColorHex?: String;
    backgroundColorHex?: String;
    cornerRadius?: number;

    constructor(buttonType: ButtonType,
        font?: UsercentricsFont,
        textColorHex?: String,
        backgroundColorHex?: String,
        cornerRadius?: number) {
        this.buttonType = buttonType
        this.font = font
        this.textColorHex = textColorHex
        this.backgroundColorHex = backgroundColorHex
        this.cornerRadius = cornerRadius
    }
}

export enum ButtonType {
    acceptAll = "ACCEPT_ALL",
    denyAll = "DENY_ALL",
    more = "MORE",
    save = "SAVE"
}

export enum SectionAlignment {
    left = "LEFT",
    right = "RIGHT",
    center = "CENTER"
}

export enum UsercentricsLayout {
    full = "FULL",
    sheet = "SHEET",
    popupCenter = "POPUP_CENTER",
    popupBottom = "POPUP_BOTTOM"
}
