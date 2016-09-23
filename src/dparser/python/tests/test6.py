# replaces the '%' symbol with '+', leaving the return values of actions usable for other things, such as type information,
# and leaving whitespace intact.

from dparser import Parser

# turn a tree of strings into a single string (slowly):
def stringify(s):
    if not isinstance(s, str):
        return ''.join(map(stringify, s))
    return s

def d_add1(t, s):
    "add : add '%' exp"
    s[1] = '+ '             # replace the % with +

def d_add2(t, s):
    "add : exp"

def d_exp(t):
    'exp : "[0-9]+" '

# if the start action specifies the 's' argument, then parser
# will contain a member, s, 

parser = Parser()
parsedmessage = parser.parse('1 % 2 % 3')
if stringify(parsedmessage.getStringLeft()) != '1 + 2 + 3':
    print 'error'
