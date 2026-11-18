import {NativeModules} from 'react-native';
import {
    BannerInitCustomization,
    BannerSettings,
    NetworkMode,
    PurposeListStyle,
    SecondLayerTab,
    TCFData,
    TCFDecisionUILayer,
    UsercentricsAgeBand,
    UsercentricsAgeSignalDecision,
    UsercentricsAgeSignalSource,
    UsercentricsAgeSignalTrust,
    UsercentricsAgeSignalUnavailableReason,
    UsercentricsConsentType,
    UsercentricsConsentUserResponse,
    UsercentricsLayout,
    UsercentricsLoggerLevel,
    UsercentricsOptions,
    UsercentricsPublisherAgeSignal,
    UsercentricsReadyStatus,
    UsercentricsUserInteraction
} from '../models';
import {Usercentrics} from '../Usercentrics';
import {
    adTechProviderDecisionExample,
    ccpaDataExample,
    cmpDataExample,
    featuresExample,
    gppDataExample,
    purposesExample,
    tcfUserDecisionOnPurposeExample,
    tcfUserDecisionOnSpecialFeatureExample,
    tcfUserDecisionOnVendorExample,
    usercentricsServiceConsent,
    userDecision
} from './mocks';
import {UsercentricsAnalyticsEventType} from "../models/UsercentricsAnalyticsEventType";
import {AdditionalConsentModeData} from "../models/AdditionalConsentModeData";

const {RNUsercentricsModule} = NativeModules;

jest.mock("react-native", () => {
    const RN = jest.requireActual("react-native");

    RN.NativeModules.RNUsercentricsModule = {
        configure: jest.fn(),
        isReady: jest.fn(),
        showCMP: jest.fn(),
        showFirstLayer: jest.fn(),
        showSecondLayer: jest.fn(),
        restoreUserSession: jest.fn(),
        getControllerId: jest.fn(),
        getABTestingVariant: jest.fn(),
        getConsents: jest.fn(),
        getCMPData: jest.fn(),
        getUserSessionData: jest.fn(),
        getUSPData: jest.fn(),
        getGPPData: jest.fn(),
        getGPPString: jest.fn(),
        getTCFData: jest.fn(),
        getAdditionalConsentModeData: jest.fn(),
        changeLanguage: jest.fn(),
        acceptAll: jest.fn(),
        acceptAllForTCF: jest.fn(),
        denyAll: jest.fn(),
        denyAllForTCF: jest.fn(),
        saveOptOutForCCPA: jest.fn(),
        saveDecisionsForTCF: jest.fn(),
        saveDecisions: jest.fn(),
        setGPPConsent: jest.fn(),
        track: jest.fn(),
        reset: jest.fn(),
        getDpsMetadata: jest.fn(),
        clearUserSession: jest.fn(),
        notifySubscriptionLapsed: jest.fn(),
        setAgeSignal: jest.fn(),
        addListener: jest.fn(),
        removeListeners: jest.fn()
    };

    return RN
})

