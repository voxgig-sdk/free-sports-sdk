# FreeSports SDK utility: make_context

from core.context import FreeSportsContext


def make_context_util(ctxmap, basectx):
    return FreeSportsContext(ctxmap, basectx)
