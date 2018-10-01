import vim


def compB(t, opts):
    if not t:
        return "({})".format('|'.join(opts))
    opts = [m[len(t):] for m in opts if m.startswith(t)]
    if len(opts) == 1:
        return opts[0]


# def selector(*args, **kwargs):
def selector(current_text, opts, sep='/'):
    opts = opts.split(sep)
    text_pos = len(current_text)
    opts = list(filter(lambda m: m.startswith(current_text), opts))
    if len(opts) == 1:
        return opts[0][text_pos:]
    else:
        return "({})".format('|'.join(opts))


def expand(snip):
    if snip.tabstop != 1:
        return
    vim.eval('feedkeys("\<C-R>=UltiSnips#ExpandSnippet()\<CR>")')