describe('Test Usercentrics Module', () => {
    test('testConfigureBridge', () => {
        const options = new UsercentricsOptions({
            settingsId: "abc",
            ruleSetId: "qwer",
            defaultLanguage: "en",
            loggerLevel: UsercentricsLoggerLevel.debug,
            timeoutMillis: 123,
            version: "1.2.3",
            networkMode: NetworkMode.eu,
            initTimeoutMillis: 1000
        });
        Usercentrics.configure(options);
        const call = RNUsercentricsModule.configure.mock.calls[0][0];
        expect(call).toBe(options)
    })

    test('testConfigureBridgeWithControllerId', () => {
        const controllerId = "a".repeat(64);
        const options = new UsercentricsOptions({
            settingsId: "abc",
            ruleSetId: "qwer",
            controllerId
        });

        Usercentrics.configure(options);
        const calls = RNUsercentricsModule.configure.mock.calls;
        const call = calls[calls.length - 1][0];
        expect(call).toBe(options);
        expect(call.controllerId).toBe(controllerId);
    })

    test('testConfigureBridgeWithBannerCustomization', () => {
        const bannerCustomization = new BannerInitCustomization({
            paddingTop: 16,
            paddingBottom: 16,
            paddingStart: 8,
            paddingEnd: 8,
            lineSpacingMultiplier: 1.2,
            titleFontSize: 18,
            bodyFontSize: 14,
            linkFontSize: 14,
            titleFontBold: true,
            headerPaddingTop: 12,
            headerPaddingSides: 12,
            headerPaddingBetweenElements: 4,
            buttonBorderColor: "#004dcf",
            buttonBorderWidth: 1,
            purposeListStyle: PurposeListStyle.flat,
            stickyHeader: true,
            hideLanguageSwitcher: false,
            buttonHeightDp: 48,
            buttonHorizontalPaddingDp: 16,
            buttonSpacingDp: 8,
            linkUnderline: true,
            showSecondLayerCloseButton: true,
            tabFontSize: 14,
            tabActiveColor: "#004dcf",
            denyAllButtonBackground: "#ffffff",
            acceptAllButtonBackground: "#004dcf",
            linkColor: "#004dcf"
        });

        const options = new UsercentricsOptions({
            settingsId: "abc",
            ruleSetId: "qwer",
            bannerCustomization
        });

        Usercentrics.configure(options);
        const calls = RNUsercentricsModule.configure.mock.calls;
        const call = calls[calls.length - 1][0];
        expect(call).toBe(options);
        expect(call.bannerCustomization).toBe(bannerCustomization);
    })

    test('testStatus', async () => {
        const readyStatus = new UsercentricsReadyStatus(
            true,
            [
                {
                    templateId: "123",
                    status: false,
                    dataProcessor: "facebook",
                    version: "123",
                    type: 0,
                    isEssential: false,
                    history: [{
                        status: false,
                        timestampInMillis: 123.0,
                        type: 0
                    }],
                    category: "essemtial",
                    isExempt: false,
                }
            ],
          {
              countryCode: "PT",
              regionCode: "PT11",
              isInEU: true,
              isInUS: false,
              isInCalifornia: false
          },
          {
              activeSettingsId: "",
              bannerRequiredAtLocation: false
          }
        )

        RNUsercentricsModule.isReady.mockImplementationOnce(
            (): Promise<any> => Promise.resolve(readyStatus)
        )

        const data = await Usercentrics.status();
        expect(data).toBe(readyStatus);
    })

    test('testStatusWithError', async () => {
        RNUsercentricsModule.isReady.mockImplementationOnce(
            (): Promise<any> => Promise.reject("Failed")
        )

        try {
            await Usercentrics.status();
        } catch (e) {
            expect(e).toBe("Failed");
        }
    })

    test('testShowFirstLayer', async () => {
        const response = new UsercentricsConsentUserResponse(
            "abc",
            UsercentricsUserInteraction.acceptAll,
            [
                {
                    templateId: "123",
                    status: false,
                    dataProcessor: "facebook",
                    version: "123",
                    type: 0,
                    isEssential: false,
                    history: [{
                        status: false,
                        timestampInMillis: 123.0,
                        type: 0
                    }],
                    category: "essemtial",
                    isExempt: false,
                }
            ]
        )

        RNUsercentricsModule.showFirstLayer.mockImplementationOnce(
            (): Promise<any> => Promise.resolve(response)
        )

        const bannerSettings: BannerSettings = {
            firstLayerStyleSettings: {
                layout: UsercentricsLayout.popupBottom
            }
        }

        const data = await Usercentrics.showFirstLayer(bannerSettings)
        expect(data).toBe(response);

        const call = RNUsercentricsModule.showFirstLayer.mock.calls[0][0];
        expect(call).toBe(bannerSettings)
    })

    test('testShowFirstLayerWithInitCustomization', async () => {
        const response = new UsercentricsConsentUserResponse(
            "abc",
            UsercentricsUserInteraction.acceptAll,
            []
        )

        RNUsercentricsModule.showFirstLayer.mockImplementationOnce(
            (): Promise<any> => Promise.resolve(response)
        )

        const initCustomization = new BannerInitCustomization({
            paddingTop: 16,
            buttonBorderColor: "#004dcf",
            purposeListStyle: PurposeListStyle.flat
        });

        const bannerSettings: BannerSettings = {
            initCustomization
        }

        const data = await Usercentrics.showFirstLayer(bannerSettings)
        expect(data).toBe(response);

        const calls = RNUsercentricsModule.showFirstLayer.mock.calls;
        const call = calls[calls.length - 1][0];
        expect(call).toBe(bannerSettings);
        expect(call.initCustomization).toBe(initCustomization);
    })

    test('testShowSecondLayerWithoutTabPassesOptionsUnchanged', async () => {
        const response = new UsercentricsConsentUserResponse(
            "abc",
            UsercentricsUserInteraction.acceptAll,
            []
        )

        RNUsercentricsModule.showSecondLayer.mockImplementationOnce(
            (): Promise<any> => Promise.resolve(response)
        )

        const bannerSettings: BannerSettings = {
            secondLayerStyleSettings: {
                showCloseButton: true
            }
        }

        const data = await Usercentrics.showSecondLayer(bannerSettings)
        expect(data).toBe(response);

        const calls = RNUsercentricsModule.showSecondLayer.mock.calls;
        const call = calls[calls.length - 1][0];
        expect(call).toBe(bannerSettings);
        expect(call.tab).toBeUndefined();
    })

    test('testShowSecondLayerWithTab', async () => {
        const response = new UsercentricsConsentUserResponse(
            "abc",
            UsercentricsUserInteraction.acceptAll,
            []
        )

        const bannerSettings: BannerSettings = {
            secondLayerStyleSettings: {
                showCloseButton: true
            }
        }

        for (const [tab, expected] of [
            [SecondLayerTab.services, "SERVICES"],
            [SecondLayerTab.partners, "PARTNERS"]
        ] as const) {
            RNUsercentricsModule.showSecondLayer.mockImplementationOnce(
                (): Promise<any> => Promise.resolve(response)
            )

            const data = await Usercentrics.showSecondLayer(bannerSettings, tab)
            expect(data).toBe(response);

            const calls = RNUsercentricsModule.showSecondLayer.mock.calls;
            expect(calls[calls.length - 1][0]).toEqual({...bannerSettings, tab: expected});
        }
    })

    test('testShowSecondLayerWithTabAndNoOptions', async () => {
        RNUsercentricsModule.showSecondLayer.mockImplementationOnce(
            (): Promise<any> => Promise.resolve(
                new UsercentricsConsentUserResponse("abc", UsercentricsUserInteraction.acceptAll, [])
            )
        )

        await Usercentrics.showSecondLayer(undefined, SecondLayerTab.partners)

        const calls = RNUsercentricsModule.showSecondLayer.mock.calls;
        expect(calls[calls.length - 1][0]).toEqual({tab: "PARTNERS"});
    })

    test('testRestoreUserSession', async () => {
        const readyStatus = new UsercentricsReadyStatus(
            true,
            [
                {
                    templateId: "123",
                    status: false,
                    dataProcessor: "facebook",
                    version: "123",
                    type: 0,
                    isEssential: false,
                    history: [{
                        status: false,
                        timestampInMillis: 123.0,
                        type: 0
                    }],
                    category: "essemtial",
                    isExempt: false,
                }
            ],
          {
              countryCode: "PT",
              regionCode: "PT11",
              isInEU: true,
              isInUS: false,
              isInCalifornia: false
          },
          {
              activeSettingsId: "",
              bannerRequiredAtLocation: false
          }
        )

        RNUsercentricsModule.restoreUserSession.mockImplementationOnce(
            (): Promise<any> => Promise.resolve(readyStatus)
        )

        const data = await Usercentrics.restoreUserSession("abc");
        expect(data).toBe(readyStatus);

        const call = RNUsercentricsModule.restoreUserSession.mock.calls[0][0];
        expect(call).toBe("abc")
    })

    test('testRestoreUserSessionWithError', async () => {
        RNUsercentricsModule.restoreUserSession.mockImplementationOnce(
            (): Promise<any> => Promise.reject("Failed")
        )

        try {
            await Usercentrics.restoreUserSession("abc");
        } catch (e) {
            expect(e).toBe("Failed");
        }

        const call = RNUsercentricsModule.restoreUserSession.mock.calls[0][0];
        expect(call).toBe("abc")
    })

    test('testGetControllerId', async () => {
        RNUsercentricsModule.getControllerId.mockImplementationOnce(
            (): Promise<string> => Promise.resolve("abc")
        )

        const data = await Usercentrics.getControllerId();
        expect(data).toBe("abc");
    })

    test('testGetABTestingVariant', async () => {
        RNUsercentricsModule.getABTestingVariant.mockImplementationOnce(
            (): Promise<string> => Promise.resolve("variantA")
        )

        const data = await Usercentrics.getABTestingVariant();
        expect(data).toBe("variantA");
    })

    test('testGetABTestingVariant_WhenNull', async () => {
        RNUsercentricsModule.getABTestingVariant.mockImplementationOnce(
            (): Promise<string | null> => Promise.resolve(null)
        )

        const data = await Usercentrics.getABTestingVariant();
        expect(data).toBe(null);
    })

    test('testChangeLanguage', async () => {
        RNUsercentricsModule.changeLanguage.mockImplementationOnce(
            (): Promise<any> => Promise.resolve()
        )

        const data = await Usercentrics.changeLanguage("pt");
        expect(data).toBe(undefined);
    })

    test('testGetConsents', async () => {
        RNUsercentricsModule.getConsents.mockImplementationOnce(
            (): Promise<any> => Promise.resolve([usercentricsServiceConsent])
        )

        const data = await Usercentrics.getConsents();
        expect(data).toStrictEqual([usercentricsServiceConsent]);
    })

    test('testGetCMPData', async () => {
        RNUsercentricsModule.getCMPData.mockImplementationOnce(
            (): Promise<any> => Promise.resolve(cmpDataExample)
        )

        const data = await Usercentrics.getCMPData();
        expect(data).toBe(cmpDataExample);
    })

    test('testGetUserSessionData', async () => {
        RNUsercentricsModule.getUserSessionData.mockImplementationOnce(
            (): Promise<any> => Promise.resolve("abc")
        )

        const data = await Usercentrics.getUserSessionData();
        expect(data).toBe("abc");
    })

    test('testGetCCPAData', async () => {
        RNUsercentricsModule.getUSPData.mockImplementationOnce(
            (): Promise<any> => Promise.resolve(ccpaDataExample)
        )

        const data = await Usercentrics.getCCPAData();
        expect(data).toBe(ccpaDataExample);
    })

    test('testGetTCFData', async () => {
        const response: TCFData = {
            features: featuresExample,
            purposes: purposesExample,
            specialFeatures: [],
            specialPurposes: [],
            stacks: [],
            vendors: [],
            tcString: "ABCD1234",
            thirdPartyCount: 13,
            featuresStandardText: "These means of processing can be used solely in pursuit of one or several purposes for which you are given a choice in this notice."
        }

        RNUsercentricsModule.getTCFData.mockImplementationOnce(
            (): Promise<any> => Promise.resolve(response)
        )

        const data = await Usercentrics.getTCFData();
        expect(data).toStrictEqual(response)
    })

    test('testAcceptAllForTCF', async () => {
        RNUsercentricsModule.acceptAllForTCF.mockImplementationOnce(
            (): Promise<any> => Promise.resolve([usercentricsServiceConsent])
        )

        const data = await Usercentrics.acceptAllForTCF(TCFDecisionUILayer.firstLayer, UsercentricsConsentType.explicit);
        expect(data).toStrictEqual([usercentricsServiceConsent]);
    })

    test('testDenyAllForTCF', async () => {
        RNUsercentricsModule.denyAllForTCF.mockImplementationOnce(
            (): Promise<any> => Promise.resolve([usercentricsServiceConsent])
        )

        const data = await Usercentrics.denyAllForTCF(TCFDecisionUILayer.firstLayer, UsercentricsConsentType.explicit);
        expect(data).toStrictEqual([usercentricsServiceConsent]);
    })

    test('testAcceptAll', async () => {
        RNUsercentricsModule.acceptAll.mockImplementationOnce(
            (): Promise<any> => Promise.resolve([usercentricsServiceConsent])
        )

        const data = await Usercentrics.acceptAll(UsercentricsConsentType.explicit);
        expect(data).toStrictEqual([usercentricsServiceConsent]);
    })

    test('testDenyAll', async () => {
        RNUsercentricsModule.denyAll.mockImplementationOnce(
            (): Promise<any> => Promise.resolve([usercentricsServiceConsent])
        )

        const data = await Usercentrics.denyAll(UsercentricsConsentType.explicit);
        expect(data).toStrictEqual([usercentricsServiceConsent]);
    })

    test('testSaveOptOutForCCPA', async () => {
        RNUsercentricsModule.saveOptOutForCCPA.mockImplementationOnce(
            (): Promise<any> => Promise.resolve([usercentricsServiceConsent])
        )

        const data = await Usercentrics.saveOptOutForCCPA(false, UsercentricsConsentType.explicit);
        expect(data).toStrictEqual([usercentricsServiceConsent]);
    })

    test('testSaveDecisions', async () => {
        RNUsercentricsModule.saveDecisions.mockImplementationOnce(
            (): Promise<any> => Promise.resolve([usercentricsServiceConsent])
        )

        const data = await Usercentrics.saveDecisions([userDecision], UsercentricsConsentType.explicit);
        expect(data).toStrictEqual([usercentricsServiceConsent]);
    })

    test('testSaveDecisionsForTCF', async () => {
        RNUsercentricsModule.saveDecisionsForTCF.mockImplementationOnce(
            (): Promise<any> => Promise.resolve([usercentricsServiceConsent])
        )

        const data = await Usercentrics.saveDecisionsForTCF(
            {
                purposes: tcfUserDecisionOnPurposeExample,
                specialFeatures: tcfUserDecisionOnSpecialFeatureExample,
                vendors: tcfUserDecisionOnVendorExample,
                adTechProviders: adTechProviderDecisionExample
            },
            TCFDecisionUILayer.firstLayer,
            [userDecision],
            UsercentricsConsentType.explicit
        );

        expect(data).toStrictEqual([usercentricsServiceConsent]);
    })

    test('testGetGPPData', async () => {
        RNUsercentricsModule.getGPPData.mockImplementationOnce(
            (): Promise<any> => Promise.resolve(gppDataExample)
        )

        const data = await Usercentrics.getGPPData();
        expect(data).toBe(gppDataExample);
    })

    test('testGetGPPString', async () => {
        RNUsercentricsModule.getGPPString.mockImplementationOnce(
            (): Promise<any> => Promise.resolve("DBABMA~CPXxRfA")
        )

        const data = await Usercentrics.getGPPString();
        expect(data).toBe("DBABMA~CPXxRfA");
    })

    test('testSetGPPConsent', async () => {
        await Usercentrics.setGPPConsent("usnat", "SaleOptOut", 2);

        const call = RNUsercentricsModule.setGPPConsent.mock.calls[0];
        expect(call[0]).toBe("usnat");
        expect(call[1]).toBe("SaleOptOut");
        expect(call[2]).toEqual({ value: 2 });
    })

    test('testTrack', async () => {
        await Usercentrics.track(UsercentricsAnalyticsEventType.acceptAllFirstLayer);
        let spy = jest.spyOn(RNUsercentricsModule, "track")
        expect(spy).toHaveBeenCalledTimes(1);
    })

    test('testGetAdditionalConsentModeData', async () => {
        const response: AdditionalConsentModeData = {
            acString: '2~43.46.55~dv.',
            adTechProviders: [
                {
                    id: 1,
                    name: 'provider',
                    consent: false,
                    privacyPolicyUrl: 'https://'
                }
            ]
        }

        RNUsercentricsModule.getAdditionalConsentModeData.mockImplementationOnce(
            (): Promise<any> => Promise.resolve(response)
        )

        const data = await Usercentrics.getAdditionalConsentModeData();
        expect(data).toStrictEqual(response)
    })

    test('testGetDpsMetadataWithValidData', async () => {
        const metadata = { partner: "appsflyer", source: "campaign_1" };
        RNUsercentricsModule.getDpsMetadata.mockImplementationOnce(
            (): Promise<any> => Promise.resolve(metadata)
        )

        const data = await Usercentrics.getDpsMetadata("templateId123");
        expect(data).toStrictEqual(metadata);

        const call = RNUsercentricsModule.getDpsMetadata.mock.calls[0][0];
        expect(call).toBe("templateId123");
    })

    test('testGetDpsMetadataWhenNull', async () => {
        RNUsercentricsModule.getDpsMetadata.mockImplementationOnce(
            (): Promise<any> => Promise.resolve(null)
        )

        const data = await Usercentrics.getDpsMetadata("nonExistentId");
        expect(data).toBe(null);
    })

    test('testGetDpsMetadataWithEmptyObject', async () => {
        RNUsercentricsModule.getDpsMetadata.mockImplementationOnce(
            (): Promise<any> => Promise.resolve({})
        )

        const data = await Usercentrics.getDpsMetadata("templateId123");
        expect(data).toStrictEqual({});
    })

    test('testClearUserSession', async () => {
        const readyStatus = new UsercentricsReadyStatus(
          true,
          [
              {
                  templateId: "123",
                  status: false,
                  dataProcessor: "facebook",
                  version: "123",
                  type: 0,
                  isEssential: false,
                  history: [{
                      status: false,
                      timestampInMillis: 123.0,
                      type: 0
                  }],
                  category: "essemtial",
                  isExempt: false,
              }
          ],
          {
              countryCode: "PT",
              regionCode: "PT11",
              isInEU: true,
              isInUS: false,
              isInCalifornia: false
          },
          {
              activeSettingsId: "",
              bannerRequiredAtLocation: false
          }
        )

        RNUsercentricsModule.clearUserSession.mockImplementationOnce(
          (): Promise<any> => Promise.resolve(readyStatus)
        )

        const data = await Usercentrics.clearUserSession();
        expect(data).toBe(readyStatus);
    })

    test('testClearUserSessionWithError', async () => {
        RNUsercentricsModule.restoreUserSession.mockImplementationOnce(
          (): Promise<any> => Promise.reject("Failed")
        )

        try {
            await Usercentrics.clearUserSession();
        } catch (e) {
            expect(e).toBe("Failed");
        }
    })

    test('testNotifySubscriptionLapsed', async () => {
        RNUsercentricsModule.notifySubscriptionLapsed.mockImplementationOnce(
          (): Promise<any> => Promise.resolve()
        )

        await Usercentrics.notifySubscriptionLapsed();
        expect(RNUsercentricsModule.notifySubscriptionLapsed).toHaveBeenCalled();
    })

    test('testNotifySubscriptionLapsedWithError', async () => {
        RNUsercentricsModule.notifySubscriptionLapsed.mockImplementationOnce(
          (): Promise<any> => Promise.reject("Failed")
        )

        try {
            await Usercentrics.notifySubscriptionLapsed();
        } catch (e) {
            expect(e).toBe("Failed");
        }
    })

    // The native side answers with a plain map, so the fixtures are plain objects too
    const publisherDecision = (
        band: UsercentricsAgeBand,
        ageLower: number | null,
        ageUpper: number | null
    ): UsercentricsAgeSignalDecision => ({
        source: UsercentricsAgeSignalSource.publisherProvided,
        trust: UsercentricsAgeSignalTrust.publisherProvided,
        band,
        ageLower,
        ageUpper,
        unavailableReason: null,
        isAvailable: true
    })

    const lastSetAgeSignalPayload = () => {
        const calls = RNUsercentricsModule.setAgeSignal.mock.calls;
        return calls[calls.length - 1][0];
    }

    test('testSetAgeSignalAtLeast', async () => {
        const decision = publisherDecision(UsercentricsAgeBand.minor, 16, null)
        RNUsercentricsModule.setAgeSignal.mockImplementationOnce(
            (): Promise<any> => Promise.resolve(decision)
        )

        const data = await Usercentrics.setAgeSignal(UsercentricsPublisherAgeSignal.atLeast(16, "my-age-gate"))
        expect(data).toBe(decision);

        const payload = lastSetAgeSignalPayload();
        expect(payload).toEqual({kind: "atLeast", age: 16, sourceLabel: "my-age-gate"});
        expect(Object.keys(payload).sort()).toEqual(["age", "kind", "sourceLabel"]);
    })

    test('testSetAgeSignalBelowWithoutLabel', async () => {
        const decision = publisherDecision(UsercentricsAgeBand.belowMinimum, null, 15)
        RNUsercentricsModule.setAgeSignal.mockImplementationOnce(
            (): Promise<any> => Promise.resolve(decision)
        )

        const data = await Usercentrics.setAgeSignal(UsercentricsPublisherAgeSignal.below(16))
        expect(data).toBe(decision);

        // A signal without a label sends no label key at all, not even an undefined one
        const payload = lastSetAgeSignalPayload();
        expect(payload).toEqual({kind: "below", age: 16});
        expect(Object.keys(payload).sort()).toEqual(["age", "kind"]);
    })

    test('testSetAgeSignalBetween', async () => {
        const decision = publisherDecision(UsercentricsAgeBand.minor, 13, 15)
        RNUsercentricsModule.setAgeSignal.mockImplementationOnce(
            (): Promise<any> => Promise.resolve(decision)
        )

        const data = await Usercentrics.setAgeSignal(UsercentricsPublisherAgeSignal.between(13, 15, "gate.v2_A-1"))
        expect(data).toBe(decision);

        const payload = lastSetAgeSignalPayload();
        expect(payload).toEqual({kind: "between", lower: 13, upper: 15, sourceLabel: "gate.v2_A-1"});
        expect(Object.keys(payload).sort()).toEqual(["kind", "lower", "sourceLabel", "upper"]);
    })

    test('testSetAgeSignalTransportsWhatTheNativeSdkMustJudge', async () => {
        // The bridge only transports: the ages and the label are checked by the native SDK, not here
        let signal: UsercentricsPublisherAgeSignal | undefined
        expect(() => {
            signal = UsercentricsPublisherAgeSignal.between(121, -1, "not a valid label!")
        }).not.toThrow()

        RNUsercentricsModule.setAgeSignal.mockImplementationOnce(
            (): Promise<any> => Promise.resolve(publisherDecision(UsercentricsAgeBand.standard, 121, -1))
        )
        await Usercentrics.setAgeSignal(signal!)

        expect(lastSetAgeSignalPayload()).toEqual({
            kind: "between", lower: 121, upper: -1, sourceLabel: "not a valid label!"
        });
    })

    test('testSetAgeSignalWaitsForTheSdkToBeReady', async () => {
        let markReady: () => void = () => {}
        RNUsercentricsModule.isReady.mockImplementationOnce(
            (): Promise<void> => new Promise<void>((resolve) => {
                markReady = resolve
            })
        )
        RNUsercentricsModule.setAgeSignal.mockClear()
        RNUsercentricsModule.setAgeSignal.mockImplementationOnce(
            (): Promise<any> => Promise.resolve(publisherDecision(UsercentricsAgeBand.minor, 16, null))
        )

        const pending = Usercentrics.setAgeSignal(UsercentricsPublisherAgeSignal.atLeast(16))
        for (let tick = 0; tick < 5; tick++) {
            await Promise.resolve()
        }
        expect(RNUsercentricsModule.setAgeSignal).not.toHaveBeenCalled();

        markReady()
        await pending
        expect(RNUsercentricsModule.setAgeSignal).toHaveBeenCalledTimes(1);
    })

    test('testSetAgeSignalWithDecisionWithoutBand', async () => {
        // A publisher signal always gets a band today, but the model allows "no signal" (platform signals use it)
        const decision: UsercentricsAgeSignalDecision = {
            source: UsercentricsAgeSignalSource.googlePlayAgeSignals,
            trust: null,
            band: null,
            ageLower: null,
            ageUpper: null,
            unavailableReason: UsercentricsAgeSignalUnavailableReason.notShared,
            isAvailable: false
        }

        RNUsercentricsModule.setAgeSignal.mockImplementationOnce(
            (): Promise<any> => Promise.resolve(decision)
        )

        const data = await Usercentrics.setAgeSignal(UsercentricsPublisherAgeSignal.atLeast(16))

        // The nulls reach the app as nulls, and a missing band is "no signal", never an adult
        expect(data).toBe(decision);
        expect(data.trust).toBeNull();
        expect(data.band).toBeNull();
        expect(data.ageLower).toBeNull();
        expect(data.ageUpper).toBeNull();
        expect(data.unavailableReason).toBe("NOT_SHARED");
        expect(data.isAvailable).toBe(false);
    })

    test('testSetAgeSignalDecisionIsAvailableWhenThereIsABand', () => {
        for (const band of Object.values(UsercentricsAgeBand)) {
            expect(publisherDecision(band, 16, null).isAvailable).toBe(true);
        }
    })

    test('testSetAgeSignalRejectsWithTheNativeError', async () => {
        const error = new Error("Invalid age signal: an age is not between 0 and 120")
        RNUsercentricsModule.setAgeSignal.mockImplementationOnce(
            (): Promise<any> => Promise.reject(error)
        )

        // The very same error: nothing is swallowed, re-worded or wrapped on the way
        await expect(Usercentrics.setAgeSignal(UsercentricsPublisherAgeSignal.atLeast(121))).rejects.toBe(error);
    })

    test('testSetAgeSignalNeverLogsTheSignalOrTheDecision', async () => {
        const spies = (["log", "info", "warn", "error", "debug"] as const).map(
            (method) => jest.spyOn(globalThis.console, method).mockImplementation(() => {})
        )

        try {
            RNUsercentricsModule.setAgeSignal.mockImplementationOnce(
                (): Promise<any> => Promise.resolve(publisherDecision(UsercentricsAgeBand.minor, 16, null))
            )
            await Usercentrics.setAgeSignal(UsercentricsPublisherAgeSignal.atLeast(16, "my-age-gate"))

            RNUsercentricsModule.setAgeSignal.mockImplementationOnce(
                (): Promise<any> => Promise.reject(new Error("Invalid age signal: it has no age"))
            )
            await expect(Usercentrics.setAgeSignal(UsercentricsPublisherAgeSignal.atLeast(16))).rejects.toThrow();

            spies.forEach((spy) => expect(spy).not.toHaveBeenCalled())
        } finally {
            spies.forEach((spy) => spy.mockRestore())
        }
    })

    test('testAgeSignalEnumsUseTheNativeNames', () => {
        expect(Object.values(UsercentricsAgeBand)).toEqual([
            "BELOW_MINIMUM", "MINOR", "STANDARD"
        ]);
        expect(Object.values(UsercentricsAgeSignalSource)).toEqual([
            "APPLE_DECLARED_AGE_RANGE", "GOOGLE_PLAY_AGE_SIGNALS", "PUBLISHER_PROVIDED"
        ]);
        expect(Object.values(UsercentricsAgeSignalTrust)).toEqual([
            "SELF_DECLARED", "GUARDIAN_DECLARED", "VERIFIED", "PUBLISHER_PROVIDED"
        ]);
        expect(Object.values(UsercentricsAgeSignalUnavailableReason)).toEqual([
            "DECLINED", "NOT_SHARED", "VERIFICATION_REQUIRED", "UNSUPPORTED", "NOT_AVAILABLE",
            "INVALID_REQUEST", "TRANSIENT_ERROR", "TIMEOUT", "ERROR"
        ]);
    })
})
