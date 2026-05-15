
import { Context } from './Context'


class FreeSportsError extends Error {

  isFreeSportsError = true

  sdk = 'FreeSports'

  code: string
  ctx: Context

  constructor(code: string, msg: string, ctx: Context) {
    super(msg)
    this.code = code
    this.ctx = ctx
  }

}

export {
  FreeSportsError
}

