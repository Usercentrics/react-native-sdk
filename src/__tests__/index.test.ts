import {
  NativeModules,
} from 'react-native';
import { UsercentricsLoggerLevel, UsercentricsOptions, UsercentricsReadyStatus } from '../models';
import { Usercentrics } from '../Usercentrics';

const { RNUsercentricsModule } = NativeModules;

jest.mock("react-native", () => {
  const RN = jest.requireActual("react-native");

  RN.NativeModules.RNUsercentricsModule = {
    configure: jest.fn(),
    isReady: jest.fn()
  };

  return RN
})

describe('Test Usercentrics Module', () => {
  test('testConfigureBridge', () => {
    const spy = jest.spyOn(RNUsercentricsModule, "configure");
    const options = new UsercentricsOptions("abc", "abc", UsercentricsLoggerLevel.debug, 123, "1.2.3");

    Usercentrics.configure(options);

    expect(spy).toHaveBeenCalledTimes(1);

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

    const spy = jest.spyOn(RNUsercentricsModule, "isReady");
    const data = await Usercentrics.status();
    expect(spy).toHaveBeenCalledTimes(1);
    expect(data).toBe(readyStatus);
  })
})