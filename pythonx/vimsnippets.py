import vim
faker_imported = False
lorem_imported = False
try:
    from faker import Faker
    faker_imported = True
except Exception:
    pass

try:
    import lorem
    lorem_imported = True
except Exception:
    pass


def _parse_comments(s):
    """ Parses vim's comments option to extract comment format """
    i = iter(s.split(","))

    rv = []
    try:
        while True:
            # get the flags and text of a comment part
            flags, text = next(i).split(':', 1)

            if len(flags) == 0:
                rv.append(('OTHER', text, text, text, ""))
            # parse 3-part comment, but ignore those with O flag
            elif 's' in flags and 'O' not in flags:
                ctriple = ["TRIPLE"]
                indent = ""

                if flags[-1] in string.digits:
                    indent = " " * int(flags[-1])
                ctriple.append(text)

                flags, text = next(i).split(':', 1)
                assert flags[0] == 'm'
                ctriple.append(text)

                flags, text = next(i).split(':', 1)
                assert flags[0] == 'e'
                ctriple.append(text)
                ctriple.append(indent)

                rv.append(ctriple)
            elif 'b' in flags:
                if len(text) == 1:
                    rv.insert(0, ("SINGLE_CHAR", text, text, text, ""))
    except StopIteration:
        return rv


def get_comment_format():
    """ Returns a 4-element tuple (first_line, middle_lines, end_line, indent)
    representing the comment format for the current file.
    It first looks at the 'commentstring', if that ends with %s, it uses that.
    Otherwise it parses '&comments' and prefers single character comment
    markers if there are any.
    """
    commentstring = vim.eval("&commentstring")
    if commentstring.endswith("%s"):
        c = commentstring[:-2]
        return (c, c, c, "")
    comments = _parse_comments(vim.eval("&comments"))
    for c in comments:
        if c[0] == "SINGLE_CHAR":
            return c[1:]
    return comments[0][1:]


def make_box(twidth, bwidth=None):
    b, m, e, i = (s.strip() for s in get_comment_format())
    bwidth_inner = bwidth - 3 - max(len(b), len(i + e)) if bwidth else twidth + 2
    sline = b + m + bwidth_inner * m[0] + 2 * m[0]
    nspaces = (bwidth_inner - twidth) // 2
    mlines = i + m + " " + " " * nspaces
    mlinee = " " + " "*(bwidth_inner - twidth - nspaces) + m
    eline = i + m + bwidth_inner * m[0] + 2 * m[0] + e
    return sline, mlines, mlinee, eline


def foldmarker():
    "Return a tuple of (open fold marker, close fold marker)"
    return vim.eval("&foldmarker").split(",")


# Get Lorem ipsum given certain number of sentences or paragraphs. The number
# of paragraphs overrides sentences if both are given.
# from faker import Faker
def get_lorem(snip, paragraphs=1, join_with='\n\n'):
    if not snip.c:
        snip.rv = join_with.join([lorem.paragraph().strip() for x in range(paragraphs)]+['\n'])
    else:
        snip.rv = snip.c


def get_file_path(snip, category=None, depth=2):
    if not snip.c:
        f = Faker()
        snip.rv = f.file_path(depth=depth, category=category)
    else:
        snip.rv = snip.c
