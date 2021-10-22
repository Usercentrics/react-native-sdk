import {
  NativeModules,
} from 'react-native';
import { UsercentricsConsentUserResponse, UsercentricsFont, UsercentricsLoggerLevel, UsercentricsLogo, UsercentricsOptions, UsercentricsReadyStatus, UsercentricsUIOptions, UsercentricsUserInteraction } from '../models';
import { Usercentrics } from '../Usercentrics';

const { RNUsercentricsModule } = NativeModules;

jest.mock("react-native", () => {
  const RN = jest.requireActual("react-native");

  RN.NativeModules.RNUsercentricsModule = {
    configure: jest.fn(),
    isReady: jest.fn(),
    showCMP: jest.fn(),
    restoreUserSession: jest.fn(),
    getControllerId: jest.fn(),
    getTCFString: jest.fn(),
    reset: jest.fn()
  };

  return RN
})

describe('Test Usercentrics Module', () => {
  test('testConfigureBridge', () => {
    const options = new UsercentricsOptions("abc", "abc", UsercentricsLoggerLevel.debug, 123, "1.2.3");
    Usercentrics.configure(options);
    const call = RNUsercentricsModule.configure.mock.calls[0][0];
    expect(call).toBe(options)
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
          type: 0
        }
      ]
    )

    RNUsercentricsModule.isReady.mockImplementationOnce(
      (): Promise<UsercentricsReadyStatus> => Promise.resolve(readyStatus)
    )

    const data = await Usercentrics.status();
    expect(data).toBe(readyStatus);
  })
  
  test('testStatusWithError', async () => {
    RNUsercentricsModule.isReady.mockImplementationOnce(
      (): Promise<UsercentricsReadyStatus> => Promise.reject("Failed")
    )

    try { 
      await Usercentrics.status();
    } catch(e) { 
      expect(e).toBe("Failed");
    }
  })

  test('testShowCMP', async () => {
    const response = new UsercentricsConsentUserResponse(
      "abc",
      UsercentricsUserInteraction.acceptAll,
      [
        {
          templateId: "123",
          status: false,
          dataProcessor: "facebook",
          version: "123",
          type: 0
        }
      ]
    )

    RNUsercentricsModule.showCMP.mockImplementationOnce(
      (): Promise<UsercentricsConsentUserResponse> => Promise.resolve(response)
    )

    const image = { height: 0, width: 0, scale: 0, uri: "abc"} 
    const logo = new UsercentricsLogo("abc", image)
    const font = new UsercentricsFont("abc", 16)
    const option = new UsercentricsUIOptions(false, logo, font)

    const data = await Usercentrics.showCMP(option)
    expect(data).toBe(response);

    const call = RNUsercentricsModule.showCMP.mock.calls[0][0];
    expect(call).toBe(option)
  })

  test('testShowCMPWithError', async () => {
    RNUsercentricsModule.showCMP.mockImplementationOnce(
      (): Promise<UsercentricsConsentUserResponse> => Promise.reject("Failure")
    )

    const image = { height: 0, width: 0, scale: 0, uri: "abc"} 
    const logo = new UsercentricsLogo("abc", image)
    const font = new UsercentricsFont("abc", 16)
    const option = new UsercentricsUIOptions(false, logo, font)

    try { 
      await Usercentrics.showCMP(option);
    } catch(e) { 
      expect(e).toBe("Failure");
    }
  })

  test('testRestoreUserSession', async() => {
    const readyStatus = new UsercentricsReadyStatus(
      true,
      [
        {
          templateId: "123",
          status: false,
          dataProcessor: "facebook",
          version: "123",
          type: 0
        }
      ]
    )

    RNUsercentricsModule.restoreUserSession.mockImplementationOnce(
      (): Promise<UsercentricsReadyStatus> => Promise.resolve(readyStatus)
    )

    const data = await Usercentrics.restoreUserSession("abc");
    expect(data).toBe(readyStatus);

    const call = RNUsercentricsModule.restoreUserSession.mock.calls[0][0];
    expect(call).toBe("abc")
  })

  test('testRestoreUserSessionWithError', async() => {
    RNUsercentricsModule.restoreUserSession.mockImplementationOnce(
      (): Promise<UsercentricsReadyStatus> => Promise.reject("Failed")
    )

    try {
      await Usercentrics.restoreUserSession("abc");
    } catch (e) {
      expect(e).toBe("Failed");
    }

    const call = RNUsercentricsModule.restoreUserSession.mock.calls[0][0];
    expect(call).toBe("abc")
  })

  test('testGetControllerId', async() => {
    RNUsercentricsModule.getControllerId.mockImplementationOnce(
      (): Promise<string> => Promise.resolve("abc")
    )


    const data = await Usercentrics.getControllerId();
    expect(data).toBe("abc");
  })

  test('testGetTCFString', async() => {
    RNUsercentricsModule.getTCFString.mockImplementationOnce(
      (): Promise<string> => Promise.resolve("abc")
    )

    const data = await Usercentrics.getTCFString();
    expect(data).toBe("abc");
  })

  test('testReset', async() => {
    Usercentrics.reset();
    let spy = jest.spyOn(RNUsercentricsModule, "reset")
    expect(spy).toHaveBeenCalledTimes(1)
  })
})