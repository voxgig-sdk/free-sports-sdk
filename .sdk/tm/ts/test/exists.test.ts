
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { FreeSportsSDK } from '..'


describe('exists', async () => {

  test('test-mode', async () => {
    const testsdk = await FreeSportsSDK.test()
    equal(null !== testsdk, true)
  })

})
